<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\UpdateEntity;
use App\Repository\UpdateEntityRepository;
use App\Request\UpdateCreateRequest;
use App\Request\UpdateUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class UpdateManager
{
    private $autoMapping;
    private $entityManager;
    private $updateEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UpdateEntityRepository $updateEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->updateEntityRepository = $updateEntityRepository;
    }

    public function create(UpdateCreateRequest $request)
    {
        $entity = $this->autoMapping->map(UpdateCreateRequest::class, UpdateEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function update(UpdateUpdateRequest $request)
    {
        $entity = $this->updateEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(UpdateUpdateRequest::class, UpdateEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    } 

    public function getUpdateById($id)
    {
        return $this->updateEntityRepository->getUpdateById($id);
    }

    public function getUpdateAll()
    {
       return $this->updateEntityRepository->getUpdateAll();
    }

}
