<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\SubscriptionCreateRequest;
use App\Request\SubscriptionUpdateRequest;
use App\Request\SubscriptionUpdateFinisheRequest;
use Doctrine\ORM\EntityManagerInterface;

class SubscriptionManager
{
    private $autoMapping;
    private $entityManager;
    private $subscribeRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SubscriptionEntityRepository $subscribeRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->subscribeRepository = $subscribeRepository;
    }

    public function create(SubscriptionCreateRequest $request)
    {
        $subscriptionEntity = $this->autoMapping->map(SubscriptionCreateRequest::class, SubscriptionEntity::class, $request);

        $this->entityManager->persist($subscriptionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $subscriptionEntity;
    }

    public function activeSubscription($userId)
    {
        return $this->subscribeRepository->activeSubscription($userId);
    }

    public function update(SubscriptionUpdateRequest $request)
    {
        $subscribeEntity = $this->subscribeRepository->find($request->getId());
        
        $request->setOwnerID($subscribeEntity->getOwnerID());
        $request->setStartDate($subscribeEntity->getStartDate());
        $request->setEndDate($request->getEndDate());

        if (!$subscribeEntity) {
            return null;
        }

        $subscribeEntity = $this->autoMapping->mapToObject(SubscriptionUpdateRequest::class, SubscriptionEntity::class, $request, $subscribeEntity);

        $this->entityManager->flush();

        return $subscribeEntity;
    }

    public function updateFinishe($id, $status)
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
        
        $subscribeEntity->setStatus($status);

        if (!$subscribeEntity) {
            return null;
        }

        $subscribeEntity = $this->autoMapping->map(SubscriptionUpdateFinisheRequest::class, SubscriptionEntity::class, $subscribeEntity);

        $this->entityManager->flush();

        return $subscribeEntity;
    }

    public function getSubscriptionsPending()
    {
        return $this->subscribeRepository->getSubscriptionsPending();
    }

    public function getSubscriptionById($id)
    {
        return $this->subscribeRepository->getSubscriptionById($id);
    }

    public function subscriptionIsActive($ownerID)
    {
        return $this->subscribeRepository->subscriptionIsActive($ownerID);
    }

    public function countpendingContracts()
    {
        return $this->subscribeRepository->countpendingContracts();
    }

    public function countDoneContracts()
    {
        return $this->subscribeRepository->countDoneContracts();
    }

    public function countCancelledContracts()
    {
        return $this->subscribeRepository->countCancelledContracts();
    }

    public function getRemainingOrders($ownerID)
    {
        return $this->subscribeRepository->getRemainingOrders($ownerID);
    }
}
