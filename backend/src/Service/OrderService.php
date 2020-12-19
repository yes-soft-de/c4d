<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\OrderManager;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Request\OrderUpdateStateByCaptainRequest;
use App\Response\OrderResponse;
use App\Response\DeleteResponse;
use App\Response\OrdersongoingResponse;

class OrderService
{
    private $autoMapping;
    private $orderManager;
    private $acceptedOrderService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, AcceptedOrderService $acceptedOrderService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderManager = $orderManager;
        $this->acceptedOrderService = $acceptedOrderService;
    }

    public function create(OrderCreateRequest $request)
    {
        $item = $this->orderManager->create($request);

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
    }

    public function getOrderById($orderId)
    {
        $order = $this->orderManager->getOrderById($orderId);
        $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);

        $response = $this->autoMapping->map('array', OrderResponse::class, $order);
        $response->acceptedOrder =  $acceptedOrder;
        
        return $response;
    }

    public function getOrdersByOwnerID($userID)
    {
        $response = [];
        $orders = $this->orderManager->getOrdersByOwnerID($userID);
       
        foreach ($orders as $order) {

            $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($order['id']);

            $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
        }

        return $response;
    }

    public function orderStatus($userID, $orderId)
    {
        $order = $this->orderManager->orderStatus($userID, $orderId);

        $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);

        $response = $this->autoMapping->map('array', OrderResponse::class, $order);
        $response->acceptedOrder =  $acceptedOrder;
        return $response;
    }

    public function closestOrders()
    {
        $response = [];

        $orders = $this->orderManager->closestOrders();

        foreach ($orders as $order) {
            
            $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
        }
        return $response;
    }

    public function getPendingOrders()
    {
        $response = [];

        $orders = $this->orderManager->getPendingOrders();

        foreach ($orders as $order) {
            
            $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
        }
        return $response;
    }

    public function update(OrderUpdateRequest $request)
    {
        $item = $this->orderManager->update($request);

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
    }

    public function orderUpdateStateByCaptain(OrderUpdateStateByCaptainRequest $request)
    {
        $item = $this->orderManager->orderUpdateStateByCaptain($request);

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
    }

    public function delete($result)
    {
        $result = $this->orderManager->delete($result);

        if ($result == null) {
            return null;
        }
        return  $this->autoMapping->map(OrderEntity::class, DeleteResponse::class, $result);
    }

    public function countAllOrders()
    {
        return $this->orderManager->countAllOrders();
    }

    public function dashboardOrders()
    {
        $response = [];
        $response[] = $this->orderManager->countpendingOrders();
        $response[] = $this->orderManager->countOngoingOrders();
        $response[] = $this->orderManager->countCancelledOrders();
        $ongoingOrders = $this->orderManager->ongoingOrders();
      
        foreach ($ongoingOrders as  $ongoingOrder) {
         
           $response[]  = $this->autoMapping->map('array',OrdersongoingResponse::class,  $ongoingOrder);
        }  
        return $response;
    }
}
