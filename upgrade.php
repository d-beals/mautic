<?php

ini_set('display_errors', 'Off');
date_default_timezone_set('UTC');

// Running this script standalone is no longer supported
$standalone = 0;
$task       = getVar('task');

define('IN_CLI', 'cli' === php_sapi_name());
define('MAUTIC_ROOT', (IN_CLI || empty($task)) ? __DIR__ : dirname(__DIR__));
define('MAUTIC_APP_ROOT', MAUTIC_ROOT.'/app');

if (IN_CLI) {
    if (!file_exists(__DIR__.'/upgrade')) {
        mkdir(__DIR__.'/upgrade');
    }
    define('MAUTIC_UPGRADE_ROOT', __DIR__.'/upgrade');
} else {
    define('MAUTIC_UPGRADE_ROOT', __DIR__);
}

// Fail-safe PHP version check
if (file_exists(MAUTIC_UPGRADE_ROOT.'/app/release_metadata.json')) {
    $metadata = json_decode(file_get_contents(MAUTIC_UPGRADE_ROOT.'/app/release_metadata.json'), true);

    // Are we running the minimum version?
    if (version_compare(PHP_VERSION, $metadata['minimum_php_version'], 'lt')) {
        echo 'Your server does not meet the minimum PHP requirements. Mautic requires PHP version '.$metadata['minimum_php_version'].' while your server has '
            .PHP_VERSION.'. Please contact your host to update your PHP installation.'."\n";
        exit;
    }

    // Are we running a version newer than what Mautic supports?
    if (version_compare(PHP_VERSION, $metadata['maximum_php_version'], 'gt')) {
        echo 'Mautic does not support PHP version '.PHP_VERSION.' at this time. To use Mautic, you will need to downgrade to an earlier version.'
            ."\n";
        exit;
    }
}

// Get local parameters
$localParameters = get_local_config();
$cacheDir        = (isset($localParameters['cache_path'])) ? str_replace('%kernel.project_dir%', MAUTIC_ROOT, $localParameters['cache_path'].'/prod') : MAUTIC_ROOT.'/var/cache/prod';
$logDir          = (isset($localParameters['log_path'])) ? str_replace('%kernel.project_dir%', MAUTIC_ROOT, $localParameters['log_path'].'/prod') : MAUTIC_ROOT.'/var/logs';

define('MAUTIC_CACHE_DIR', $cacheDir);
define('MAUTIC_UPGRADE_ERROR_LOG', $logDir.'/upgrade_errors.php');

/*
 * Updating to 2.8.1: Check to see if we have a mautic_session_name
 * and use that to populate the actual session name that will be
 * generated after a successful update.
 */
if (isset($_COOKIE['mautic_session_name'])) {
    $sessionValue = $_COOKIE[$_COOKIE['mautic_session_name']];

    include MAUTIC_APP_ROOT.'/config/paths.php';
    $localConfigPath = str_replace('%kernel.project_dir%', MAUTIC_ROOT, $paths['local_config']);

    $newSessionName = md5(md5($localConfigPath).$localParameters['secret_key']);

    setcookie($newSessionName, $sessionValue, 0, '/', '', false, true);

    unset($_COOKIE['mautic_session_name']);
    setcookie('mautic_session_name', '', -1);
}

// Fetch the update state out of the request if applicable
$state = json_decode(base64_decode(getVar('updateState', 'W10=')), true);

// Prime the state if it's empty
if (empty($state)) {
    $state['pluginComplete'] = false;
    $state['bundleComplete'] = false;
    $state['cacheComplete']  = false;
    $state['coreComplete']   = false;
    $state['vendorComplete'] = false;
}
$status = ['complete' => false, 'error' => false, 'updateState' => $state, 'stepStatus' => 'In Progress'];

if (IN_CLI) {
    echo "Upgrading through upgrade.php using the CLI is no longer supported. Please use 'php bin/console mautic:update:find' instead. \n";
    exit(1);
}

// Web request upgrade
$request         = explode('?', $_SERVER['REQUEST_URI'])[0];
$url             = "//{$_SERVER['HTTP_HOST']}{$request}";
$isSSL           = (!empty($_SERVER['HTTPS']) && 'off' != $_SERVER['HTTPS']);
$cookie_path     = (isset($localParameters['cookie_path'])) ? $localParameters['cookie_path'] : '/';
$cookie_domain   = (isset($localParameters['cookie_domain'])) ? $localParameters['cookie_domain'] : '';
$cookie_secure   = (isset($localParameters['cookie_secure'])) ? $localParameters['cookie_secure'] : $isSSL;
$cookie_httponly = (isset($localParameters['cookie_httponly'])) ? $localParameters['cookie_httponly'] : false;

setcookie('mautic_update', $task, time() + 300, $cookie_path, $cookie_domain, $cookie_secure, $cookie_httponly);
$query    = '';
$maxCount = 5;

switch ($task) {
    case '':
        html_body("<div class='well text-center'>This script cannot run standalone. Please log into Mautic to check for updates.</div>");

        // no break
    case 'moveBundles':
        $status = move_mautic_bundles($status, $maxCount);
        if (empty($status['complete'])) {
            if (!isset($state['refresh_count'])) {
                $state['refresh_count'] = 1;
            }
            $nextTask = 'moveBundles';
            $query    = 'count='.$state['refresh_count'].'&';
            ++$state['refresh_count'];
        } else {
            $nextTask = 'moveCore';
            unset($state['refresh_count']);
        }
        break;

    case 'moveCore':
        $status   = move_mautic_core($status);
        $nextTask = 'moveVendors';
        break;

    case 'moveVendors':
        $status   = move_mautic_vendors($status, $maxCount);
        $nextTask = (!empty($status['complete'])) ? 'clearCache' : 'moveVendors';

        if (empty($status['complete'])) {
            if (!isset($state['refresh_count'])) {
                $state['refresh_count'] = 1;
            }
            $nextTask = 'moveVendors';
            $query    = 'count='.$state['refresh_count'].'&';
            ++$state['refresh_count'];
        } else {
            $nextTask = 'clearCache';
            unset($state['refresh_count']);
        }
        break;

    case 'clearCache':
        clear_mautic_cache();
        $nextTask = 'finish';
        break;

    case 'finish':
        $status['complete']                     = true;
        $status['stepStatus']                   = 'Success';
        $status['nextStep']                     = 'Processing Database Updates';
        $status['nextStepStatus']               = 'In Progress';
        $status['updateState']['cacheComplete'] = true;

        break;

    default:
        $status['error']      = true;
        $status['message']    = 'Invalid task';
        $status['stepStatus'] = 'Failed';
        break;
}

// Request through Mautic's UI
$status['updateState'] = get_state_param($status['updateState']);

send_response($status);

/**
 * Get local parameters.
 *
 * @return mixed
 */
function get_local_config()
{
    static $parameters;

    if (null === $parameters) {
        // Used in paths.php
        $root = MAUTIC_APP_ROOT;

        /** @var array<string> $paths */
        $paths = [];
        include MAUTIC_APP_ROOT.'/config/paths.php';

        // Include local config to get cache_path
        $localConfig = str_replace('%kernel.project_dir%', MAUTIC_ROOT, $paths['local_config']);

        /** @var array<string, mixed> $parameters */
        $parameters = [];
        include $localConfig;

        $localParameters = $parameters;

        // check for parameter overrides
        if (file_exists(MAUTIC_APP_ROOT.'/../config/parameters_local.php')) {
            /** @var array<string, mixed> $parameters */
            include MAUTIC_APP_ROOT.'/../config/parameters_local.php';
            $localParameters = array_merge($localParameters, $parameters);
        }

        foreach ($localParameters as $k => &$v) {
            if (!empty($v) && is_string($v) && preg_match('/getenv\((.*?)\)/', $v, $match)) {
                $v = (string) getenv($match[1]);
            }
        }

        $parameters = $localParameters;
    }

    return $parameters;
}

/**
 * Clears the application cache.
 *
 * Since this script is being executed via web requests and standalone from the Mautic application, we don't have access to Symfony's
 * CLI suite.  So we'll go with Option B in this instance and just nuke the entire production cache and let Symfony rebuild it on the next
 * application cycle.
 *
 * @return bool
 */
function clear_mautic_cache()
{
    if (!recursive_remove_directory(MAUTIC_CACHE_DIR)) {
        process_error_log(['Could not remove the application cache.  You will need to manually delete '.MAUTIC_CACHE_DIR.'.']);

        return false;
    }

    // Follow the same pattern as the console command and flush opcache/apc as appropriate.
    if (function_exists('opcache_reset')) {
        opcache_reset();
    }

    if (function_exists('apcu_clear_cache')) {
        apcu_clear_cache();
    }

    return true;
}

/**
 * Copy a folder.
 *
 * This function is based on \Joomla\Filesystem\Folder:copy()
 *
 * @param string $src  The path to the source folder
 * @param string $dest The path to the destination folder
 *
 * @return array<string>|string|bool True on success, a single error message on a "boot" fail, or an array of errors from the recursive operation
 */
function copy_directory($src, $dest)
{
    @set_time_limit((int) ini_get('max_execution_time'));
    $errorLog = [];

    // Eliminate trailing directory separators, if any
    $src  = rtrim($src, DIRECTORY_SEPARATOR);
    $dest = rtrim($dest, DIRECTORY_SEPARATOR);

    // Make sure the destination exists
    if (!is_dir($dest)) {
        if (!@mkdir($dest, 0777, true)) {
            return sprintf(
                'Could not move files from %s to production since the folder could not be created.',
                str_replace(MAUTIC_UPGRADE_ROOT, '', $src)
            );
        }
    }

    if (!($dh = @opendir($src))) {
        return sprintf('Could not read directory %s to move files.', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
    }

    // Walk through the directory copying files and recursing into folders.
    while (false !== ($file = readdir($dh))) {
        $sfid = $src.'/'.$file;
        $dfid = $dest.'/'.$file;

        switch (filetype($sfid)) {
            case 'dir':
                if ('.' != $file && '..' != $file) {
                    $ret = copy_directory($sfid, $dfid);

                    if (true !== $ret) {
                        if (is_array($ret)) {
                            $errorLog += $ret;
                        } else {
                            $errorLog[] = $ret;
                        }
                    }
                }
                break;

            case 'file':
                if (!@rename($sfid, $dfid)) {
                    $errorLog[] = sprintf('Could not move file %s to production.', str_replace(MAUTIC_UPGRADE_ROOT, '', $sfid));
                }
                break;
        }
    }

    if (!empty($errorLog)) {
        return $errorLog;
    }

    return true;
}

/**
 * Fetches a request variable and returns the sanitized version of it.
 *
 * @param string $name
 * @param string $default
 * @param int    $filter
 *
 * @return mixed|string
 */
function getVar($name, $default = '', $filter = FILTER_SANITIZE_STRING)
{
    if (isset($_REQUEST[$name])) {
        return filter_var($_REQUEST[$name], $filter);
    }

    return $default;
}

/**
 * Moves the Mautic bundles from the upgrade directory to production.
 *
 * A typical update package will only include changed files in the bundles.  However, in this script we will assume that all of
 * the bundle resources are included here and recursively iterate over the bundles in batches to update the filesystem.
 *
 * @param array<mixed> $status
 * @param int          $maxCount
 *
 * @return array<mixed>
 */
function move_mautic_bundles(array $status, $maxCount = 5)
{
    $errorLog = [];

    // First, we will move any addon bundles into position
    if (is_dir(MAUTIC_UPGRADE_ROOT.'/plugins') && !$status['updateState']['pluginComplete']) {
        $iterator = new DirectoryIterator(MAUTIC_UPGRADE_ROOT.'/plugins');

        // Sanity check, make sure there are actually directories here to process
        $dirs = glob(MAUTIC_UPGRADE_ROOT.'/plugins/*', GLOB_ONLYDIR);

        if (count($dirs)) {
            /** @var DirectoryIterator $directory */
            foreach ($iterator as $directory) {
                // Sanity checks
                if (!$directory->isDot() && $directory->isDir()) {
                    $src  = $directory->getPath().'/'.$directory->getFilename();
                    $dest = str_replace(MAUTIC_UPGRADE_ROOT, MAUTIC_ROOT, $src);

                    $result = copy_directory($src, $dest);

                    if (true !== $result) {
                        if (is_array($result)) {
                            $errorLog += $result;
                        } else {
                            $errorLog[] = $result;
                        }
                    }

                    $deleteDir = recursive_remove_directory($src);

                    if (!$deleteDir) {
                        $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
                    }
                }
            }
        }

        // At this point, there shouldn't be any plugins remaining; nuke the folder
        $deleteDir = recursive_remove_directory(MAUTIC_UPGRADE_ROOT.'/plugins');

        if (!$deleteDir) {
            $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', '/plugins');
        }

        process_error_log($errorLog);

        $status['updateState']['pluginComplete'] = true;

        if (-1 != $maxCount) {
            // Finished with plugins, get a response back to the app so we can iterate to the next part
            return $status;
        }
    }

    // Now we move the main app bundles into production
    if (is_dir(MAUTIC_UPGRADE_ROOT.'/app/bundles') && !$status['updateState']['bundleComplete']) {
        // Initialize the bundle state if it isn't
        if (!isset($status['updateState']['completedBundles'])) {
            $status['updateState']['completedBundles'] = [];
        }

        $completed = true;
        $iterator  = new DirectoryIterator(MAUTIC_UPGRADE_ROOT.'/app/bundles');

        // Sanity check, make sure there are actually directories here to process
        $dirs = glob(MAUTIC_UPGRADE_ROOT.'/app/bundles/*', GLOB_ONLYDIR);

        if (count($dirs)) {
            $count = 0;

            /** @var DirectoryIterator $directory */
            foreach ($iterator as $directory) {
                // Exit the loop if the count has reached 5
                if (-1 != $maxCount && $count === $maxCount) {
                    $completed = false;
                    break;
                }

                // Sanity checks
                if (!$directory->isDot() && $directory->isDir()) {
                    // Don't process this bundle if we've already tried it
                    if (isset($status['updateState']['completedBundles'][$directory->getFilename()])) {
                        continue;
                    }

                    $src  = $directory->getPath().'/'.$directory->getFilename();
                    $dest = str_replace(MAUTIC_UPGRADE_ROOT, MAUTIC_ROOT, $src);

                    $result = copy_directory($src, $dest);

                    if (true !== $result) {
                        if (is_array($result)) {
                            $errorLog += $result;
                        } else {
                            $errorLog[] = $result;
                        }
                    }

                    $deleteDir = recursive_remove_directory($src);

                    if (!$deleteDir) {
                        $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
                    }

                    $status['updateState']['completedBundles'][$directory->getFilename()] = true;
                    ++$count;
                }
            }
        }

        if ($completed) {
            $status['updateState']['bundleComplete'] = true;

            // At this point, there shouldn't be any bundles remaining; nuke the folder
            $deleteDir = recursive_remove_directory(MAUTIC_UPGRADE_ROOT.'/app/bundles');

            if (!$deleteDir) {
                $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', '/app/bundles');
            }
        }

        process_error_log($errorLog);

        // If we haven't finished the bundles yet, throw a response back to repeat the step
        if (!$status['updateState']['bundleComplete']) {
            return $status;
        }
    }

    // To get here, all of the bundle updates must have been processed (or there are literally none).  Step complete.
    $status['complete'] = true;

    return $status;
}

/**
 * Moves the Mautic core files that are not part of bundles or vendors into production.
 *
 * The "core" files are broken into groups for purposes of the update script: bundles, vendor, and everything else.  This step
 * will take care of the everything else.
 *
 * @param array<mixed> $status
 *
 * @return array<mixed>
 */
function move_mautic_core(array $status)
{
    $errorLog = [];

    // Multilevel directories
    $nestedDirectories = [
        '/media',
        '/themes',
        '/translations',
        '/app/middlewares',
    ];

    foreach ($nestedDirectories as $dir) {
        if (is_dir(MAUTIC_UPGRADE_ROOT.$dir)) {
            copy_directories($dir, $errorLog);

            // At this point, we can remove the media directory
            $deleteDir = recursive_remove_directory(MAUTIC_UPGRADE_ROOT.$dir);

            if (!$deleteDir) {
                $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', $dir);
            }
        }
    }

    // Single level directories with files only
    $fileOnlyDirectories = [
        '/app/config',
        '/app/migrations',
        '/app',
        '/bin',
    ];

    foreach ($fileOnlyDirectories as $dir) {
        if (copy_files($dir, $errorLog)) {
            // At this point, we can remove the config directory
            $deleteDir = recursive_remove_directory(MAUTIC_UPGRADE_ROOT.$dir);

            if (!$deleteDir) {
                $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', $dir);
            }
        }
    }

    // Now move any root level files
    $iterator = new FilesystemIterator(MAUTIC_UPGRADE_ROOT);

    /** @var FilesystemIterator $file */
    foreach ($iterator as $file) {
        // Sanity checks
        if ($file->isFile() && !in_array($file->getFilename(), ['deleted_files.txt', 'critical_migrations.txt', 'upgrade.php'])) {
            $src  = $file->getPath().'/'.$file->getFilename();
            $dest = str_replace(MAUTIC_UPGRADE_ROOT, MAUTIC_ROOT, $src);

            if (!@rename($src, $dest)) {
                $errorLog[] = sprintf('Could not move file %s to production.', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
            }
        }
    }

    process_error_log($errorLog);

    // In this step, we'll also go ahead and remove deleted files, return the results from that
    return remove_mautic_deleted_files($status);
}

/**
 * Moves the Mautic dependencies from the upgrade directory to production.
 *
 * Since the /vendor folder is not stored under version control, we cannot accurately track changes in third party dependencies
 * between releases.  Therefore, this step will recursively iterate over the vendors in batches to remove each package completely
 * and replace it with the new version.
 *
 * @param array<mixed> $status
 * @param int          $maxCount
 *
 * @return array<mixed>
 */
function move_mautic_vendors(array $status, $maxCount = 5)
{
    $errorLog = [];

    // If there isn't even a vendor directory, just skip this step
    if (!is_dir(MAUTIC_UPGRADE_ROOT.'/vendor')) {
        $status['complete']                      = true;
        $status['stepStatus']                    = 'Success';
        $status['nextStep']                      = 'Clearing Application Cache';
        $status['nextStepStatus']                = 'In Progress';
        $status['updateState']['vendorComplete'] = true;

        return $status;
    }

    // Initialize the vendor state if it isn't
    if (!isset($status['updateState']['completedVendors'])) {
        $status['updateState']['completedVendors'] = [];
    }

    // Symfony is the largest of our vendors, we will process it first
    if (is_dir(MAUTIC_UPGRADE_ROOT.'/vendor/symfony') && !isset($status['updateState']['completedVendors']['symfony'])) {
        // Initialize the Symfony state if it isn't, this step will recurse
        if (!isset($status['updateState']['completedSymfony'])) {
            $status['updateState']['completedSymfony'] = [];
        }

        $completed = true;
        $iterator  = new DirectoryIterator(MAUTIC_UPGRADE_ROOT.'/vendor/symfony');

        // Sanity check, make sure there are actually directories here to process
        $dirs = glob(MAUTIC_UPGRADE_ROOT.'/vendor/symfony/*', GLOB_ONLYDIR);

        if (count($dirs)) {
            $count = 0;

            /** @var DirectoryIterator $directory */
            foreach ($iterator as $directory) {
                // Exit the loop if the count has reached 5
                if (-1 != $maxCount && $count === $maxCount) {
                    $completed = false;
                    break;
                }

                // Sanity checks
                if (!$directory->isDot() && $directory->isDir()) {
                    // Don't process this directory if we've already tried it
                    if (isset($status['updateState']['completedSymfony'][$directory->getFilename()])) {
                        continue;
                    }

                    $src  = $directory->getPath().'/'.$directory->getFilename();
                    $dest = str_replace(MAUTIC_UPGRADE_ROOT, MAUTIC_ROOT, $src);

                    // We'll need to completely remove the existing vendor first
                    recursive_remove_directory($dest);

                    $result = copy_directory($src, $dest);

                    if (true !== $result) {
                        if (is_array($result)) {
                            $errorLog += $result;
                        } else {
                            $errorLog[] = $result;
                        }
                    }

                    $deleteDir = recursive_remove_directory($src);

                    if (!$deleteDir) {
                        $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
                    }

                    $status['updateState']['completedSymfony'][$directory->getFilename()] = true;
                    ++$count;
                }
            }
        }

        if ($completed) {
            $status['updateState']['completedVendors']['symfony'] = true;

            // At this point, there shouldn't be any Symfony code remaining; nuke the folder
            $deleteDir = recursive_remove_directory(MAUTIC_UPGRADE_ROOT.'/vendor/symfony');

            if (!$deleteDir) {
                $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', '/vendor/symfony');
            }
        }

        process_error_log($errorLog);

        // If we haven't finished Symfony yet, throw a response back to repeat the step
        if (!isset($status['updateState']['completedVendors']['symfony'])) {
            return $status;
        }
    }

    // Once we've gotten here, we can safely iterate through the rest of the vendor directory; the rest of the contents are rather small in size
    $completed = true;
    $iterator  = new DirectoryIterator(MAUTIC_UPGRADE_ROOT.'/vendor');

    // Sanity check, make sure there are actually directories here to process
    $dirs = glob(MAUTIC_UPGRADE_ROOT.'/vendor/*', GLOB_ONLYDIR);

    if (count($dirs)) {
        $count = 0;

        /** @var DirectoryIterator $directory */
        foreach ($iterator as $directory) {
            // Exit the loop if the count has reached 5
            if (-1 != $maxCount && $count === $maxCount) {
                $completed = false;
                break;
            }

            // Sanity checks
            if (!$directory->isDot() && $directory->isDir()) {
                // Don't process this directory if we've already tried it
                if (isset($status['updateState']['completedVendors'][$directory->getFilename()])) {
                    continue;
                }

                $src  = $directory->getPath().'/'.$directory->getFilename();
                $dest = str_replace(MAUTIC_UPGRADE_ROOT, MAUTIC_ROOT, $src);

                // We'll need to completely remove the existing vendor first
                recursive_remove_directory($dest);

                $result = copy_directory($src, $dest);

                if (true !== $result) {
                    if (is_array($result)) {
                        $errorLog += $result;
                    } else {
                        $errorLog[] = $result;
                    }
                }

                $deleteDir = recursive_remove_directory($src);

                if (!$deleteDir) {
                    $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
                }

                $status['updateState']['completedVendors'][$directory->getFilename()] = true;
                ++$count;
            }
        }
    }

    if ($completed) {
        $status['updateState']['vendorComplete'] = true;

        // Move the autoload.php file over now
        if (!@rename(MAUTIC_UPGRADE_ROOT.'/vendor/autoload.php', MAUTIC_ROOT.'/vendor/autoload.php')) {
            $errorLog[] = 'Could not move file /vendor/autoload.php to production.';
        }

        // At this point, there shouldn't be any vendors remaining; nuke the folder
        $deleteDir = recursive_remove_directory(MAUTIC_UPGRADE_ROOT.'/vendor');

        if (!$deleteDir) {
            $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', '/vendor');
        }
    }

    process_error_log($errorLog);

    // If we haven't finished the vendors yet, throw a response back to repeat the step
    if (!$status['updateState']['vendorComplete']) {
        return $status;
    }

    // Once we get here, we have finished the moving files step; notifiy Mautic of this
    $status['complete']                      = true;
    $status['stepStatus']                    = 'Success';
    $status['nextStep']                      = 'Clearing Application Cache';
    $status['nextStepStatus']                = 'In Progress';
    $status['updateState']['vendorComplete'] = true;

    return $status;
}

/**
 * Copy files from the directory.
 *
 * @param string        $dir
 * @param array<string> &$errorLog
 *
 * @return bool
 */
function copy_files($dir, &$errorLog)
{
    if (is_dir(MAUTIC_UPGRADE_ROOT.$dir)) {
        $iterator = new FilesystemIterator(MAUTIC_UPGRADE_ROOT.$dir);

        /** @var FilesystemIterator $file */
        foreach ($iterator as $file) {
            // Sanity checks
            if ($file->isFile()) {
                $src  = $file->getPath().'/'.$file->getFilename();
                $dest = str_replace(MAUTIC_UPGRADE_ROOT, MAUTIC_ROOT, $src);

                if (!@rename($src, $dest)) {
                    $errorLog[] = sprintf('Could not move file %s to production.', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
                }
            }
        }

        return true;
    }

    return false;
}

/**
 * Copy directories.
 *
 * @param string        $dir
 * @param array<string> &$errorLog
 * @param bool          $createDest
 */
function copy_directories($dir, &$errorLog, $createDest = true): bool
{
    // Ensure the destination directory exists
    $exists = file_exists(MAUTIC_ROOT.$dir);
    if ($createDest && !$exists) {
        mkdir(MAUTIC_ROOT.$dir, 0755, true);
    } elseif (!$exists) {
        $errorLog[] = sprintf('%s does not exist.', MAUTIC_ROOT.$dir);

        return false;
    }

    // Copy root level files first
    copy_files($dir, $errorLog);

    $iterator = new DirectoryIterator(MAUTIC_UPGRADE_ROOT.$dir);

    /** @var DirectoryIterator $directory */
    foreach ($iterator as $directory) {
        // Sanity checks
        if (!$directory->isDot() && $directory->isDir()) {
            $src  = $directory->getPath().'/'.$directory->getFilename();
            $dest = str_replace(MAUTIC_UPGRADE_ROOT, MAUTIC_ROOT, $src);

            $result = copy_directory($src, $dest);

            if (true !== $result) {
                if (is_array($result)) {
                    $errorLog += $result;
                } else {
                    $errorLog[] = $result;
                }
            }

            $deleteDir = recursive_remove_directory($src);

            if (!$deleteDir) {
                $errorLog[] = sprintf('Failed to remove the upgrade directory %s folder', str_replace(MAUTIC_UPGRADE_ROOT, '', $src));
            }
        }
    }

    return true;
}

/**
 * Processes the error log for each step.
 *
 * @param array<string> $errorLog
 */
function process_error_log(array $errorLog): void
{
    // If there were any errors, add them to the error log
    if (count($errorLog)) {
        // Check if the error log exists first
        if (file_exists(MAUTIC_UPGRADE_ERROR_LOG)) {
            $errors = file_get_contents(MAUTIC_UPGRADE_ERROR_LOG);
        } else {
            $errors = "<?php die('no access'); \n\n";
        }

        $errors .= implode(PHP_EOL, $errorLog)."\n";

        @file_put_contents(MAUTIC_UPGRADE_ERROR_LOG, $errors);
    }
}

/**
 * Tries to recursively delete a directory.
 *
 * This code is based on the recursive_remove_directory function used by Akeeba Restore
 *
 * @param string $directory
 *
 * @return bool
 */
function recursive_remove_directory($directory)
{
    // if the path has a slash at the end we remove it here
    if ('/' == substr($directory, -1)) {
        $directory = substr($directory, 0, -1);
    }

    // if the path is not valid or is not a directory ...
    if (!file_exists($directory)) {
        return true;
    } elseif (!is_dir($directory)) {
        return false;
    // ... if the path is not readable
    } elseif (!is_readable($directory)) {
        // ... we return false and exit the function
        return false;
    // ... else if the path is readable
    } else {
        // we open the directory
        $handle = opendir($directory);

        // and scan through the items inside
        while (false !== ($item = readdir($handle))) {
            // if the filepointer is not the current directory
            // or the parent directory
            if ('.' != $item && '..' != $item) {
                // we build the new path to delete
                $path = $directory.'/'.$item;
                // if the new path is a directory
                if (is_dir($path)) {
                    // we call this function with the new path
                    recursive_remove_directory($path);
                // if the new path is a file
                } else {
                    // we remove the file
                    @unlink($path);
                }
            }
        }

        // close the directory
        closedir($handle);

        // try to delete the now empty directory
        if (!@rmdir($directory)) {
            // return false if not possible
            return false;
        }

        // return success
        return true;
    }
}

/**
 * Removes deleted files from the system.
 *
 * While packaging updates, the script will generate a list of deleted files in comparison to the previous version.  In this step,
 * we will process that list to remove files which are no longer included in the application.
 *
 * @param array<mixed> $status
 *
 * @return array<mixed>
 */
function remove_mautic_deleted_files(array $status)
{
    $errorLog = [];

    // Make sure we have a deleted_files list otherwise we can't process this step
    if (file_exists(MAUTIC_UPGRADE_ROOT.'/deleted_files.txt')) {
        $deletedFiles = json_decode(file_get_contents(MAUTIC_UPGRADE_ROOT.'/deleted_files.txt'), true);

        foreach ($deletedFiles as $file) {
            $path = MAUTIC_ROOT.'/'.$file;

            // If it doesn't exist, don't even bother
            if (file_exists($path)) {
                // Try setting the permissions to 777 just to make sure we can get rid of the file
                @chmod($path, 0777);

                if (!@unlink($path)) {
                    // Failed to delete, reset the permissions to 644 for safety
                    @chmod($path, 0644);

                    $errorLog[] = sprintf(
                        'Failed removing the file at %s from the production path.  As this is a deleted file, you can manually remove this file.',
                        $file
                    );
                } else {
                    // Check to see if directory is now empty and if so, delete it
                    $dirpath = dirname($path);
                    if (file_exists($dirpath) && !glob($dirpath.'/*')) {
                        @chmod($dirpath, 0777);
                        if (!@unlink($dirpath)) {
                            // Failed to delete, reset the permissions to 0755 for safety
                            @chmod($dirpath, 0755);
                        }
                    }
                }
            }
        }
    } else {
        $errorLog[] = 'The file containing the list of deleted files was not found, could not process the deleted file list.';
    }

    process_error_log($errorLog);

    $status['complete']                    = true;
    $status['updateState']['coreComplete'] = true;

    return $status;
}

/**
 * @param array<mixed> $state
 *
 * @return string
 */
function get_state_param(array $state)
{
    return base64_encode(json_encode($state));
}

/**
 * Send the response back to the main application.
 *
 * @param array<mixed> $status
 */
function send_response(array $status): void
{
    header('Content-Type: application/json; charset=utf-8');

    echo json_encode($status);
}

/**
 * Wrap content in some HTML.
 */
function html_body(string $content): void
{
    $html = <<<HTML
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Upgrade Mautic</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
  </head>
  <body>
    <div class="container" style="padding: 25px;">
        $content
    </div>
  </body>
</html>
HTML;

    echo $html;

    exit;
}
