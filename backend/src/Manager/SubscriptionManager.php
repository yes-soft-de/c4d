<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\SubscriptionCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class SubscriptionManager
{
    private $autoMapping;
    private $entityManager;
    private $subscriptionEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SubscriptionEntityRepository $subscriptionEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->subscriptionEntityRepository = $subscriptionEntityRepository;
    }

    public function create(SubscriptionCreateRequest $request)
    {
        $subscriptionEntity = $this->autoMapping->map(SubscriptionCreateRequest::class, SubscriptionEntity::class, $request);

        $this->entityManager->persist($subscriptionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $subscriptionEntity;
    }

    public function getCurrentSubscriptions()
    {
        return $this->subscriptionEntityRepository->getCurrentSubscribedPackages();
    }
}
