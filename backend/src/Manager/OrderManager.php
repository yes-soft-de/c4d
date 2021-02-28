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
use Symfony\Component\Validator\Constraints\DateTime;

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

    public function create(OrderCreateRequest $request, $uuid, $subscribeId)
    {
        $request->setUuid($uuid);
        $request->setSubscribeId($subscribeId);
        $item = $this->autoMapping->map(OrderCreateRequest::class, OrderEntity::class, $request);

        $item->setDate($item->getDate());
        $item->setState('pending');
        
        $this->entityManager->persist($item);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $item;
    }

    public function getOrderById($orderId)
    {
        return $this->repository->getOrderById($orderId);
    }

    public function orderById($orderId)
    {
        return $this->repository->orderById($orderId);
    }

    public function getOrdersByOwnerID($userID)
    {
        return $this->repository->getOrdersByOwnerID($userID);
    }

    public function orderStatus($orderId)
    {
        return $this->repository->orderStatus($orderId);
    }
//for delete
    // public function orderStatusForCaptain($userID, $orderId)
    // {
    //     return $this->repository->orderStatusForCaptain($userID, $orderId);
    // }

    public function closestOrders()
    {
        return $this->repository->closestOrders();
    }

    public function getPendingOrders()
    {
        return $this->repository->getPendingOrders();
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

    public function orderUpdateStateByCaptain2($orderID)
    {
        $item = $this->repository->find($orderID);
       

        if ($item) {
            $item->setState('on way to pick order');
            
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

    public function getRecords($user)
    {
        return $this->repository->getRecords($user);
    }

    public function getRecordsForCaptain($user)
    {
        return $this->repository->getRecordsForCaptain($user);
    }

    public function getOrders()
    {
        return $this->repository->getOrders();
    }

    public function countOrdersInMonthForOwner($fromDate, $toDate, $ownerId)
    {
        return $this->repository->countOrdersInMonthForOwner($fromDate, $toDate, $ownerId);
    }

    public function getAllOrders($fromDate, $toDate, $ownerId)
    {
        return $this->repository->getAllOrders($fromDate, $toDate, $ownerId);
    }

    public function getTopOwners($fromDate, $toDate)
    {
        return $this->repository->getTopOwners($fromDate, $toDate);
    }

    public function countOrdersInDay($ownerID, $fromDate, $toDate)
    {
        return $this->repository->countOrdersInDay($ownerID, $fromDate, $toDate);
    }
}
