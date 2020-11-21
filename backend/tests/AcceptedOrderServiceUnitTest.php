<?php

namespace App\Tests;

use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Manager\AcceptedOrderManager;
use App\Service\AcceptedOrderService;
use App\Request\AcceptedOrderCreateRequest;
use App\Response\AcceptedOrderResponse;
use App\Response\CaptaintotalEarnResponse;
use App\Tests\fixtures\AcceptedOrderProvider;
use PHPUnit\Framework\TestCase;

class AcceptedOrderServiceUnitTest extends TestCase
{
    private $mockManager;
    private $autoMapping;

    protected function setUp()
    {
        $this->mockManager = $this->createMock(AcceptedOrderManager::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider create
     */
    public function testCreate($expected, $actual)
    {
        $response = new AcceptedOrderResponse();
        $response->orderID = $expected;
        $response->captainID = $expected;
        $response->date = $expected;
        $response->cost = $expected;
        $response->state = $expected;

        $entity = new AcceptedOrderEntity();
        $entity->setOrderID($actual);
        $entity->setCaptainID($actual);
        $entity->setDate($actual);
        $entity->setCost($actual);
        $entity->setState($actual);

        $request = new AcceptedOrderCreateRequest();

        $this->mockManager
            ->method('create')
            ->willReturn($entity);

        $service = new AcceptedOrderService($this->autoMapping, $this->mockManager);

        $this->assertEquals($response, $service->create($request));
    }

    public function create()
    {
        $result = new AcceptedOrderProvider();
        return $result->create();
    }

    /**
     * @dataProvider acceptedOrder
     */
    public function testacceptedOrder($expected, $actual)
    {
        $response = new AcceptedOrderResponse();
        $response->id = $expected;
        $response->orderID = $expected;
        $response->captainID = $expected;
        $response->date = $expected;
        $response->cost = $expected;
        $response->state = $expected;

        $entity = new AcceptedOrderEntity();
        $entity->setId($actual);
        $entity->setOrderID($actual);
        $entity->setCaptainID($actual);
        $entity->setDate($actual);
        $entity->setCost($actual);
        $entity->setState($actual);

        $this->mockManager
            ->method('acceptedOrder')
            ->willReturn($entity);

        $service = new AcceptedOrderService($this->autoMapping, $this->mockManager);
        $this->assertIsArray($service->acceptedOrder($actual, $actual));
    }

    public function acceptedOrder()
    {
        $result = new AcceptedOrderProvider();
        return $result->acceptedOrder();
    }

    /**
     * @dataProvider totalEarn
     */
    public function testTotalEarn($expected, $actual)
    {
        $response = new CaptaintotalEarnResponse();
        $response->CaptaintotalEarn = $expected;

        $this->mockManager
            ->method('totalEarn')
            ->willReturn(["CaptaintotalEarn" => $actual]);

        $service = new AcceptedOrderService($this->autoMapping, $this->mockManager);

        $this->assertEquals($response, $service->totalEarn($expected));
    }

    public function totalEarn()
    {
        $result = new AcceptedOrderProvider();
        return $result->totalEarn();
    }
    /**
     * @dataProvider closestOrders
     */
    public function testClosestOrders($expected, $actual)
    {
        $this->mockManager
            ->method('closestOrders')
            ->willReturn(["id" => $actual]);

        $service = new AcceptedOrderService($this->autoMapping, $this->mockManager);

        $this->assertIsArray($service->closestOrders($expected));
    }

    public function closestOrders()
    {
        $result = new AcceptedOrderProvider();
        return $result->closestOrders();
    }
}
