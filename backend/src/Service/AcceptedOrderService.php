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
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use DateTime;
class AcceptedOrderService
{
    private $autoMapping;
    private $acceptedOrderManager;
    private $recordService;
    private $params;

    public function __construct(AutoMapping $autoMapping, AcceptedOrderManager $acceptedOrderManager, RecordService $recordService, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->acceptedOrderManager = $acceptedOrderManager;
        $this->recordService = $recordService;

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
        $captains =$this->acceptedOrderManager->getTop5Captains();
        foreach ($captains as $captain) {
            $captain['image'] = $this->specialLinkCheck($captain['specialLink']).$captain['image'];
            $captain['imageURL'] = $captain['image'];
            $captain['baseURL'] = $this->params;
            $response[] = $this->autoMapping->map('array', AcceptedOrdersResponse::class, $captain);
        }
         return $response;
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
        $dateNow =new DateTime("now");
        $year = $dateNow->format("Y");
        $month = $dateNow->format("m");
        $date = $this->returnDate($year, $month);
 
       $topCaptains = $this->acceptedOrderManager->getTopCaptainsInThisMonth($date[0],$date[1]);
     
        foreach ($topCaptains as $topCaptain) {
            $topCaptain['image'] = $this->specialLinkCheck($topCaptain['specialLink']).$topCaptain['image'];
            $topCaptain['imageURL'] = $topCaptain['image'];
            $topCaptain['baseURL'] = $this->params;
            $response[] = $this->autoMapping->map('array', AcceptedOrdersResponse::class, $topCaptain);
        }
    
       return $response;
   }

   public function returnDate($year, $month)
   {
       $fromDate =new \DateTime($year . '-' . $month . '-01'); 
       $toDate = new \DateTime($fromDate->format('Y-m-d') . ' 1 month');
       return [$fromDate,  $toDate];
    }

    public function specialLinkCheck($bool)
    {
        if (!$bool)
        {
            return $this->params;
        }
    }
}
