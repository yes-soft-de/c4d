<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\SubscriptionCreateRequest;
use App\Request\SubscriptionNextRequest;
use App\Request\SubscriptionChangeIsFutureRequest;
use App\Request\SubscriptionUpdateRequest;
use App\Request\SubscriptionUpdateStateRequest;
use App\Request\SubscriptionUpdateFinisheRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
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
        // NOTE: change active to inactive 
        $request->setStatus('active');
        $request->setIsFuture(0);
        $subscriptionEntity = $this->autoMapping->map(SubscriptionCreateRequest::class, SubscriptionEntity::class, $request);

        $this->entityManager->persist($subscriptionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $subscriptionEntity;
    }

    public function nxetSubscription(SubscriptionNextRequest $request, $status)
    { 
        // NOTE: change active to inactive 
        $request->setStatus('active');
       
        if($status == "active") {
             $request->setIsFuture(1);
             }
        else{
            $request->setIsFuture(0);
        }
        $subscriptionEntity = $this->autoMapping->map(SubscriptionNextRequest::class, SubscriptionEntity::class, $request);
    // tell talal and mohammed befor active    
    // to save subscribe end date automatic
       // $subscriptionEntity->setEndDate(date_modify(new DateTime('now'),'+1 month'));

        $this->entityManager->persist($subscriptionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $subscriptionEntity;
    }

    public function getSubscriptionForOwner($userId)
    {
        return $this->subscribeRepository->getSubscriptionForOwner($userId);
    }

    public function subscriptionUpdateState(SubscriptionUpdateStateRequest $request)
    {
        $subscribeEntity = $this->subscribeRepository->find($request->getId());
        
        $request->setEndDate($request->getEndDate());

        if (!$subscribeEntity) {
            return null;
        }

        $subscribeEntity = $this->autoMapping->mapToObject(SubscriptionUpdateStateRequest::class, SubscriptionEntity::class, $request, $subscribeEntity);

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

    public function changeIsFutureToFalse($id)
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
    //Make this subscription the current subscription
        $subscribeEntity->setIsFuture(0);
    //The end date of the previous subscription is the start date of the current subscription
        $subscribeEntity->setStartDate(new DateTime('now'));

        $subscribeEntity->setEndDate(date_modify(new DateTime('now'),'+1 month'));

        if (!$subscribeEntity) {
            return null;
        }

        $subscribeEntity = $this->autoMapping->map(SubscriptionChangeIsFutureRequest::class, SubscriptionEntity::class, $subscribeEntity);

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

    public function subscriptionIsActive($ownerID, $subscribeId)
    {
        return $this->subscribeRepository->subscriptionIsActive($ownerID, $subscribeId);
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

    public function getRemainingOrders($ownerID, $id)
    {
        return $this->subscribeRepository->getRemainingOrders($ownerID, $id);
    }

    public function subscripeNewUsers($fromDate, $toDate)
    {
        return $this->subscribeRepository->subscripeNewUsers($fromDate, $toDate);
    }

    public function getSubscriptionCurrent($ownerID)
    {
        return $this->subscribeRepository->getSubscriptionCurrent($ownerID);
    }

    public function getNextSubscription($ownerID)
    {
        return $this->subscribeRepository->getNextSubscription($ownerID);
    }

    public function totalAmountOfSubscriptions($ownerID)
    {
        return $this->subscribeRepository->totalAmountOfSubscriptions($ownerID);
    }
}
