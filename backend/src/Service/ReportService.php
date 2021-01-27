<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ReportEntity;
use App\Manager\ReportManager;
use App\Request\ReportCreateRequest;
use App\Response\ReportResponse;

class ReportService
{
    private $autoMapping;
    private $ReportManager;

    public function __construct(AutoMapping $autoMapping, ReportManager $reportManager)
    {
        $this->autoMapping = $autoMapping;
        $this->reportManager = $reportManager;
    }

    public function create(ReportCreateRequest $request)
    {
        $reprot = $this->reportManager->create($request);

        return $this->autoMapping->map(ReportEntity::class, ReportResponse::class, $reprot);
    }

    // public function update($request)
    // {
    //     $result = $this->branchesManager->update($request);

    //     return $this->autoMapping->map(BranchesEntity::class, BranchesResponse::class, $result);
    // }

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
