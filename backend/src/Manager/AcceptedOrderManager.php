<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Repository\AcceptedOrderEntityRepository;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Request\GetByIdRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class AcceptedOrderManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $repository;

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

    public function acceptedOrder($userID, $acceptedOrderId)
    {
        return $this->repository->acceptedOrder($userID, $acceptedOrderId);
    }

    public function totalEarn($userID)
    {
        return $this->repository->totalEarn($userID);
    }

    public function closestOrders()
    {
        return $this->repository->closestOrders();
    }

    public function update(AcceptedOrderUpdateRequest $request)
    {
        $acceptedOrderEntity = $this->repository->find($request->getId());
        $request->setDate($acceptedOrderEntity->getDate());
        if (!$acceptedOrderEntity) {
            return null;
        }
        $acceptedOrderEntity = $this->autoMapping->mapToObject(AcceptedOrderUpdateRequest::class, AcceptedOrderEntity::class, $request, $acceptedOrderEntity);

        $this->entityManager->flush();

        return $acceptedOrderEntity;
    }
}
