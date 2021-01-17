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
use App\Service\SubscriptionService;

class OrderService
{
    private $autoMapping;
    private $orderManager;
    private $acceptedOrderService;
    private $recordService;
    private $branchesService;
    private $subscriptionService;
    private $userService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, AcceptedOrderService $acceptedOrderService, RecordService $recordService, BranchesService $branchesService, SubscriptionService $subscriptionService, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderManager = $orderManager;
        $this->acceptedOrderService = $acceptedOrderService;
        $this->recordService = $recordService;
        $this->branchesService = $branchesService;
        $this->subscriptionService = $subscriptionService;
        $this->userService = $userService;
    }

    // public function create(OrderCreateRequest $request)
    // {
    //     $uuid = $this->recordService->uuid();
       
    //     $item = $this->orderManager->create($request, $uuid);
    //     if ($item) {
    //         $this->recordService->create($item->getId(), $item->getState());
    //     }
    //     return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
    // }
    public function create(OrderCreateRequest $request)
    {  
        $response = "please subscribe!!";
        $status = $this->subscriptionService->subscriptionIsActive($request->getOwnerID());
       
        if ($status == 'active') {
            $uuid = $this->recordService->uuid();
        
            $item = $this->orderManager->create($request, $uuid);
            if ($item) {
                $this->recordService->create($item->getId(), $item->getState());
            }
            $response =$this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
        }
        
        if ($status == 'inactive') {
            $response ="subscribe is awaiting activation!!";
        }
        if ($status == 'orders finished') {
            $response ="subscripe finished, count orders is finished!!";
        }

        if ($status == 'date finished') {
            $response ="subscripe finished, date is finished!!";
        }

        if ($status == 'unaccept') {
            $response ="subscribe unaccept!!";
        }
        return $response;
    }

    public function getOrderById($orderId)
    {
        $acceptedOrder=[];
        $order = $this->orderManager->getOrderById($orderId);
        if ($order['fromBranch']){
            $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
            }
        if ($order){
            $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);
            $record = $this->recordService->getRecordByOrderId($orderId);
        }
        $response = $this->autoMapping->map('array', OrderResponse::class, $order);

        if ($order) {
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

            if ($order['fromBranch'] == true){
                $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
            }
            $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($order['id']);
            $order['record'] = $this->recordService->getrecordByOrderId($order['id']);
            $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
        }

        return $response;
    }

    public function orderStatus($userID, $orderId, $userType)
    {
        if($userType == 'ROLE_OWNER') {
            $order = $this->orderManager->orderStatus($userID, $orderId);
            if ($order['fromBranch'] == true){
                $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
            }
            $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);

            $record = $this->recordService->getrecordByOrderId($orderId);

            $response = $this->autoMapping->map('array', OrderResponse::class, $order);

            if ($acceptedOrder) {
                $response->acceptedOrder =  $acceptedOrder;
            }

            $response->record =  $record;
        }
        if($userType == 'ROLE_CAPTAIN') {
            $order = $this->orderManager->orderStatusForCaptain($userID, $orderId);
           
            if ($order['fromBranch'] == true){
                $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
            }
            $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);

            $record = $this->recordService->getrecordByOrderId($orderId);

            $response = $this->autoMapping->map('array', OrderResponse::class, $order);

            if ($acceptedOrder) {
                $response->acceptedOrder =  $acceptedOrder;
                $response->record =  $record;
            }
        }
        return $response;
    }

    public function closestOrders($userId)
    {
        $response ="this captain inactive!!";
        $status = $this->userService->captainIsActive($userId);
        if ($status == 'active') {
            $response = [];
            $orders = $this->orderManager->closestOrders();
    
            foreach ($orders as $order) {
                if ($order['fromBranch'] == true){
                $order['fromBranch'] = $this->branchesService->getBrancheById($orders[0]['fromBranch']);
                }
                $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
            }
        }
        return $response;
    }

    public function getPendingOrders()
    {
        $response = [];

        $orders = $this->orderManager->getPendingOrders();

        foreach ($orders as $order) {

            if ($order['fromBranch']){

                $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
                }
            $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($order['id']);
          
            $order['record'] = $this->recordService->getrecordByOrderId($order['id']);
            
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
        $response[] = $this->countAllOrders();
        $ongoingOrders = $this->orderManager->ongoingOrders();
      
        foreach ($ongoingOrders as  $ongoingOrder) {

            if ($ongoingOrder['fromBranch']){
                $ongoingOrder['fromBranch'] = $this->branchesService->getBrancheById($ongoingOrder['fromBranch']);
                }
           $response[]  = $this->autoMapping->map('array',OrdersongoingResponse::class,  $ongoingOrder);
        }  
        return $response;
    }

    public function getRecords($userId, $userType)
    {
        $response = [];
        if($userType == 'ROLE_OWNER') {
            $items = $this->orderManager->getRecords($userId);
        
            foreach ($items as $item) {
                
                $item['record'] = $this->recordService->getRecordsByOrderId($item['id']);
                $item['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($item['id']);

                $response []= $this->autoMapping->map('array', OrderResponse::class, $item);
            }
        }

        if($userType == 'ROLE_CAPTAIN') {
            $items = $this->orderManager->getRecordsForCaptain($userId);
        
            foreach ($items as $item) {
                
                $item['record'] = $this->recordService->getRecordsByOrderId($item['id']);
                $item['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($item['id']);

                $response []= $this->autoMapping->map('array', OrderResponse::class, $item);
            }
        }
        return $response;
    }

    public function getOrders()
    {
        $response = [];
        $orders = $this->orderManager->getOrders();
       
        foreach ($orders as $order) {

            if ($order['fromBranch']){
                $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
                }

            $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($order['id']);

            $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
        }

        return $response;
    }
}
