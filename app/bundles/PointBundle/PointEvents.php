<?php

namespace Mautic\PointBundle;

/**
 * Events available for PointBundle.
 */
final class PointEvents
{
    /**
     * The mautic.point_pre_save event is thrown right before a form is persisted.
     *
     * The event listener receives a Mautic\PointBundle\Event\PointEvent instance.
     *
     * @var string
     */
    public const POINT_PRE_SAVE = 'mautic.point_pre_save';

    /**
     * The mautic.point_post_save event is thrown right after a form is persisted.
     *
     * The event listener receives a Mautic\PointBundle\Event\PointEvent instance.
     *
     * @var string
     */
    public const POINT_POST_SAVE = 'mautic.point_post_save';

    /**
     * The mautic.point_pre_delete event is thrown before a form is deleted.
     *
     * The event listener receives a Mautic\PointBundle\Event\PointEvent instance.
     *
     * @var string
     */
    public const POINT_PRE_DELETE = 'mautic.point_pre_delete';

    /**
     * The mautic.point_post_delete event is thrown after a form is deleted.
     *
     * The event listener receives a Mautic\PointBundle\Event\PointEvent instance.
     *
     * @var string
     */
    public const POINT_POST_DELETE = 'mautic.point_post_delete';

    /**
     * The mautic.point_on_build event is thrown before displaying the point builder form to allow adding of custom actions.
     *
     * The event listener receives a Mautic\PointBundle\Event\PointBuilderEvent instance.
     *
     * @var string
     */
    public const POINT_ON_BUILD = 'mautic.point_on_build';

    /**
     * The mautic.point_on_action event is thrown to execute a point action.
     *
     * The event listener receives a Mautic\PointBundle\Event\PointActionEvent instance.
     *
     * @var string
     */
    public const POINT_ON_ACTION = 'mautic.point_on_action';

    /**
     * The mautic.point_pre_save event is thrown right before a form is persisted.
     *
     * The event listener receives a Mautic\PointBundle\Event\TriggerEvent instance.
     *
     * @var string
     */
    public const TRIGGER_PRE_SAVE = 'mautic.trigger_pre_save';

    /**
     * The mautic.trigger_post_save event is thrown right after a form is persisted.
     *
     * The event listener receives a Mautic\PointBundle\Event\TriggerEvent instance.
     *
     * @var string
     */
    public const TRIGGER_POST_SAVE = 'mautic.trigger_post_save';

    /**
     * The mautic.trigger_pre_delete event is thrown before a form is deleted.
     *
     * The event listener receives a Mautic\PointBundle\Event\TriggerEvent instance.
     *
     * @var string
     */
    public const TRIGGER_PRE_DELETE = 'mautic.trigger_pre_delete';

    /**
     * The mautic.trigger_post_delete event is thrown after a form is deleted.
     *
     * The event listener receives a Mautic\PointBundle\Event\TriggerEvent instance.
     *
     * @var string
     */
    public const TRIGGER_POST_DELETE = 'mautic.trigger_post_delete';

    /**
     * The mautic.trigger_on_build event is thrown before displaying the trigger builder form to allow adding of custom actions.
     *
     * The event listener receives a Mautic\PointBundle\Event\TriggerBuilderEvent instance.
     *
     * @var string
     */
    public const TRIGGER_ON_BUILD = 'mautic.trigger_on_build';

    /**
     * The mautic.trigger_on_event_execute event is thrown to execute a trigger event.
     *
     * The event listener receives a Mautic\PointBundle\Event\TriggerExecutedEvent instance.
     *
     * @var string
     */
    public const TRIGGER_ON_EVENT_EXECUTE = 'mautic.trigger_on_event_execute';

    /**
     * The mautic.trigger_on_lead_segments_change event is thrown to change lead's segments.
     *
     * The event listener receives a Mautic\PointBundle\Event\TriggerExecutedEvent instance.
     *
     * @var string
     */
    public const TRIGGER_ON_LEAD_SEGMENTS_CHANGE = 'mautic.trigger_on_lead_segments_change';
}
