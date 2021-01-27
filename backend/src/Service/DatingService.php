<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\DatingEntity;
use App\Manager\DatingManager;
use App\Request\DatingCreateRequest;
use App\Response\DatingResponse;

class DatingService
{
    private $autoMapping;
    private $datingManager;

    public function __construct(AutoMapping $autoMapping, DatingManager $datingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->datingManager = $datingManager;
    }

    public function create(DatingCreateRequest $request)
    {
        $reprot = $this->datingManager->create($request);

        return $this->autoMapping->map(DatingEntity::class, DatingResponse::class, $reprot);
    }

    public function getReports()
    {
        $response = [];
        $items = $this->reportManager->getReports();
        foreach ($items as $item) {
        $response[] =  $this->autoMapping->map('array', ReportResponse::class, $item);
        }
        return $response;
    }

    // public function branchesByUserId($userId)
    // {
    //     return $this->branchesManager->branchesByUserId($userId);
    // }

    // public function getBrancheById($Id)
    // {
    //     return $this->branchesManager->getBrancheById($Id);
    // }
}