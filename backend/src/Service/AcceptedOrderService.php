<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Manager\AcceptedOrderManager;
use App\Request\AcceptedOrderCreateRequest;
use App\Response\AcceptedOrderResponse;
use App\Response\AcceptedOrdersResponse;
use App\Response\CaptainTotalEarnResponse;
use App\Response\ongoingCaptainsResponse;
use App\Service\RecordService;
use App\Service\RoomIdHelperService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use DateTime;
class AcceptedOrderService
{
    private $autoMapping;
    private $acceptedOrderManager;
    private $recordService;
    private $roomIdHelperService;
    private $params;

    public function __construct(AutoMapping $autoMapping, AcceptedOrderManager $acceptedOrderManager, RecordService $recordService, ParameterBagInterface $params, RoomIdHelperService $roomIdHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->acceptedOrderManager = $acceptedOrderManager;
        $this->recordService = $recordService;
        $this->roomIdHelperService = $roomIdHelperService;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function create(AcceptedOrderCreateRequest $request)
    {   
        $response ="This order was received by another captain";
        $acceptedOrder = $this->getAcceptedOrderByOrderId($request->getOrderID());
        if (!$acceptedOrder) {
            $item = $this->acceptedOrderManager->create($request);
            if ($item) {
               $this->recordService->create($item->getOrderID(), $item->getState());
               $data = $this->getOwnerIdAndUuid($item->getOrderID());
               $this->roomIdHelperService->create($data);
            }
            $response = $this->autoMapping->map(AcceptedOrderEntity::class, AcceptedOrderResponse::class, $item);
        }
       
        return $response;
    }

    // public function getOrderStatusForCaptain($captainID, $orderId)
    // {
    //     $item = $this->acceptedOrderManager->getOrderStatusForCaptain($captainID, $orderId);
    //     if ($item) {
    //         $record = $this->recordService->getRecordByOrderId($orderId);
    //     }
    //     $response = $this->autoMapping->map('array', AcceptedOrderResponse::class, $item);
    //     $response->record =  $record;
    //     return $response;
    // }

    public function countOrdersDeliverd($userID)
    {
        return $this->acceptedOrderManager->countOrdersDeliverd($userID);
    }

    public function update($request)
    {
        $result = $this->acceptedOrderManager->update($request);

        return $this->autoMapping->map(AcceptedOrderEntity::class, AcceptedOrderResponse::class, $result);
    }

    public function acceptedOrderUpdateStateByCaptain($orderId, $state)
    {
        $item = $this->acceptedOrderManager->acceptedOrderUpdateStateByCaptain($orderId, $state);
        $this->recordService->create($orderId, $state);
    }

    public function getAcceptedOrderByOrderId($orderId)
    {
        return $this->acceptedOrderManager->getAcceptedOrderByOrderId($orderId);
    }

    public function getAcceptedOrderByCaptainId($captainId)
    {
        $response = [];
        $orders = $this->acceptedOrderManager->getAcceptedOrderByCaptainId($captainId);
        foreach ($orders as $order){
            $order['record'] = $this->recordService->getrecordByOrderId($order['orderID']);
            $response[] = $this->autoMapping->map('array', AcceptedOrdersResponse::class, $order);
        }
    
    return $response;
    }

    public function countAcceptedOrder($captainId)
    {
        return $this->acceptedOrderManager->countAcceptedOrder($captainId);
    }

    public function getTop5Captains()
     {
        return $this->acceptedOrderManager->getTop5Captains();
     }

    public function countOrdersInMonthForCaptin($fromDate, $toDate, $captainId)
     {
         return $this->acceptedOrderManager->countOrdersInMonthForCaptin($fromDate, $toDate, $captainId);
     }

    public function getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId)
     {
         return $this->acceptedOrderManager->getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId);
     }

    public function getTopCaptainsInThisMonth()
    {
        $response = [];
        $dateNow =new DateTime("now");
        $year = $dateNow->format("Y");
        $month = $dateNow->format("m");
        $date = $this->returnDate($year, $month);
       $topCaptains = $this->acceptedOrderManager->getTopCaptainsInThisMonth($date[0],$date[1]);
     
        foreach ($topCaptains as $topCaptain) {
            $topCaptain['imageURL'] = $topCaptain['image'];
            $topCaptain['image'] = $this->params.$topCaptain['image'];
            $topCaptain['drivingLicenceURL'] = $topCaptain['drivingLicence'];
            $topCaptain['drivingLicence'] = $this->params.$topCaptain['drivingLicence'];
            $topCaptain['baseURL'] = $this->params;
            $response[] = $this->autoMapping->map('array', AcceptedOrdersResponse::class, $topCaptain);
        }
    
       return $response;
   }

   public function returnDate($year, $month)
   {
       $fromDate =new \DateTime($year . '-' . $month . '-01'); 
       $toDate = new \DateTime($fromDate->format('Y-m-d') . ' -1 month');
    //    if you want get top captains in this month must change (-1 month) to (+1 month) in back line
    //    return [$fromDate,  $toDate];

    //    if you want get top captains in last month must change (+1 month) to (-1 month) in back line
       return [$toDate,  $fromDate];
    }

    public function specialLinkCheck($bool)
    {
        if (!$bool)
        {
            return $this->params;
        }
    }

    public function countOrdersInDay($captainID, $fromDate, $toDate)
     {
         return $this->acceptedOrderManager->countOrdersInDay($captainID, $fromDate, $toDate);
     }

    public function getOwnerIdAndUuid($orderId)
     {
         return $this->acceptedOrderManager->getOwnerIdAndUuid($orderId);
     }
}
