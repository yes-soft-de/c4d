<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\PackageEntity;
use App\Repository\PackageEntityRepository;
use App\Request\PackageCreateRequest;
use App\Request\PackageUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class PackageManager
{
    private $autoMapping;
    private $entityManager;
    private $packageRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PackageEntityRepository $packageRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->packageRepository = $packageRepository;
    }

    public function create(PackageCreateRequest $request)
    {
        $packageEntity = $this->autoMapping->map(PackageCreateRequest::class, PackageEntity::class, $request);

        $this->entityManager->persist($packageEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $packageEntity;
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

    public function update(PackageUpdateRequest $request)
    {
        $entity = $this->packageRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(PackageUpdateRequest::class, PackageEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }
}
