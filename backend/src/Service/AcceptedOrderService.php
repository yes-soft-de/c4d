<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Manager\AcceptedOrderManager;
use App\Request\AcceptedOrderCreateRequest;
use App\Response\AcceptedOrderResponse;
use App\Response\CaptainTotalEarnResponse;
use App\Response\ongoingCaptainsResponse;

class AcceptedOrderService
{
    private $autoMapping;
    private $acceptedOrderManager;

    public function __construct(AutoMapping $autoMapping, AcceptedOrderManager $acceptedOrderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->acceptedOrderManager = $acceptedOrderManager;
    }

    public function create(AcceptedOrderCreateRequest $request)
    {
        $item = $this->acceptedOrderManager->create($request);

        return $this->autoMapping->map(AcceptedOrderEntity::class, AcceptedOrderResponse::class, $item);
    }

    public function getOrderStatusForCaptain($captainID, $orderId)
    {
        $result = $this->acceptedOrderManager->getOrderStatusForCaptain($captainID, $orderId);

        $response = $this->autoMapping->map('array', AcceptedOrderResponse::class, $result);

        return $response;
    }

    public function countOrdersDeliverd($userID)
    {
        return $this->acceptedOrderManager->countOrdersDeliverd($userID);
    }

    public function closestOrders()
    {
        return $this->acceptedOrderManager->closestOrders();
    }

    public function update($request)
    {
        $result = $this->acceptedOrderManager->update($request);

        return $this->autoMapping->map(AcceptedOrderEntity::class, AcceptedOrderResponse::class, $result);
    }

    public function acceptedOrderUpdateStateByCaptain($request)
    {
        $result = $this->acceptedOrderManager->acceptedOrderUpdateStateByCaptain($request);

        $response = $this->autoMapping->map(AcceptedOrderEntity::class, AcceptedOrderResponse::class, $result);
        return $response;

    }

    public function getAcceptedOrderByOrderId($orderId)
    {
        return $this->acceptedOrderManager->getAcceptedOrderByOrderId($orderId);
    }

    public function countAcceptedOrder($captainId)
    {
        return $this->acceptedOrderManager->countAcceptedOrder($captainId);
    }
}
