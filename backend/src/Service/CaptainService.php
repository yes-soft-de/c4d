<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\CaptainProfileEntity;
use App\Manager\CaptainManager;
use App\Request\CaptainProfileCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserRegisterResponse;

class CaptainService
{
    private $autoMapping;
    private $captainManager;

    public function __construct(AutoMapping $autoMapping, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainManager = $captainManager;
    }

    public function captainprofileCreate(CaptainProfileCreateRequest $request)
    {
        $captainProfile = $this->captainManager->captainprofileCreate($request);
       
        if ($captainProfile instanceof captainProfile) {
            return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $captainProfile);
        }
        else if ($captainProfile == 1) {
           
            return $this->getcaptainprofileByID($request->getCaptainID());
        }
       
    }

    public function captainprofileUpdate(CaptainProfileUpdateRequest $request)
    {
        $item = $this->captainManager->captainprofileUpdate($request);

        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function getcaptainprofileByID($userID)
    {
        $item = $this->captainManager->getcaptainprofileByID($userID);

        return $this->autoMapping->map('array', CaptainProfileEntity::class, $item);
    }

    public function getCaptainsInactive()
    {
        $response = [];
        $items = $this->captainManager->getCaptainsInactive();
        
        foreach( $items as  $item ) {
             $response  = $this->autoMapping->map('array', CaptainProfileEntity::class, $item);
        }
     return $response;
    }
}
