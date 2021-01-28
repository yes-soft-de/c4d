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

    public function datings()
    {
        $response = [];
        $items = $this->datingManager->datings();
        foreach ($items as $item) {
        $response[] =  $this->autoMapping->map('array', DatingResponse::class, $item);
        }
        return $response;
    }

    public function update($request)
    {
        $result = $this->datingManager->update($request);

        return $this->autoMapping->map(DatingEntity::class, DatingResponse::class, $result);
    }
}
