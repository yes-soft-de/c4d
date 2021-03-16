<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UpdateEntity;
use App\Manager\UpdateManager;
use App\Request\UpdateCreateRequest;
// use App\Request\UpdateRequest;
use App\Response\UpdateResponse;

class UpdateService
{
    private $autoMapping;
    private $updateManager;

    public function __construct(AutoMapping $autoMapping, UpdateManager $updateManager)
    {
        $this->autoMapping = $autoMapping;
        $this->updateManager = $updateManager;
    }

    public function create(UpdateCreateRequest $request)
    {
        $item = $this->updateManager->create($request);

        return $this->autoMapping->map(UpdateEntity::class, UpdateResponse::class, $item);
    }

    public function update($request)
    {
        $result = $this->updateManager->update($request);

        return $this->autoMapping->map(UpdateEntity::class, UpdateResponse::class, $result);
    }

    public function  getUpdateById($id)
    {
        $result = $this->updateManager->getUpdateById($id);
        return $this->autoMapping->map(UpdateEntity::class, UpdateResponse::class, $result);
  
    }

    public function  getUpdateAll()
    {
        $respons=[];
        $results = $this->updateManager->getUpdateAll();
       
        foreach ($results as  $result) {
           $respons[]= $this->autoMapping->map('array', UpdateResponse::class, $result);
        }
        return $respons;
       
    }

}
