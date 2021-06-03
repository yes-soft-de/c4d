<?php

namespace App\Service;

use App\AutoMapping;
use App\Manager\MainManager;
use App\Request\UserUpdateRequest;
use App\Response\UserRegisterResponse;

class MainService
{
    private $autoMapping;
    private $mainManager;

    public function __construct(AutoMapping $autoMapping, MainManager $mainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->mainManager = $mainManager;
    }

    public function update(UserUpdateRequest $request)
    {
        $user = $this->mainManager->update($request);

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $user);
    }

    public function findAll()
    {
        return $this->mainManager->findAll();
    }

}