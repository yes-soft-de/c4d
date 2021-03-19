<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\VacationsEntity;
use App\Repository\VacationsEntityRepository;
use App\Request\VacationsCreateRequest;
use App\Request\VacationsUpdateStateRequest;
use Doctrine\ORM\EntityManagerInterface;

class VacationsManager
{
    private $autoMapping;
    private $entityManager;
    private $vacationsRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, VacationsEntityRepository $vacationsRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->vacationsRepository = $vacationsRepository;
    }

    public function create(VacationsCreateRequest $request)
    {
        $entity = $this->autoMapping->map(VacationsCreateRequest::class, VacationsEntity::class, $request);

        $entity->setStartDate($request->getStartDate());
        $entity->setEndDate($request->getEndDate());

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getPackages($user)
    {
        return $this->packageRepository->getPackages($user);
    }

    public function getAllpackages()
    {
        return $this->packageRepository->getAllpackages();
    }
    public function getpackagesById($id)
    {
        return $this->packageRepository->getpackagesById($id);
    }

    public function update(PackageUpdateStateRequest $request)
    {
        $entity = $this->packageRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(PackageUpdateStateRequest::class, PackageEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }
}
