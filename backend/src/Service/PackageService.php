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

    public function getPackages($user)
    {
        $respons = [];
        $items = $this->packageManager->getPackages($user);

        foreach ($items as $item) {
            $respons[] = $this->autoMapping->map('array', PackageResponse::class, $item);
        }
        return $respons;
    }

    public function getActivePackages()
    {
        return $this->packageManager->getActivePackages();
    }

    public function update($request)
    {
        $result = $this->packageManager->update($request);

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $result);
    }
}
