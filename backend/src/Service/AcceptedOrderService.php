<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Manager\AcceptedOrderManager;
use App\Request\AcceptedOrderCreateRequest;
use App\Response\AcceptedOrderResponse;;
use App\Response\OrderResponse;
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

        return $this->autoMapping->map(AcceptedOrderEntity::class,AcceptedOrderResponse::class, $item);
    }

    public function acceptedOrder($userID, $ID)
    {
        $result = $this->acceptedOrderManager->acceptedOrder($userID, $ID);
        
        $response = $this->autoMapping->map(AcceptedOrderEntity::class, AcceptedOrderResponse::class, $result);
        
        return $response;
    }

    public function closestOrders()
    {
        return $this->acceptedOrderManager->closestOrders();      
        
        // foreach($result as $item)
        // {
        //     $response[] = $this->autoMapping->map('array', OrderResponse::class, $item);
        // }
        // return $response;
    }
}