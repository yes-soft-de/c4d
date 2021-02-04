<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\BranchesEntity;
use App\Repository\BranchesEntityRepository;
use App\Request\BranchesCreateRequest;
use App\Request\BranchesUpdateRequest;
use App\Request\BranchesDeleteRequest;
use Doctrine\ORM\EntityManagerInterface;

class BranchesManager
{
    private $autoMapping;
    private $entityManager;
    private $branchesRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, BranchesEntityRepository $branchesRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->branchesRepository = $branchesRepository;
    }

    public function create(BranchesCreateRequest $request)
    {
        $entity = $this->autoMapping->map(BranchesCreateRequest::class, BranchesEntity::class, $request);
        $entity->setIsActive(1);
        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function update(BranchesUpdateRequest $request)
    {
        $entity = $this->branchesRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        
        $entity = $this->autoMapping->mapToObject(BranchesUpdateRequest::class, BranchesEntity::class, $request, $entity);
        $this->entityManager->flush();

        return $entity;
    }

    public function getBranchesByUserId($userId)
    {
        return $this->branchesRepository->getBranchesByUserId($userId);
    }

    public function branchesByUserId($userId)
    {
        return $this->branchesRepository->branchesByUserId($userId);
    }

    public function getBrancheById($Id)
    {
        return $this->branchesRepository->find($Id);
    }

    public function updateIsActiveBranche(BranchesDeleteRequest $request)
    {
        $entity = $this->branchesRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(BranchesDeleteRequest::class, BranchesEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }
}
