<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\OrderManager;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Response\OrderResponse;
use App\Response\DeleteResponse;

class OrderService
{
    private $autoMapping;
    private $orderManager;
    private $acceptedOrderService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager,AcceptedOrderService $acceptedOrderService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderManager = $orderManager;
        $this->acceptedOrderService = $acceptedOrderService;
    }

    public function create(OrderCreateRequest $request)
    {
        $item = $this->orderManager->create($request);

        return $this->autoMapping->map(OrderEntity::class,OrderResponse::class, $item);
    }

    public function getOrderById($request)
    {
        $result = $this->orderManager->getOrderById($request);

        $response = $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $result);

        return $response;
    }

    public function getOrdersByOwnerID($userID)
    {
        $response = [];
        $result = $this->orderManager->getOrdersByOwnerID($userID);
        foreach($result as $item)
        {
            $response[] = $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $item);
        }
        return $response;
    }

    public function orderStatus($userID, $ID)
    {
        $result = $this->orderManager->orderStatus($userID, $ID);
        
        $response = $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $result);
        
        return $response;
    }

    public function searchMyArray($arrays, $key, $search)
    {       
        $count = 0;

        foreach ($arrays as $object) {
            if (is_object($object)) {
                $object = get_object_vars($object);
            }
            if (array_key_exists($key, $object) && $object[$key] == $search) {
                $count++;
            }

        }
        return $count;
    }

    public function closestOrders()
    { 
        $response=[];
        $orders = $this->orderManager->closestOrders();
        $acceptedOrder = $this->acceptedOrderService->closestOrders();
        
        foreach($orders as $res)
        { 
          if (!$this->searchMyArray($acceptedOrder, 'id', $res['id']))
          {
              $response[] = $this->autoMapping->map('array', OrderResponse::class, $res);
          }
        }
         return $response;
    }

    public function update(OrderUpdateRequest $request)
    {
        $item = $this->orderManager->update($request);

        return $this->autoMapping->map(OrderEntity::class,OrderResponse::class, $item);
    }

    public function delete($result)
    {
        $result = $this->orderManager->delete($result);

        if($result == null)
        {
            return null;
        }

        return  $this->autoMapping->map(OrderEntity::class, DeleteResponse::class, $result);
    }

}