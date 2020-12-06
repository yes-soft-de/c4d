<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Entity\CaptainProfileEntity;
use App\Manager\UserManager;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\CaptainProfileCreateResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
use App\Response\RemainingOrdersResponse;
use App\Response\CaptainsOngoingResponse;
use App\Service\AcceptedOrderService;

class UserService
{
    private $autoMapping;
    private $userManager;
    private $acceptedOrderService;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, AcceptedOrderService $acceptedOrderService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->acceptedOrderService = $acceptedOrderService;
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->userManager->userRegister($request);

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $userProfile = $this->userManager->userProfileCreate($request);

        if ($userProfile instanceof UserProfile) {

            return $this->autoMapping->map(UserProfileEntity::class,UserProfileCreateResponse::class, $userProfile);
       }
       else if ($userProfile == 1) {
          
           return $this->getUserProfileByUserID($request->getUserID());
       }
    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->userManager->userProfileUpdate($request);

        return $this->autoMapping->map(UserProfileEntity::class, UserProfileResponse::class, $item);
    }

    public function getUserProfileByUserID($userID)
    {
        $item = $this->userManager->getProfileByUserID($userID);

        return $this->autoMapping->map('array', UserProfileResponse::class, $item);
    }

    public function getremainingOrders($userID)
    {
        $respons = [];
        $items = $this->userManager->getremainingOrders($userID);

        foreach ($items as $item) {
            $respons = $this->autoMapping->map('array', RemainingOrdersResponse::class, $item);
        }
        return $respons;
    }

    public function captainprofileCreate(CaptainProfileCreateRequest $request)
    {
        $captainProfile = $this->userManager->captainprofileCreate($request);
       
        if ($captainProfile instanceof captainProfile) {
            return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $captainProfile);
        }
        else if ($captainProfile == 1) {
           
            return $this->getcaptainprofileByID($request->getCaptainID());
        }
       
    }

    public function captainprofileUpdate(CaptainProfileUpdateRequest $request)
    {
        $item = $this->userManager->captainprofileUpdate($request);

        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function getcaptainprofileByCaptainID($userID)
    {
        $response=[];
        $item = $this->userManager->getcaptainprofileByCaptainID($userID);
        $captaintotalEarn = $this->acceptedOrderService->totalEarn($userID);
        $countOrdersDeliverd = $this->acceptedOrderService->countOrdersDeliverd($userID);
   
        $response = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
      
        $response->captaintotalEarn = $captaintotalEarn;
        $response->countOrdersDeliverd = $countOrdersDeliverd;

        return $response;
    }

    public function getCaptainprofileByID($id)
    {
        $response=[];
        $item = $this->userManager->getCaptainprofileByID($id);
   
        $captaintotalEarn = $this->acceptedOrderService->totalEarn($item['captainID']);
        $countOrdersDeliverd = $this->acceptedOrderService->countOrdersDeliverd($item['captainID']);
   
    
        $response =  $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);

        $response->captaintotalEarn = $captaintotalEarn;
        $response->countOrdersDeliverd = $countOrdersDeliverd;
      
        return $response;
    }

    public function getUserInactive($userType)
    {
        $response = [];
        $items = $this->userManager->getUserInactive($userType);

        if($userType == "captain") {
            foreach( $items as  $item ) {
                $response  = $this->autoMapping->map('array', CaptainProfileEntity::class, $item);
            }
        }
        if($userType == "owner") {
            foreach( $items as  $item ) {
                $response  = $this->autoMapping->map('array', UserProfileResponse::class, $item);
            }
        }
     return $response;
    }
    public function getCaptinsActive()
    {
        $response = [];
        $items = $this->userManager->getCaptinsActive();
            foreach( $items as  $item ) {
                $response  = $this->autoMapping->map('array', CaptainProfileEntity::class, $item);
            }
        return $response;
    }

    public function captainIsActive($captainID)
    {
        $item = $this->userManager->captainIsActive($captainID);
        if ($item) {
          return  $item[0]['status'];
        }

        return $item ;
     }

    public function ongoingCaptains()
     {
         $response = [];
         $items = $this->userManager->ongoingCaptains();
       
         foreach ($items as $item) {
             $response[] = $this->autoMapping->map('array', CaptainsOngoingResponse::class, $item);
         }
         return $response;
     }

    public function pendingCaptains()
     {
         $response = [];
         $items = $this->userManager->pendingCaptains();
     
         foreach ($items as $item) {
             $response[] = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
         }
         return $response;
     }

    public function dayOfCaptains()
     {
         $response = [];
         $items = $this->userManager->dayOfCaptains();
       
         foreach ($items as $item) {
             $response[] = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
         }
         return $response;
     }

     public function dashboardCaptains()
     {
         $response = [];

         $response[] = $this->userManager->countpendingCaptains();
         $response[] = $this->userManager->countOngoingCaptains();
         $response[] = $this->userManager->countDayOfCaptains();

         return $response;
     }
 
}
