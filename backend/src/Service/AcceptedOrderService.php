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

class AcceptedOrderService
{
    private $autoMapping;
    private $acceptedOrderManager;
    private $recordService;

    public function __construct(AutoMapping $autoMapping, AcceptedOrderManager $acceptedOrderManager, RecordService $recordService)
    {
        $this->autoMapping = $autoMapping;
        $this->acceptedOrderManager = $acceptedOrderManager;
        $this->recordService = $recordService;
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
         return $this->acceptedOrderManager->getTop5Captains();
     }
}
