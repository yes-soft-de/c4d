<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Entity\CaptainProfileEntity;
use App\Manager\UserManager;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\userProfileUpdateByAdminRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\CaptainProfileCreateResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
use App\Response\RemainingOrdersResponse;
use App\Response\CaptainsOngoingResponse;
use App\Response\CaptainTotalBounceResponse;


class UserService
{
    private $autoMapping;
    private $userManager;
    private $acceptedOrderService;
    private $ratingService;
    private $branchesService;
    private $recordService;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, AcceptedOrderService $acceptedOrderService, RatingService $ratingService, BranchesService $branchesService, RecordService $recordService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->acceptedOrderService = $acceptedOrderService;
        $this->ratingService = $ratingService;
        $this->branchesService = $branchesService;
        $this->recordService = $recordService;
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->userManager->userRegister($request);

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $uuid = $this->recordService->uuid();
        $userProfile = $this->userManager->userProfileCreate($request, $uuid);

        if ($userProfile instanceof UserProfile) {

            return $this->autoMapping->map(UserProfileEntity::class,UserProfileCreateResponse::class, $userProfile);
       }
        if ($userProfile == true) {
          
           return $this->getUserProfileByUserID($request->getUserID());
       }
    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->userManager->userProfileUpdate($request);

        return $this->autoMapping->map(UserProfileEntity::class, UserProfileResponse::class, $item);
    }

    public function userProfileUpdateByAdmin(userProfileUpdateByAdminRequest $request)
    {
        $item = $this->userManager->userProfileUpdateByAdmin($request);

        return $this->autoMapping->map(UserProfileEntity::class, UserProfileResponse::class, $item);
    }

    public function getUserProfileByID($id)
    {
        $item = $this->userManager->getUserProfileByID($id);
        $item['branches'] = $this->branchesService->branchesByUserId($item['userID']);
        return $this->autoMapping->map('array', UserProfileCreateResponse::class, $item);
    }

    public function getUserProfileByUserID($userID)
    {
        $item = $this->userManager->getUserProfileByUserID($userID);
        $item['branches'] = $this->branchesService->branchesByUserId($userID);
        return $this->autoMapping->map('array', UserProfileCreateResponse::class, $item);
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
        $uuid = $this->recordService->uuid();
        $captainProfile = $this->userManager->captainprofileCreate($request, $uuid);
       
        if ($captainProfile instanceof captainProfile) {
            return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $captainProfile);
        }
        if ($captainProfile == true) {
           
            return $this->getcaptainprofileByCaptainID($request->getCaptainID());
        }
       
    }

    public function captainprofileUpdate(CaptainProfileUpdateRequest $request, $captainID)
    {
        $item = $this->userManager->captainprofileUpdate($request, $captainID);

        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function captainprofileUpdateByAdmin(CaptainProfileUpdateByAdminRequest $request)
    {
        $item = $this->userManager->captainprofileUpdateByAdmin($request);

        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function getcaptainprofileByCaptainID($captainID)
    {
        $response=[];

        $item = $this->userManager->getcaptainprofileByCaptainID($captainID);

        $bounce = $this->totalBounceCaptain($item['id']);

        $countOrdersDeliverd = $this->acceptedOrderService->countAcceptedOrder($captainID);

        $item['rating'] = $this->ratingService->getRatingByCaptainID($captainID);
        $response = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
      
        $response->bounce = $bounce;
        $response->countOrdersDeliverd = $countOrdersDeliverd;

        return $response;
    }

    public function getCaptainprofileByID($captainProfileId)
    {
        $response=[];
        $item = $this->userManager->getCaptainprofileByID($captainProfileId);
   
        $totalBounce = $this->totalBounceCaptain($item['id']);
        
        $countOrdersDeliverd = $this->acceptedOrderService->countAcceptedOrder($item['captainID']);

        $item['rating'] = $this->ratingService->getRatingByCaptainID($item['captainID']);
    
        $response =  $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);

        $response->totalBounce = $totalBounce;
        $response->countOrdersDeliverd = $countOrdersDeliverd;
      
        return $response;
    }

    public function getUserInactive($userType)
    {
        $response = [];
        $items = $this->userManager->getUserInactive($userType);

        if($userType == "captain") {
            foreach( $items as  $item ) {
                $response[]  = $this->autoMapping->map('array', CaptainProfileEntity::class, $item);
            }
        }
        if($userType == "owner") {
            foreach( $items as  $item ) {
                $response[]  = $this->autoMapping->map('array', UserProfileResponse::class, $item);
            }
        }
     return $response;
    }
    public function getCaptainsState($state)
    {
        $response = [];
        $items = $this->userManager->getCaptainsState($state);

        foreach( $items as  $item ) {
           
            $item['totalBounce'] = $this->totalBounceCaptain($item['id']);
           
            $item['countOrdersDeliverd'] = $this->acceptedOrderService->countAcceptedOrder($item['captainID']);
           
            $item['rating'] = $this->ratingService->getRatingByCaptainID($item['captainID']);
            
            $response[]  = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
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

    
     public function dashboardCaptains()
     {
         $response = [];

         $response[] = $this->userManager->countpendingCaptains();
         $response[] = $this->userManager->countOngoingCaptains();
         $response[] = $this->userManager->countDayOfCaptains();
//
// replace this to top 5 captain
         $dayOfCaptains = $this->userManager->getDayOfCaptains();
      
         foreach ($dayOfCaptains as $item) {
          
            $response[]  = $this->autoMapping->map('array',CaptainProfileCreateResponse::class,  $item);
         }         
         return $response;
     }

     public function GetDayOfCaptains()
     {
         $response = [];

         $dayOfCaptains = $this->userManager->getDayOfCaptains();
      
         foreach ($dayOfCaptains as $item) {
          
            $response[]  = $this->autoMapping->map('array',CaptainProfileCreateResponse::class,  $item);
         }         
         return $response;
     }

     public function totalBounceCaptain($captainProfileId)
    {
        $response = [];
        $item = $this->userManager->totalBounceCaptain($captainProfileId);
      
        if ($item) {
             $countAcceptedOrder = $this->acceptedOrderService->countAcceptedOrder($item[0]['captainID']);

             $item['bounce'] = $item[0]['bounce'] * $countAcceptedOrder[0]['countOrdersDeliverd'];

             $response  = $this->autoMapping->map('array', CaptainTotalBounceResponse::class,  $item);
        }

        return $response;
    }
}
