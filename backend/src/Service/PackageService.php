<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\PackageEntity;
use App\Manager\PackageManager;
use App\Request\PackageCreateRequest;
use App\Response\PackageResponse;

class PackageService
{
    private $autoMapping;
    private $packageManager;

    public function __construct(AutoMapping $autoMapping, PackageManager $carManager)
    {
        $this->autoMapping = $autoMapping;
        $this->packageManager = $carManager;
    }

    public function create(PackageCreateRequest $request)
    {
        $carResult = $this->packageManager->create($request);

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $carResult);
    }

    public function getByCityOwner($location)
    {
        return $this->packageManager->getByCityOwner($location);
    }

    public function getActivePackages()
    {
        return $this->packageManager->getActivePackages();
    }

    public function update($request)
    {
        $carResult = $this->packageManager->update($request);

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $carResult);
    }
}