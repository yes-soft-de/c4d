<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Repository\OrderEntityRepository;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Request\OrderUpdateStateByCaptainRequest;
use App\Request\GetByIdRequest;
use App\Request\DeleteRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class OrderManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $repository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, OrderEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->repository = $repository;
    }

    public function create(OrderCreateRequest $request)
    {
        $item = $this->autoMapping->map(OrderCreateRequest::class, OrderEntity::class, $request);

        $item->setDate($item->getDate());

        $this->entityManager->persist($item);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $item;
    }

    public function getOrderById($orderId)
    {
        return $this->repository->getOrderById($orderId);
    }

    public function getOrdersByOwnerID($userID)
    {
        return $this->repository->getOrdersByOwnerID($userID);
    }

    public function orderStatus($userID, $orderId)
    {
        return $this->repository->orderStatus($userID, $orderId);
    }

    public function closestOrders()
    {
        return $this->repository->closestOrders();
    }

    public function getPendingOrders()
    {
        return $this->repository->closestOrders();
    }

    public function update(OrderUpdateRequest $request)
    {
        $item = $this->repository->find($request->getId());
       

        if ($item) {
            $item = $this->autoMapping->mapToObject(OrderUpdateRequest::class, OrderEntity::class, $request, $item);

            $item->setUpdateDate($item->getUpdateDate());
            
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function orderUpdateStateByCaptain(OrderUpdateStateByCaptainRequest $request)
    {
        $item = $this->repository->find($request->getId());
       

        if ($item) {
            $item = $this->autoMapping->mapToObject(OrderUpdateStateByCaptainRequest::class, OrderEntity::class, $request, $item);

            $item->setUpdateDate($item->getUpdateDate());
            
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function delete(DeleteRequest $request)
    {
        $entity = $this->repository->find($request->getId());
        if ($entity) {
        
            $this->entityManager->remove($entity);
            $this->entityManager->flush();
        }
        return $entity;
    }

    public function countAllOrders()
    {
        return $this->repository->countAllOrders();
    }

    public function countpendingOrders()
    {
        return $this->repository->countpendingOrders();
    }

    public function countOngoingOrders()
    {
        return $this->repository->countOngoingOrders();
    }

    public function countCancelledOrders()
    {
        return $this->repository->countCancelledOrders();
    }

    public function ongoingOrders()
    {
        return $this->repository->ongoingOrders();
    }
}
