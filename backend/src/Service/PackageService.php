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

    public function __construct(AutoMapping $autoMapping, PackageManager $packageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->packageManager = $packageManager;
    }

    public function create(PackageCreateRequest $request)
    {
        $result = $this->packageManager->create($request);

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $result);
    }

    public function getPackages()
    {
        $respons = [];
        $items = $this->packageManager->getPackages();

        foreach ($items as $item) {
            $respons[] = $this->autoMapping->map('array', PackageResponse::class, $item);
        }
        return $respons;
    }

    public function getAllpackages()
    {
        return $this->packageManager->getAllpackages();
    }

    public function getpackagesById($id)
    {
        return $this->packageManager->getpackagesById($id);
    }

    public function update($request)
    {
        $result = $this->packageManager->update($request);

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $result);
    }
}
