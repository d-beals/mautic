<?php

namespace Mautic\CampaignBundle\Tests\EventCollector\Accessor\Event;

use Mautic\CampaignBundle\EventCollector\Accessor\Event\ConditionAccessor;

class ConditionAccessorTest extends \PHPUnit\Framework\TestCase
{
    public function testEventNameIsReturned(): void
    {
        $accessor = new ConditionAccessor(['eventName' => 'test']);

        $this->assertEquals('test', $accessor->getEventName());
    }

    public function testExtraParamIsReturned(): void
    {
        $accessor = new ConditionAccessor(['eventName' => 'test', 'foo' => 'bar']);

        $this->assertEquals(['foo' => 'bar'], $accessor->getExtraProperties());
    }
}
