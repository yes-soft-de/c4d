<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\PaymentsCaptainEntity;
use App\Repository\PaymentsCaptainEntityRepository;
use App\Request\PaymentCaptainCreateRequest;
// use App\Request\RatingUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class PaymentCaptainManager
{
    private $autoMapping;
    private $entityManager;
    private $repository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PaymentsCaptainEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->repository = $repository;
    }

    public function create(PaymentCaptainCreateRequest $request)
    {
        $entity = $this->autoMapping->map(PaymentCaptainCreateRequest::class, PaymentsCaptainEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getpayments($captainId)
    {
        return $this->repository->getpayments($captainId);
    }

    public function getSumAmount($captainId)
    {
        return $this->repository->getSumAmount($captainId);
    }
}
