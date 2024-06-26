<?php

namespace Mautic\EmailBundle\Stats\Helper;

use Mautic\EmailBundle\Stats\FetchOptions\EmailStatOptions;
use Mautic\StatsBundle\Aggregate\Collection\StatCollection;

class SentHelper extends AbstractHelper
{
    public const NAME = 'email-sent';

    public function getName(): string
    {
        return self::NAME;
    }

    /**
     * @throws \Exception
     */
    public function generateStats(\DateTime $fromDateTime, \DateTime $toDateTime, EmailStatOptions $options, StatCollection $statCollection): void
    {
        $useGeneratedColumn = $this->generatedColumnsProvider->generatedColumnsAreSupported() && 'd' == $options->getUnit();
        $column             = $useGeneratedColumn ? 'generated_sent_date' : 'date_sent';
        $query              = $this->getQuery($fromDateTime, $toDateTime);
        $q                  = $query->prepareTimeDataQuery('email_stats', $column, $options->getFilters());

        $this->limitQueryToEmailIds($q, $options->getEmailIds(), 'email_id', 't');

        if (!$options->canViewOthers()) {
            $this->limitQueryToCreator($q);
        }

        $this->addCompanyFilter($q, $options->getCompanyId());
        $this->addCampaignFilter($q, $options->getCampaignId());
        $this->addSegmentFilter($q, $options->getSegmentId());

        $this->fetchAndBindToCollection($q, $statCollection);
    }
}
