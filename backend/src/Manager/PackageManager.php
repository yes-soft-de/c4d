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
    private $packageEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PackageEntityRepository $packageEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->packageEntityRepository = $packageEntityRepository;
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
        return $this->packageEntityRepository->getPackages($user);
    }

    public function getActivePackages()
    {
        return $this->packageEntityRepository->getActivePackages();
    }

    public function update(PackageUpdateRequest $request)
    {
        $packageEntity = $this->packageEntityRepository->find($request->getId());

        if(!$packageEntity)
        {
            return null;
        }
        else
        {
            $packageEntity = $this->autoMapping->mapToObject(PackageUpdateRequest::class,
                PackageEntity::class, $request, $packageEntity);

            $this->entityManager->flush();

            return $packageEntity;
        }
    }


}