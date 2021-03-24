<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\VacationsEntity;
use App\Manager\VacationsManager;
use App\Request\VacationsCreateRequest;
use App\Response\VacationsResponse;
use App\Service\UserService;

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
}
