<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\RecordEntity;
use App\Repository\RecordEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class RecordManager
{
    private $autoMapping;
    private $entityManager;
    private $repository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RecordEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->repository = $repository;
    }

    public function create($record)
    {
        $recordEntity = $this->autoMapping->map('array', RecordEntity::class, $record);
        $recordEntity->setDate($recordEntity->getDate());
        
        $this->entityManager->persist($recordEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $recordEntity;
    }

    public function getRecordByOrderId($orderId)
    {
        return $this->repository->getRecordByOrderId($orderId);
    }

    public function getRecordsByOrderId($orderId)
    {
        return $this->repository->getRecordsByOrderId($orderId);
    }

    public function getFirstDate($orderId)
    {
        return $this->repository->getFirstDate($orderId);
    }
    
    public function getLastDate($orderId)
    {
        return $this->repository->getLastDate($orderId);
    }
}
