<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\OrderManager;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Request\OrderUpdateStateByCaptainRequest;
use App\Request\SendNotificationRequest;
use App\Response\OrderResponse;
use App\Response\DeleteResponse;
use App\Response\OrdersongoingResponse;
use App\Service\SubscriptionService;
use App\Service\RatingService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use DateTime;

class OrderService
{
    private $autoMapping;
    private $orderManager;
    private $acceptedOrderService;
    private $recordService;
    private $branchesService;
    private $subscriptionService;
    private $userService;
    private $params;
    private $ratingService;
    private $notificationService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, AcceptedOrderService $acceptedOrderService,
                                RecordService $recordService, BranchesService $branchesService, SubscriptionService $subscriptionService,
                                UserService $userService, ParameterBagInterface $params,  RatingService $ratingService
                                , NotificationService $notificationService
                                )
    {
        $this->autoMapping = $autoMapping;
        $this->orderManager = $orderManager;
        $this->acceptedOrderService = $acceptedOrderService;
        $this->recordService = $recordService;
        $this->branchesService = $branchesService;
        $this->subscriptionService = $subscriptionService;
        $this->userService = $userService;
        $this->ratingService = $ratingService;

        $this->params = $params->get('upload_base_url') . '/';
        $this->notificationService = $notificationService;
    }

    public function create(OrderCreateRequest $request)
    {  
        $response = "please subscribe!!";
        //get Subscribe id Current
        $subscriptionCurrent =  $this->subscriptionService->getSubscriptionCurrent($request->getOwnerID());
      
        if ($subscriptionCurrent) {
             // check subscription
            $status = $this->subscriptionService->subscriptionIsActive($request->getOwnerID(), $subscriptionCurrent['id']);
        
            if ($status == 'active') {
                $uuid = $this->recordService->uuid();
                
                $item = $this->orderManager->create($request, $uuid, $subscriptionCurrent['id']);

                //start-----> notification
                // try{
                $this->notificationService->notificationToCaptain();
                //notification <------end
                // }
                // catch (\Exception $e)
                // {
        
                // }
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
    }
        return $response;
    }

    public function getOrderById($orderId)
    {
        $acceptedOrder=[];
        $record=[];
        $order = $this->orderManager->getOrderById($orderId);
     
        if ($order){
            if ($order['fromBranch']){
                $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
                }
            $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);
            $record = $this->recordService->getFirstDate($orderId);
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

    public function orderStatus($orderId)
    {
        
        $order = $this->orderManager->orderStatus( $orderId);
        if ($order){
               if ($order['fromBranch'] == true) {
                    $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
               }
            
            $order['owner'] = $this->userService->getUserProfileByUserID($order['ownerID']);
            $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($orderId);

            $order['record'] = $this->recordService->getrecordByOrderId($orderId);
        }
        $response = $this->autoMapping->map('array', OrderResponse::class, $order);

        return $response;
    }

    public function closestOrders($userId)
    {
        // $response ="this captain inactive!!";
        // $status = $this->userService->captainIsActive($userId);
        // if ($status == 'active') {
            $response = [];
            $orders = $this->orderManager->closestOrders();

            foreach ($orders as $order) {
                if ($order['fromBranch'] == true){
                    $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
                }
                $order['record'] = $this->recordService->getrecordByOrderId($order['id']);
               
                $order['owner'] = $this->userService->getUserProfileByUserID($order['ownerID']);
                $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
            }
        // }
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
        if($item) {
            $acceptedOrderUpdateState = $this->acceptedOrderService->acceptedOrderUpdateStateByCaptain($item->getId(), $request->getState());
        
            $acceptedOrder = $this->acceptedOrderService->getAcceptedOrderByOrderId($item->getId());
            $record = $this->recordService->getRecordByOrderId($item->getId());
        }
        $response = $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
        if($item) {
            $response->acceptedOrder =  $acceptedOrder;
            $response->record =  $record;
        }

        //start-----> notification
        // try {
        $notificationRequest = new SendNotificationRequest();
        $notificationRequest->setUserIdOne($item->getOwnerID());
        $notificationRequest->setUserIdTwo($acceptedOrder[0]['captainID']);

        $this->notificationService->notificationOrderUpdate($notificationRequest);
        //notification <------end
        // }
        // catch (\Exception $e)
        // {

        // }
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
            
            $ongoingOrder['image'] = $this->specialLinkCheck($ongoingOrder['specialLink']).$ongoingOrder['image'];
            $ongoingOrder['image'] = $ongoingOrder['image'];
            $ongoingOrder['imageURL'] = $ongoingOrder['image'];
            
            $ongoingOrder['drivingLicence'] = $this->specialLinkCheck($ongoingOrder['specialLink']).$ongoingOrder['drivingLicence'];
            $ongoingOrder['drivingLicence'] = $ongoingOrder['drivingLicence'];
            $ongoingOrder['drivingLicenceURL'] = $ongoingOrder['drivingLicence'];
            $ongoingOrder['baseURL'] = $this->params;
            
            if ($ongoingOrder['fromBranch']){
                $ongoingOrder['fromBranch'] = $this->branchesService->getBrancheById($ongoingOrder['fromBranch']);
                }
                
            $ongoingOrder['record'] = $this->recordService->getFirstDate($ongoingOrder['orderID']);

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

                $firstDate = $this->recordService->getFirstDate($item['id']); 
                $lastDate = $this->recordService->getLastDate($item['id']);
                $item['currentStage'] =  $lastDate;
                if($firstDate[0]['date'] && $lastDate[0]['date']) {
                    $item['completionTime'] = $this->subtractTowDates($firstDate[0]['date'], $lastDate[0]['date']); 
                }

                $response []= $this->autoMapping->map('array', OrderResponse::class, $item);
            }
        }

        if($userType == 'ROLE_CAPTAIN') {
            $items = $this->orderManager->getRecordsForCaptain($userId);
            
            foreach ($items as $item) {
                
                $item['record'] = $this->recordService->getRecordsByOrderId($item['id']);
                $item['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($item['id']);
               
                $item['rating'] = $this->ratingService->ratingByCaptainID($item['acceptedOrder'][0]['captainID']);
               
                $firstDate = $this->recordService->getFirstDate($item['id']); 
                $lastDate = $this->recordService->getLastDate($item['id']);
                $item['currentStage'] =  $lastDate;
                if($firstDate[0]['date'] && $lastDate[0]['date']) {
                    $item['completionTime'] = $this->subtractTowDates($firstDate[0]['date'], $lastDate[0]['date']); 
                }
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

    public function returnDate($year, $month)
    {
        $fromDate =new \DateTime($year . '-' . $month . '-01'); 
        $toDate = new \DateTime($fromDate->format('Y-m-d h:i:s') . ' -1 month');
        // if you want get top captains in this month must change (-1 month) to (+1 month) in back line
    //    return [$fromDate,  $toDate];

        // if you want get top captains in last month must change (+1 month) to (-1 month) in back line
       return [$toDate,  $fromDate];
    
     }

     public function getAllOrdersAndCount($year, $month, $userId, $userType)
     {
         $response = [];
         $date = $this->returnDate($year, $month);
         
    if ($userType == "owner") {
        $response['countOrdersInMonth'] = $this->orderManager->countOrdersInMonthForOwner($date[0], $date[1], $userId);
        $response['countOrdersInDay'] = $this->orderManager->countOrdersInDay($userId, $date[0],$date[1]);
         
         $ordersInMonth = $this->orderManager->getAllOrders($date[0], $date[1], $userId);
        
         foreach ($ordersInMonth as $order) {

             if ($order['fromBranch']){
                 $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
                 }
 
             $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($order['id']);
             $order['record'] = $this->recordService->getrecordByOrderId($order['id']); 
             $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
         }
     }

    if ($userType == "captain") {
       
        $response['countOrdersInMonth'] = $this->acceptedOrderService->countOrdersInMonthForCaptin($date[0], $date[1], $userId);
        $response['countOrdersInDay'] = $this->acceptedOrderService->countOrdersInDay($userId, $date[0],$date[1]);
        $acceptedInMonth = $this->acceptedOrderService->getAcceptedOrderByCaptainIdInMonth($date[0], $date[1], $userId);
         
        foreach ($acceptedInMonth as $item){
            $ordersInMonth =  $this->orderManager->orderById($item['orderID']);  
          
        
            foreach ($ordersInMonth as $order) {
    
                if ($order['fromBranch']){
                    $order['fromBranch'] = $this->branchesService->getBrancheById($order['fromBranch']);
                    }

                $order['acceptedOrder'] = $this->acceptedOrderService->getAcceptedOrderByOrderId($order['id']);
                $order['record'] = $this->recordService->getrecordByOrderId($order['id']); 
                $firstDate = $this->recordService->getFirstDate($order['id']); 
                $lastDate = $this->recordService->getLastDate($order['id']);
               
                if($firstDate[0]['date'] && $lastDate[0]['date']) {
                    $order['completionTime'] = $this->subtractTowDates($firstDate[0]['date'], $lastDate[0]['date']);
                    
                }
                
                $response[] = $this->autoMapping->map('array', OrderResponse::class, $order);
                
            }
        }
     }
         return $response;
    }

    function format_interval($interval) {
        $result = "";
        if ($interval->y) { $result .= $interval->format("%y years "); }
        if ($interval->m) { $result .= $interval->format("%m months "); }
        if ($interval->d) { $result .= $interval->format("%d days "); }
        if ($interval->h) { $result .= $interval->format("%h hours "); }
        if ($interval->i) { $result .= $interval->format("%i minutes "); }
        if ($interval->s) { $result .= $interval->format("%s seconds "); }
    
        return $result;
    } 
    function subtractTowDates($firstDate, $lastDate) {
        
        $difference = $firstDate->diff($lastDate);
        
        return $this->format_interval($difference);
    }
    
    public function getTopOwners()
    {
        $response=[];
        $dateNow =new DateTime("now");
        $year = $dateNow->format("Y");
        $month = $dateNow->format("m");
       $date = $this->returnDate($year, $month);
 
       $topOwners = $this->orderManager->getTopOwners($date[0],$date[1]);
     
        foreach ($topOwners as $topOwner) {
         
            $topOwner['imageURL'] = $topOwner['image'];
            $topOwner['image'] = $this->params.$topOwner['image'];
            $topOwner['baseURL'] = $this->params;

            $topOwner['countOrdersInDay'] = $this->orderManager->countOrdersInDay($topOwner['ownerID'], $date[0],$date[1]);
           
            $response[] = $this->autoMapping->map('array', OrderResponse::class, $topOwner);
        }
    
       return $response;
   }

   public function specialLinkCheck($bool)
    {
        if (!$bool)
        {
            return $this->params;
        }
    }
}
