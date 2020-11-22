<?php

namespace App\Tests;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\OrderManager;
use App\Service\OrderService;
use App\Service\AcceptedOrderService;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Request\GetByIdRequest;
use App\Request\DeleteRequest;
use App\Response\OrderResponse;
use App\Tests\fixtures\OrderProvider;
use PHPUnit\Framework\TestCase;

class OrderServiceUnitTest extends TestCase
{
    private $mockManager;
    private $autoMapping;
    private $mockAccepteService;

    protected function setUp()
    {
        $this->mockManager = $this->createMock(OrderManager::class);
        $this->mockAccepteService = $this->createMock(AcceptedOrderService::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider create
     */
    public function testCreate($expected, $actual)
    {
        $response = new OrderResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->source = [$expected];
        $response->destination = [$expected];
        $date = new \DateTime("2020-02-02");
        $response->date = $date;
        $response->note = $expected;
        $response->payment = $expected;
        $response->recipientName = $expected;
        $response->recipientPhone = $expected;

        $entity = new OrderEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setSource([$expected]);
        $entity->setDestination([$actual]);
        $entity->setDate("2020-02-02");
        $entity->setNote($actual);
        $entity->setPayment($actual);
        $entity->setRecipientName($actual);
        $entity->setRecipientPhone($actual);

        $request = new OrderCreateRequest();

        $this->mockManager
            ->method('create')
            ->willReturn($entity);

        $service = new OrderService($this->autoMapping, $this->mockManager, $this->mockAccepteService);

        $this->assertEquals($response, $service->create($request));
    }

    public function create()
    {
        $result = new OrderProvider();
        return $result->create();
    }

    /**
     * @dataProvider getOrderById
     */
    public function testGetOrderById($expected, $actual)
    {
        $response = new OrderResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->source = [$expected];
        $response->destination = [$expected];
        $date = new \DateTime("2020-02-02");
        $response->date = $date;
        $response->note = $expected;
        $response->payment = $expected;
        $response->recipientName = $expected;
        $response->recipientPhone = $expected;

        $entity = new OrderEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setSource([$expected]);
        $entity->setDestination([$actual]);
        $entity->setDate("2020-02-02");
        $entity->setNote($actual);
        $entity->setPayment($actual);
        $entity->setRecipientName($actual);
        $entity->setRecipientPhone($actual);

        $this->mockManager
            ->method('getOrderById')
            ->willReturn($entity);

        $service = new OrderService($this->autoMapping, $this->mockManager, $this->mockAccepteService);

        $this->assertIsArray($service->getOrderById($actual));
    }

    public function getOrderById()
    {
        $result = new OrderProvider();
        return $result->getOrderById();
    }

    /**
     * @dataProvider getOrdersByOwnerID
     */
    public function testGetOrdersByOwnerID($expected, $actual)
    {
        $response = new OrderResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->source = [$expected];
        $response->destination = [$expected];
        $date = new \DateTime("2020-02-02");
        $response->date = $date;
        $response->note = $expected;
        $response->payment = $expected;
        $response->recipientName = $expected;
        $response->recipientPhone = $expected;

        $entity = new OrderEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setSource([$expected]);
        $entity->setDestination([$actual]);
        $entity->setDate("2020-02-02");
        $entity->setNote($actual);
        $entity->setPayment($actual);
        $entity->setRecipientName($actual);
        $entity->setRecipientPhone($actual);


        $this->mockManager
            ->method('getOrdersByOwnerID')
            ->willReturn($entity);

        $service = new OrderService($this->autoMapping, $this->mockManager, $this->mockAccepteService);
        $this->assertIsArray($service->getOrdersByOwnerID($actual));
    }

    public function getOrdersByOwnerID()
    {
        $result = new OrderProvider();
        return $result->getOrdersByOwnerID();
    }

    /**
     * @dataProvider orderStatus
     */
    public function testorderStatus($expected, $actual)
    {
        $response = new OrderResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->source = [$expected];
        $response->destination = [$expected];
        $date = new \DateTime("2020-02-02");
        $response->date = $date;
        $response->note = $expected;
        $response->payment = $expected;
        $response->recipientName = $expected;
        $response->recipientPhone = $expected;

        $entity = new OrderEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setSource([$expected]);
        $entity->setDestination([$actual]);
        $entity->setDate("2020-02-02");
        $entity->setNote($actual);
        $entity->setPayment($actual);
        $entity->setRecipientName($actual);
        $entity->setRecipientPhone($actual);


        $this->mockManager
            ->method('orderStatus')
            ->willReturn($entity);

        $service = new OrderService($this->autoMapping, $this->mockManager, $this->mockAccepteService);
        $this->assertIsArray($service->orderStatus($actual, $actual));
    }

    public function orderStatus()
    {
        $result = new OrderProvider();
        return $result->orderStatus();
    }

    /**
     * @dataProvider closestOrders
     */
    public function testClosestOrders($expected, $actual)
    {
        $response = new OrderResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->source = [$expected];
        $response->destination = [$expected];
        $date = new \DateTime("2020-02-02");
        $response->date = $date;
        $response->note = $expected;
        $response->payment = $expected;
        $response->recipientName = $expected;
        $response->recipientPhone = $expected;

        $entity = new OrderEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setSource([$expected]);
        $entity->setDestination([$actual]);
        $entity->setDate("2020-02-02");
        $entity->setNote($actual);
        $entity->setPayment($actual);
        $entity->setRecipientName($actual);
        $entity->setRecipientPhone($actual);


        $this->mockManager
            ->method('closestOrders')
            ->willReturn($entity);

        $service = new OrderService($this->autoMapping, $this->mockManager, $this->mockAccepteService);

        $this->assertIsArray($service->closestOrders());
    }

    public function closestOrders()
    {
        $result = new OrderProvider();
        return $result->closestOrders();
    }

     /**
     * @dataProvider update
     */
    public function testUpdate($expected, $actual)
    {
        $response = new OrderResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->source = [$expected];
        $response->destination = [$expected];
        $date = new \DateTime("2020-02-02");
        $response->date = $date;
        $response->note = $expected;
        $response->payment = $expected;
        $response->recipientName = $expected;
        $response->recipientPhone = $expected;

        $entity = new OrderEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setSource([$expected]);
        $entity->setDestination([$actual]);
        $entity->setDate("2020-02-02");
        $entity->setNote($actual);
        $entity->setPayment($actual);
        $entity->setRecipientName($actual);
        $entity->setRecipientPhone($actual);

        $request = new OrderUpdateRequest();

        $this->mockManager
            ->method('update')
            ->willReturn($entity);

        $service = new OrderService($this->autoMapping, $this->mockManager, $this->mockAccepteService);

        $this->assertEquals($response, $service->update($request));
    }

    public function update()
    {
        $result = new OrderProvider();
        return $result->update();
    }

     /**
     * @dataProvider delete
     */
    public function testDelete($expected, $actual)
    {
        $response = new OrderResponse();
        $response->id = $expected;
        $response->ownerID = $expected;
        $response->source = [$expected];
        $response->destination = [$expected];
        $response->note = $expected;
        $response->payment = $expected;
        $response->recipientName = $expected;
        $response->recipientPhone = $expected;

        $entity = new OrderEntity();
        $entity->setId($actual);
        $entity->setOwnerID($actual);
        $entity->setSource([$expected]);
        $entity->setDestination([$actual]);
        $entity->setNote($actual);
        $entity->setPayment($actual);
        $entity->setRecipientName($actual);
        $entity->setRecipientPhone($actual);

        $request = new DeleteRequest($entity->getId());

        $this->mockManager
            ->method('delete')
            ->willReturn($entity);

        $service = new OrderService($this->autoMapping, $this->mockManager, $this->mockAccepteService);

        $this->assertIsObject($service->delete($request));
    }

    public function delete()
    {
        $result = new OrderProvider();
        return $result->delete();
    }
}
