<?php

namespace App\Tests;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Manager\SubscriptionManager;
use App\Service\SubscriptionService;
use App\Request\SubscriptionCreateRequest;
use App\Response\SubscriptionResponse;
use App\Tests\fixtures\SubscriptionProvider;
use PHPUnit\Framework\TestCase;

class SubscriptionServiceUnitTest extends TestCase
{
    private $mockManager;
    private $autoMapping;

    protected function setUp()
    {
        $this->mockManager = $this->createMock(SubscriptionManager::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider create
     */
    public function testCreate($expected, $actual)
    {
        $response = new SubscriptionResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->packageID = $expected;
        // $date=new \DateTime("2020-02-02");
        // $response->startDate = $expected;
        // $response->endDate = $expected;
        $response->status = $expected;

        $entity = new SubscriptionEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setPackageID($expected);
        // $entity->setStartDate($actual);
        // $entity->setEndDate($actual);
        $entity->setStatus($actual);

        $request = new SubscriptionCreateRequest();

        $this->mockManager
            ->method('create')
            ->willReturn($entity);

        $service = new SubscriptionService($this->autoMapping, $this->mockManager);

        $this->assertEquals($response, $service->create($request));
    }

    public function create()
    {
        $result = new SubscriptionProvider();
        return $result->create();
    }
}
