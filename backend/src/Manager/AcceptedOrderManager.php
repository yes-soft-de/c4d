<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Repository\AcceptedOrderEntityRepository;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\GetByIdRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class AcceptedOrderManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $repository;
    private $userProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, AcceptedOrderEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->repository = $repository;
    }

    public function create(AcceptedOrderCreateRequest $request)
    {
        $item = $this->autoMapping->map(AcceptedOrderCreateRequest::class, AcceptedOrderEntity::class, $request);

        $this->entityManager->persist($item);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $item;
    }

    public function acceptedOrder($userID, $ID)
    {
        return $this->repository->acceptedOrder($userID, $ID);
    }

    public function totalEarn($userID)
    {
        return $this->repository->totalEarn($userID);
    }

    public function closestOrders()
    {
        return $this->repository->closestOrders();
    }
}
