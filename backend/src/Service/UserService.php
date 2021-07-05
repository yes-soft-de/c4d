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
use App\Request\VacationsCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use App\Request\CaptainProfileUpdateByAdminRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\CaptainProfileCreateResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
use App\Response\AllUsersResponse;
use App\Response\CaptainIsActiveResponse;
use App\Response\RemainingOrdersResponse;
use App\Response\CaptainTotalBounceInThisMonthResponse;
use App\Response\CaptainTotalBounceResponse;
use App\Service\PaymentCaptainService;
use App\Service\BankService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use DateTime;

class UserService
{
    private $autoMapping;
    private $userManager;
    private $acceptedOrderService;
    private $ratingService;
    private $branchesService;
    private $recordService;
    private $params;
    private $paymentCaptainService;
    private $bankService;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, AcceptedOrderService $acceptedOrderService, RatingService $ratingService, BranchesService $branchesService, RecordService $recordService, ParameterBagInterface $params, PaymentCaptainService $paymentCaptainService, BankService $bankService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->acceptedOrderService = $acceptedOrderService;
        $this->ratingService = $ratingService;
        $this->branchesService = $branchesService;
        $this->recordService = $recordService;
        $this->paymentCaptainService = $paymentCaptainService;
        $this->bankService = $bankService;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->userManager->userRegister($request);
        if ($userRegister instanceof UserEntity) {
            
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);

        }
        if ($userRegister == true) {
          
            $user = $this->userManager->getUserByUserID($request->getUserID());
            $user['found']="yes";
            return $user;
        }
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
        $bank = $this->bankService->updateFromProfile($request);
        if ($bank) {
        $item->bankName = $bank->bankName;
        $item->accountID = $bank->accountID;
        $item->stcPay = $bank->stcPay;
        }
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
        $item['bank'] = $this->bankService->getAccountByUserId($userID);
        $item['branches'] = $this->branchesService->branchesByUserId($userID);

        try {
            if ($item['image'])
            {
                $item['imageURL'] = $item['image'];
                $item['image'] = $this->params.$item['image'];
            }
            $item['baseURL'] = $this->params;
        }
        catch(\Exception $e) {

        }

        
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
        
        if ($captainProfile instanceof CaptainProfileEntity) {
           
            $item = $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $captainProfile);

            $bank = $this->bankService->createFromCaptain($request);
            if ($bank) {
                $item->bankName = $bank->bankName;
                $item->accountID = $bank->accountID;
                $item->stcPay = $bank->stcPay;
            }
        }
        if ($captainProfile == true) {
            return $this->getcaptainprofileByCaptainID($request->getCaptainID());
        }
    }

    public function captainprofileUpdate(CaptainProfileUpdateRequest $request)
    {
        $item = $this->userManager->captainprofileUpdate($request);
        $bank = $this->bankService->updateFromCaptain($request);
        if ($bank) {
            $item->bankName = $bank->bankName;
            $item->accountID = $bank->accountID;
            $item->stcPay = $bank->stcPay;
        }
        if (!$bank) {
            $bank = $this->bankService->updateFromCreateCaptain($request);
            $item->bankName = $bank->bankName;
            $item->accountID = $bank->accountID;
            $item->stcPay = $bank->stcPay;
        }

        
        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function captainprofileUpdateByAdmin(CaptainProfileUpdateByAdminRequest $request)
    {
        $item = $this->userManager->captainprofileUpdateByAdmin($request);

        return $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $item);
    }

    public function captainvacationbyadmin(VacationsCreateRequest $request)
    {
        return $this->userManager->captainvacationbyadmin($request);

        // return $this->autoMapping->map(CaptainProfileEntity::class, VacationsCreateRequest::class, $item);
    }

    public function getcaptainprofileByCaptainID($captainID)
    {
        $response=[];

        $item = $this->userManager->getcaptainprofileByCaptainID($captainID);

        try {
            $bounce = $this->totalBounceCaptain($item['id'], 'captain', $captainID);

            $countOrdersDeliverd = $this->acceptedOrderService->countAcceptedOrder($captainID);

            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['drivingLicenceURL'] = $item['drivingLicence'];
            $item['drivingLicence'] = $this->params.$item['drivingLicence'];
            $item['mechanicLicense'] = $item['mechanicLicense'];
            $item['mechanicLicense'] = $this->params.$item['mechanicLicense'];
            $item['identity'] = $item['identity'];
            $item['identity'] = $this->params.$item['identity'];
            $item['baseURL'] = $this->params;
            $item['rating'] = $this->ratingService->getRatingByCaptainID($captainID);
            $item['bank'] = $this->bankService->getAccountByUserId($captainID);

            $response = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);

            $response->bounce = $bounce;
            $response->countOrdersDeliverd = $countOrdersDeliverd;

        }
        catch (\Exception $e)
        {

        }
        return $response;
    }

    public function getCaptainprofileByID($captainProfileId)
    {
        $response=[];
        $totalBounce=[];
        $countOrdersDeliverd=[];
        $item = $this->userManager->getCaptainprofileByID($captainProfileId);
        if($item) {
            $totalBounce = $this->totalBounceCaptain($item['id'],'admin');
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['drivingLicenceURL'] = $item['drivingLicence'];
            $item['drivingLicence'] = $this->params.$item['drivingLicence'];
            $item['mechanicLicense'] = $item['mechanicLicense'];
            $item['mechanicLicense'] = $this->params.$item['mechanicLicense'];
            $item['identity'] = $item['identity'];
            $item['identity'] = $this->params.$item['identity'];
            $item['baseURL'] = $this->params;
            $countOrdersDeliverd = $this->acceptedOrderService->countAcceptedOrder($item['captainID']);

            $item['rating'] = $this->ratingService->getRatingByCaptainID($item['captainID']);
        }
        $response =  $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
        if($item) {
            $response->totalBounce = $totalBounce;
            $response->countOrdersDeliverd = $countOrdersDeliverd;
        }
        return $response;
    }

    public function getCaptainprofileByIDStateDayOff($captainProfileId)
    {
        $response=[];
        $totalBounce=[];
        $countOrdersDeliverd=[];
        $item = $this->userManager->getCaptainprofileByIDStateDayOff($captainProfileId);
        if($item) {
            $totalBounce = $this->totalBounceCaptain($item['id'], 'admin');
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['drivingLicenceURL'] = $item['drivingLicence'];
            $item['drivingLicence'] = $this->params.$item['drivingLicence'];
            $item['mechanicLicense'] = $item['mechanicLicense'];
            $item['mechanicLicense'] = $this->params.$item['mechanicLicense'];
            $item['identity'] = $item['identity'];
            $item['identity'] = $this->params.$item['identity'];
            $item['baseURL'] = $this->params;

            $countOrdersDeliverd = $this->acceptedOrderService->countAcceptedOrder($item['captainID']);

            $item['rating'] = $this->ratingService->getRatingByCaptainID($item['captainID']);
        }
        $response =  $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
        if($item) {
            $response->totalBounce = $totalBounce;
            $response->countOrdersDeliverd = $countOrdersDeliverd;
        }
        return $response;
    }

    public function getUserInactive($userType)
    {
        $response = [];
        $items = $this->userManager->getUserInactive($userType);

        if($userType == "captain") {
            foreach( $items as  $item ) {
                $item['imageURL'] = $item['image'];
                $item['image'] = $this->params.$item['image'];
                $item['drivingLicenceURL'] = $item['drivingLicence'];
                $item['drivingLicence'] = $this->params.$item['drivingLicence'];
                $item['mechanicLicense'] = $item['mechanicLicense'];
                $item['mechanicLicense'] = $this->params.$item['mechanicLicense'];
                $item['identity'] = $item['identity'];
                $item['identity'] = $this->params.$item['identity'];
                $item['baseURL'] = $this->params;
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
           
            $item['totalBounce'] = $this->totalBounceCaptain($item['id'], 'admin');
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['drivingLicenceURL'] = $item['drivingLicence'];
            $item['drivingLicence'] = $this->params.$item['drivingLicence'];
            $item['mechanicLicense'] = $item['mechanicLicense'];
            $item['mechanicLicense'] = $this->params.$item['mechanicLicense'];
            $item['identity'] = $item['identity'];
            $item['identity'] = $this->params.$item['identity'];
            $item['baseURL'] = $this->params;

            $item['countOrdersDeliverd'] = $this->acceptedOrderService->countAcceptedOrder($item['captainID']);
           
            $item['rating'] = $this->ratingService->getRatingByCaptainID($item['captainID']);
            
            $response[]  = $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $item);
            }
        return $response;
    }

    public function captainIsActive($captainID)
    {
        // $item = $this->userManager->captainIsActive($captainID);
        // if ($item) {
        //   return  $item[0]['status'];
        // }
        // return $item ;

        $item = $this->userManager->captainIsActive($captainID);
        $response = $this->autoMapping->map('array',CaptainIsActiveResponse::class, $item);
        return $response ;
     }

     public function dashboardCaptains()
     {
         $response = [];

         $response[] = $this->userManager->countpendingCaptains();
         $response[] = $this->userManager->countOngoingCaptains();
         $response[] = $this->userManager->countDayOfCaptains();

         $top5Captains = $this->acceptedOrderService->getTop5Captains();
      
         foreach ($top5Captains as $item) {
           
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['baseURL'] = $this->params;   

            $response[]  = $this->autoMapping->map('array',CaptainProfileCreateResponse::class,  $item);
         }         
         return $response;
     }

     public function getDayOfCaptains()
     {
         $response = [];

         $dayOfCaptains = $this->userManager->getDayOfCaptains();
      
         foreach ($dayOfCaptains as $item) {
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['drivingLicenceURL'] = $item['drivingLicence'];
            $item['drivingLicence'] = $this->params.$item['drivingLicence'];
            $item['mechanicLicense'] = $item['mechanicLicense'];
            $item['mechanicLicense'] = $this->params.$item['mechanicLicense'];
            $item['identity'] = $item['identity'];
            $item['identity'] = $this->params.$item['identity'];
            $item['baseURL'] = $this->params;

            $response[]  = $this->autoMapping->map('array',CaptainProfileCreateResponse::class,  $item);
         }         
         return $response;
     }

     public function getOrderKilometers($captainId)
     {
       $sumKilometerBonus = [];
       $orderKilometers = $this->acceptedOrderService->getOrderKilometers($captainId);
       foreach ($orderKilometers as $orderKilometer) {
        if ($orderKilometer['orderKilometers'] >= $orderKilometer['kilometers']) {
            $Kilometer = $orderKilometer['orderKilometers'] - $orderKilometer['kilometers'];
            $kilometerBonus1 = $Kilometer * $orderKilometer['maxKilometerBonus'];
            $sumKilometerBonus[] = $kilometerBonus1; 
        }

        if ($orderKilometer['orderKilometers'] < $orderKilometer['kilometers']) {
            $Kilometer = $orderKilometer['orderKilometers'];
            $kilometerBonus2 = $Kilometer * $orderKilometer['minKilometerBonus'];
            $sumKilometerBonus[] = $kilometerBonus2; 

        }
       }
        return array_sum($sumKilometerBonus);
     }

     public function getOrderKilometersInThisMonth($captainId, $fromDate, $toDate)
     {
       $sumKilometerBonus = [];
       $orderKilometers = $this->acceptedOrderService->getOrderKilometersInThisMonth($captainId, $fromDate, $toDate);

       foreach ($orderKilometers as $orderKilometer) {
        if ($orderKilometer['orderKilometers'] >= $orderKilometer['kilometers']) {
            $Kilometer = $orderKilometer['orderKilometers'] - $orderKilometer['kilometers'];
            $kilometerBonus1 = $Kilometer * $orderKilometer['maxKilometerBonus'];
            $sumKilometerBonus[] = $kilometerBonus1; 
        }

        if ($orderKilometer['orderKilometers'] < $orderKilometer['kilometers']) {
            $Kilometer = $orderKilometer['orderKilometers'];
            $kilometerBonus2 = $Kilometer * $orderKilometer['minKilometerBonus'];
            $sumKilometerBonus[] = $kilometerBonus2; 

        }
       }
        return array_sum($sumKilometerBonus);
     }

     public function totalBounceCaptain($captainProfileId,  $user='null', $captainId='null')
    {
        $response = [];

        $item = $this->userManager->totalBounceCaptain($captainProfileId);
      
        if ($user == "captain") { 
            $sumAmount = $this->paymentCaptainService->getSumAmount($captainId);
            $payments = $this->paymentCaptainService->getpayments($captainId);
            $bank = $this->bankService->getAccount($captainId);
            $sumKilometerBonus = $this->getOrderKilometers($captainId);
          
        }
        if ($user == "admin") { 
            $sumAmount = $this->paymentCaptainService->getSumAmount($item[0]['captainID']);
            $payments = $this->paymentCaptainService->getpayments($item[0]['captainID']);
            $bank = $this->bankService->getAccount($item[0]['captainID']);
            $sumKilometerBonus = $this->getOrderKilometers($item[0]['captainID']);
            
        }

        if ($item) {
             $item['kilometerBonus'] = $sumKilometerBonus;
             $countAcceptedOrder = $this->acceptedOrderService->countAcceptedOrder($item[0]['captainID']);
             $item['bounce'] = $item[0]['bounce'] * $countAcceptedOrder[0]['countOrdersDeliverd'];
             $item['countOrdersDeliverd'] = $countAcceptedOrder[0]['countOrdersDeliverd'];
             $item['sumPayments'] = $sumAmount[0]['sumPayments'];
             $item['NetProfit'] = $item['bounce'] + $item[0]['salary'] + $item['kilometerBonus'];
             $item['total'] = $item['sumPayments'] - ($item['bounce'] + $item[0]['salary'] + $item['kilometerBonus']);
             $item['payments'] = $payments;
             $item['bank'] = $bank;
            if ($user == "captain") {
                 $item['total'] = ($item['bounce'] + $item[0]['salary'] + $item['kilometerBonus']) - $item['sumPayments'];
            }
             $response = $this->autoMapping->map('array', CaptainTotalBounceResponse::class,  $item);
            
        }

        return $response;
    }
    
     public function totalBounceCaptainInThisMonth($captainProfileId,  $user='null', $captainId='null')
    {
        $response = [];
        $dateNow =new DateTime("now");
        $year = $dateNow->format("Y");
        $month = $dateNow->format("m");
        $date = $this->returnDate($year, $month);
       
        $item = $this->userManager->totalBounceCaptain($captainProfileId);
       
        if ($user == "captain") { 
            $sumAmount = $this->paymentCaptainService->getSumAmountInThisMonth($captainId, $date[0], $date[1]);
            if( $sumAmount[0]['sumPayments'] == null){$sumAmount[0]['sumPayments'] = 0;}
            $payments = $this->paymentCaptainService->getpaymentsInThisMonth($captainId, $date[0], $date[1]);
            // $bank = $this->bankService->getAccount($captainId);
            $sumKilometerBonus = $this->getOrderKilometersInThisMonth($captainId, $date[0], $date[1]);
          
        }
        if ($user == "admin") { 
           
            $sumAmount = $this->paymentCaptainService->getSumAmountInThisMonth($item[0]['captainID'], $date[0], $date[1]);
            if( $sumAmount[0]['sumPayments'] == null){$sumAmount[0]['sumPayments'] = 0;}
            $payments = $this->paymentCaptainService->getpaymentsInThisMonth($item[0]['captainID'], $date[0], $date[1]);
            // $bank = $this->bankService->getAccount($item[0]['captainID']);
            $sumKilometerBonus = $this->getOrderKilometersInThisMonth($item[0]['captainID'], $date[0], $date[1]);
            
        }

        if ($item) {
             $item['kilometerBonusInThisMonth'] = $sumKilometerBonus;
             $countAcceptedOrder = $this->acceptedOrderService->countAcceptedOrderInThisMonth($item[0]['captainID'], $date[0], $date[1]);
             
             $item['bounceInThisMonth'] = $item[0]['bounce'] * $countAcceptedOrder[0]['countOrdersDeliverd'];
             $item['countOrdersDeliverdInThisMonth'] = $countAcceptedOrder[0]['countOrdersDeliverd'];
             $item['sumPaymentsInThisMonth'] = (int)$sumAmount[0]['sumPayments'];
             $item['NetProfitInThisMonth'] = $item['bounceInThisMonth'] + $item[0]['salary'] + $item['kilometerBonusInThisMonth'];
             $item['totalInThisMonth'] = $item['sumPaymentsInThisMonth'] - ($item['bounceInThisMonth'] + $item[0]['salary'] + $item['kilometerBonusInThisMonth']);
             $item['paymentsInThisMonth'] = $payments;
            //  $item['bank'] = $bank;
            if ($user == "captain") {
                 $item['totalInThisMonth'] = ($item['bounceInThisMonth'] + $item[0]['salary'] + $item['kilometerBonusInThisMonth']) - $item['sumPaymentsInThisMonth'];
            }
             $response = $this->autoMapping->map('array', CaptainTotalBounceInThisMonthResponse::class,  $item);
            
        }

        return $response;
    }

    public function returnDate($year, $month)
    {
        $fromDate =new \DateTime($year . '-' . $month . '-01'); 
        $toDate = new \DateTime($fromDate->format('Y-m-d') . ' -1 month');
     //    if you want get top captains in this month must change (-1 month) to (+1 month) in back line
     //    return [$fromDate,  $toDate];
 
     //    if you want get top captains in last month must change (+1 month) to (-1 month) in back line
        return [$toDate,  $fromDate];
     }

    public function getUsers($userType)
    {
        $respons = [];
        if ($userType == "owner") {
            $items = $this->userManager->getOwners();

            foreach ($items as $item) {
                $respons[] = $this->autoMapping->map('array', AllUsersResponse::class, $item);
            }
        }
        if ($userType == "captain") {
            $items = $this->userManager->getCaptains($userType);

            foreach ($items as $item) {
                $item['imageURL'] = $item['image'];
                $item['image'] = $this->params.$item['image'];
                $item['drivingLicenceURL'] = $item['drivingLicence'];
                $item['drivingLicence'] = $this->params.$item['drivingLicence'];
                $item['mechanicLicense'] = $item['mechanicLicense'];
                $item['mechanicLicense'] = $this->params.$item['mechanicLicense'];
                $item['identity'] = $item['identity'];
                $item['identity'] = $this->params.$item['identity'];
                $item['baseURL'] = $this->params;
                $respons[] = $this->autoMapping->map('array', AllUsersResponse::class, $item);
            }
        }
        return $respons;
    }

    public function getAllUsers($userType)
    {
        $response = [];
        if ($userType == "owner") {
            $owners = $this->userManager->getAllOwners();
            
            foreach ($owners as $owner) {
                $response[] = $this->autoMapping->map('array', UserProfileCreateResponse::class, $owner);
            }
        }

        if ($userType == "captain") {
            $captains = $this->userManager->getAllCaptains();
           
            foreach ($captains as $captain) {
                $captain['imageURL'] = $captain['image'];
                $captain['image'] = $this->params.$captain['image'];
                $captain['drivingLicenceURL'] = $captain['drivingLicence'];
                $captain['drivingLicence'] = $this->params.$captain['drivingLicence'];
                $captain['mechanicLicense'] = $captain['mechanicLicense'];
                $captain['mechanicLicense'] = $this->params.$captain['mechanicLicense'];
                $captain['identity'] = $captain['identity'];
                $captain['identity'] = $this->params.$captain['identity'];
                $captain['baseURL'] = $this->params;

            $response[]  = $this->autoMapping->map('array',CaptainProfileCreateResponse::class,  $captain);
            } 
        }        
        return $response;
    }

    public function specialLinkCheck($bool)
    {
        if (!$bool)
        {
            return $this->params;
        }
    }

    public function getCaptainMybalance($captainID)
    {
        $response = "";
        $item = $this->userManager->getcaptainprofileByCaptainID($captainID);
        if($item) {
            $response = $this->totalBounceCaptain($item['id'], 'captain', $captainID);
        }
        return $response;
    }

    public function getCaptainMybalanceInThisMonth($captainID)
    {
        $response = "";
        $item = $this->userManager->getcaptainprofileByCaptainID($captainID);
        if($item) {
            $response = $this->totalBounceCaptainInThisMonth($item['id'], 'captain', $captainID);
        }
        return $response;
    }

    public function remainingcaptain()
    {
        $response = [];
        $result = [];
        $captains = $this->userManager->getAllCaptains();
         
        foreach ($captains as $captain) {
                
                $item = $this->userManager->getCaptainprofileByID($captain['id']);
       
                 $totalBounce = $this->totalBounceCaptain($item['id'],'admin');
                 $total=(array)$totalBounce;
                 $captain['totalBounce'] = $total;
        
                if ($captain['totalBounce']['total'] < 0 ){
                
                $response[] =  $this->autoMapping->map('array', CaptainProfileCreateResponse::class, $captain);
            }
        } 
        $result['response']=$response;
        return $result;
    }

    public function update($request, $NewMessageStatus)
    {
        $item = $this->userManager->getcaptainByUuid($request->getRoomID());
   
       $response = $this->userManager->update($item, $NewMessageStatus);
    
       return  $this->autoMapping->map(CaptainProfileEntity::class, CaptainProfileCreateResponse::class, $response);
      
    }

    public function updateNewMessageStatusInUserProfile($request, $NewMessageStatus)
    {
        $item = $this->userManager->getOwnerByUuid($request->getRoomID());
   
       $response = $this->userManager->updateNewMessageStatusInUserProfile($item, $NewMessageStatus);
    
        return  $this->autoMapping->map(UserProfileEntity::class, UserProfileResponse::class, $response);
      
    }
}
