<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\VacationsEntity;
use App\Manager\VacationsManager;
use App\Request\VacationsCreateRequest;
use App\Response\VacationsResponse;
use App\Service\UserService;
use DateTime;

class VacationsService
{
    private $autoMapping;
    private $vacationsManager;
    private $userService;

    public function __construct(AutoMapping $autoMapping, VacationsManager $vacationsManager, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->userService = $userService;
        $this->vacationsManager = $vacationsManager;
    }

    public function create(VacationsCreateRequest $request)
    {
        $result = $this->vacationsManager->create($request);
        if ($result) {
           $this->userService->captainvacationbyadmin($request); 
        }
        $respnose = $this->autoMapping->map(VacationsEntity::class, VacationsResponse::class, $result);
        
        return $respnose;
    }

    public function getHistoryVacationsForCaptain($captainID) {
        return $this->vacationsManager->getHistoryVacationsForCaptain($captainID);
    }

    public function getDayOfCaptains()
    {   //Brings the captains who are on vacation, then tests if vacation time has expired, updates the vacation state
        $now = new DateTime('now');
        $d =$now->format('y-m-d');
        $request = new VacationsCreateRequest();
        $request->setState('work');
        $request->setStartDate($d );
        $request->setEndDate($d );        

        $captains = $this->userService->getDayOfCaptains();
      
   
        foreach ($captains as $captain) {

            $request->setCaptainId($captain->captainID);

            $items = $this->vacationsManager->getLastVacationForCaptains($captain->captainID);
            foreach ($items as $item) {

                if ($item['endDate'] < $now){
                    $this->create($request);
                }
            }
        }
        //return for next line only
        return $this->userService->getDayOfCaptains(); 
    }
  
}
