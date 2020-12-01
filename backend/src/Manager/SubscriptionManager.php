<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\SubscriptionCreateRequest;
use App\Request\SubscriptionUpdateRequest;
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

    public function getCurrentSubscriptions($userId)
    {
        return $this->subscribeRepository->getCurrentSubscribedPackages($userId);
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
}
