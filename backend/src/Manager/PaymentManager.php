<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\PaymentsEntity;
use App\Repository\PaymentsEntityRepository;
use App\Request\PaymentCreateRequest;
// use App\Request\RatingUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class PaymentManager
{
    private $autoMapping;
    private $entityManager;
    private $repository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PaymentsEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->repository = $repository;
    }

    public function create(PaymentCreateRequest $request)
    {
        $entity = $this->autoMapping->map(PaymentCreateRequest::class, PaymentsEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getpaymentsForOwner($ownerId)
    {
        return $this->repository->getpaymentsForOwner($ownerId);
    }

    public function getSumAmount($ownerId)
    {
        return $this->repository->getSumAmount($ownerId);
    }

    public function getNewAmount($ownerId)
    {
        return $this->repository->getNewAmount($ownerId);
    }

    // public function ratingByCaptainID($captainID)
    // {
    //     return $this->ratingRepository->ratingByCaptainID($captainID);
    // }
}
