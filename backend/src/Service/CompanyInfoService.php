<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\CompanyInfoEntity;
use App\Manager\CompanyInfoManager;
use App\Request\CompanyInfoCreateRequest;
use App\Request\companyInfoUpdateRequest;
use App\Response\CompanyInfoResponse;

class CompanyInfoService
{
    private $autoMapping;
    private $companyInfoManager;

    public function __construct(AutoMapping $autoMapping, CompanyInfoManager $companyInfoManager)
    {
        $this->autoMapping = $autoMapping;
        $this->companyInfoManager = $companyInfoManager;
    }

    public function create(CompanyInfoCreateRequest $request)
    {
        $item = $this->companyInfoManager->create($request);
        if ($item instanceof CompanyInfoEntity) {
        return $this->autoMapping->map(CompanyInfoEntity::class, CompanyInfoResponse::class, $item);
        }
        if ($item == true) {
          
            return $this->getcompanyinfoAll();
        }
    }

    public function update($request)
    {
        $result = $this->companyInfoManager->update($request);

        return $this->autoMapping->map(CompanyInfoEntity::class, CompanyInfoResponse::class, $result);
    }

    public function  getcompanyinfoById($id)
    {
        $result = $this->companyInfoManager->getcompanyinfoById($id);

        return $this->autoMapping->map(CompanyInfoEntity::class, CompanyInfoResponse::class, $result);
  
    }

    public function  getcompanyinfoAll()
    {
        $respons=[];
        $results = $this->companyInfoManager->getcompanyinfoAll();
       
        foreach ($results as  $result) {
           $respons[]= $this->autoMapping->map('array', CompanyInfoResponse::class, $result);
        }
        return $respons;
       
    }

     public function  getcompanyinfoAllOwner($userId)
    {
        $respons=[];
        $results = $this->companyInfoManager->getcompanyinfoAllOwner($userId);
       
        foreach ($results as  $result) {
           $respons[]= $this->autoMapping->map('array', CompanyInfoResponse::class, $result);
        }
        return $respons;
       
    }

    public function  getcompanyinfoAllCaptain($userId)
    {
        $respons=[];
        $results = $this->companyInfoManager->getcompanyinfoAllCaptain($userId);
       
        foreach ($results as  $result) {
           $respons[]= $this->autoMapping->map('array', CompanyInfoResponse::class, $result);
        }
        return $respons;
       
    }

}
