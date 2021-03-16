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
    private $recordService;

    public function __construct(AutoMapping $autoMapping, ReportManager $reportManager, RecordService $recordService)
    {
        $this->autoMapping = $autoMapping;
        $this->reportManager = $reportManager;
        $this->recordService = $recordService;
    }

    public function create(ReportCreateRequest $request)
    {
        $uuid =$this->recordService->uuid();
        
        $reprot = $this->reportManager->create($request, $uuid);

        return $this->autoMapping->map(ReportEntity::class, ReportResponse::class, $reprot);
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
}