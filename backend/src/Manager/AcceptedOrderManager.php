<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Manager\OrderManager;
use App\Repository\AcceptedOrderEntityRepository;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Request\OrderUpdateStateByCaptainRequest;
use App\Request\GetByIdRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use DateTime;
class AcceptedOrderManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $repository;
    private $orderManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, AcceptedOrderEntityRepository $repository,OrderManager $orderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->repository = $repository;
        $this->orderManager = $orderManager;
    }

    public function create(AcceptedOrderCreateRequest $request)
    {
        $item = $this->autoMapping->map(AcceptedOrderCreateRequest::class, AcceptedOrderEntity::class, $request);
       
        $item->setDuration($item->getDuration());
        $item->setState('on way to pick order');
        $item->setDateOnly($item->getDateOnly());

        $this->entityManager->persist($item);
        $this->entityManager->flush();
        $this->entityManager->clear();

        ///////////////update state in orderEntity
        if ($item) {
        $this->orderManager->orderUpdateStateByCaptain2($request->getOrderID());
        }
        return $item;
    }

    // public function getOrderStatusForCaptain($captainID, $orderId)
    // {
    //     return $this->repository->getOrderStatusForCaptain($captainID, $orderId);
    // }

    public function countOrdersDeliverd($userID)
    {
        return $this->repository->countOrdersDeliverd($userID);
    }

    public function update(AcceptedOrderUpdateRequest $request)
    {
        $acceptedOrderEntity = $this->repository->find($request->getId());
        if ($acceptedOrderEntity) {
            $request->setDate($acceptedOrderEntity->getDate());
            $request->setDuration($acceptedOrderEntity->getDuration());
            
        }
        if (!$acceptedOrderEntity) {
            return null;
        }
        $acceptedOrderEntity = $this->autoMapping->mapToObject(AcceptedOrderUpdateRequest::class, AcceptedOrderEntity::class, $request, $acceptedOrderEntity);

        $this->entityManager->flush();

        return $acceptedOrderEntity;
    }

    public function acceptedOrderUpdateStateByCaptain($orderId, $state)
    {
        $acceptedOrderEntity = $this->repository->getByOrderId($orderId);

        if (!$acceptedOrderEntity) {
            return null;
        }

        $acceptedOrderEntity->setState($state);

        $acceptedOrderEntity = $this->autoMapping->mapToObject(OrderUpdateStateByCaptainRequest::class, AcceptedOrderEntity::class, $acceptedOrderEntity, $acceptedOrderEntity);

        $this->entityManager->flush();

        return $acceptedOrderEntity;
    }

    public function getAcceptedOrderByOrderId($orderId)
    {
        return $this->repository->getAcceptedOrderByOrderId($orderId);
    }

    public function getAcceptedOrderByCaptainId($captainId)
    {
        return $this->repository->getAcceptedOrderByCaptainId($captainId);
    }

    public function  countAcceptedOrder($captainId)
    {
        return $this->repository->countAcceptedOrder($captainId);
    }

    public function getTop5Captains()
    {        
        return $this->repository->getTop5Captains( );
    }

    public function countOrdersInMonthForCaptin($fromDate, $toDate, $captainId)
    {
        return $this->repository->countOrdersInMonthForCaptin($fromDate, $toDate, $captainId);
    }

    public function getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId)
    {
        return $this->repository->getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId);
    }

    public function getTopCaptainsInThisMonth($fromDate, $toDate)
    {
        return $this->repository->getTopCaptainsInThisMonth($fromDate, $toDate);
    }

    public function countOrdersInDay($captainID, $fromDate, $toDate)
    {
        return $this->repository->countOrdersInDay($captainID, $fromDate, $toDate);
    }

    public function getOwnerIdAndUuid($orderId)
    {
        return $this->repository->getOwnerIdAndUuid($orderId);
    }
}
