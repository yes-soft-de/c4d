<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\DatingEntity;
use App\Repository\DatingEntityRepository;
use App\Request\DatingCreateRequest;
use App\Request\DatingUpdateIsDoneRequest;
use Doctrine\ORM\EntityManagerInterface;

class DatingManager
{
    private $autoMapping;
    private $entityManager;
    private $repository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DatingEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->repository = $repository;
    }

    public function create(DatingCreateRequest $request)
    {
        $entity = $this->autoMapping->map(DatingCreateRequest::class, DatingEntity::class, $request);
        $entity->setIsDone(false);
        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function datings()
    {
        return $this->repository->datings();
    }

    public function update(DatingUpdateIsDoneRequest $request)
    {
        $entity = $this->repository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(DatingUpdateIsDoneRequest::class, DatingEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }

}
