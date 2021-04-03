<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\RoomIdHelperEntity;
use App\Repository\RoomIdHelperEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\RoomIdHelperCreateRequest;

class RoomIdHelperManager
{
    private $autoMapping;
    private $entityManager;
    private $repository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RoomIdHelperEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->repository = $repository;
    }

    public function create($request)
    {
        $entity = $this->autoMapping->map('array', RoomIdHelperEntity::class, $request);
        $entity->setCaptainID($request[0]['captainID']);
        $entity->setOwnerID($request[0]['ownerID']);
        $entity->setRoomID($request[0]['uuid']);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getByRoomID($roomID)
    {
        return $this->repository->getByRoomID($roomID);
    }
}
