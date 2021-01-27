<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\DatingEntity;
use App\Repository\DatingEntityRepository;
use App\Request\DatingCreateRequest;
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

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function update(BranchesUpdateRequest $request)
    {
        $entity = $this->repository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(BranchesUpdateRequest::class, BranchesEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function datings()
    {
        return $this->repository->datings();
    }
}
