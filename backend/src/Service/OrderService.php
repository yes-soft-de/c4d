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
    private $recordService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, AcceptedOrderService $acceptedOrderService, RecordService $recordService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderManager = $orderManager;
        $this->acceptedOrderService = $acceptedOrderService;
        $this->recordService = $recordService;
    }

    public function create(OrderCreateRequest $request)
    {
        $item = $this->orderManager->create($request);
        if ($item) {
            $this->recordService->create($item->getId(), $item->getState());
        }
        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
    }

    public function getOrderById($orderId)
    {
        $acceptedOrder=[];
        $order = $this->orderManager->getOrderById($orderId);
        if ($order){
            $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId)[0];
            $record = $this->recordService->getRecordByOrderId($orderId);
        }
        $response = $this->autoMapping->map('array', OrderResponse::class, $order);

        if ($acceptedOrder) {
            $response->acceptedOrder =  $acceptedOrder;
            $response->record =  $record;
        }

        return $response;
    }

    public function orderById($orderId)
    {
        $acceptedOrder = [];
        $order = $this->orderManager->orderById($orderId);
        if ($order) {
            $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);
            $record = $this->recordService->getRecordByOrderId($orderId);
        }
        $response = $this->autoMapping->map('array', OrderResponse::class, $order);

        if ($acceptedOrder) {
            $response->acceptedOrder =  $acceptedOrder;
            $response->record =  $record;
        }

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
        if ($acceptedOrder) {
            $response->acceptedOrder =  $acceptedOrder;
        }
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
            
            $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($order['id']);
            if ($order['acceptedOrder'] == true) {
                $order['record'] = $this->recordService->create($order['id'], $order['state']);
            }
            // if ($order['acceptedOrder'] == true) {

            //         if ($order['state'] == 'pending' && $order['acceptedOrder'][0]['state'] == 'on way to pick order' ) {
            //                 $order['state'] = 'on way to pick order';
            //             }
            //         }
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
      
        $acceptedOrderUpdateState = $this->acceptedOrderService->acceptedOrderUpdateStateByCaptain($item->getId(), $request->getState());
      
        $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($item->getId());

        $record = $this->recordService->getRecordByOrderId($item->getId());

        $response = $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);

        $response->acceptedOrder =  $acceptedOrder;
        $response->record =  $record;
       
        return $response;
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
