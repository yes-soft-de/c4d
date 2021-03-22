<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\BankEntity;
use App\Manager\BankManager;
use App\Request\BankCreateRequest;
use App\Response\BankResponse;

class BankService
{
    private $autoMapping;
    private $bankManager;

    public function __construct(AutoMapping $autoMapping, BankManager $bankManager)
    {
        $this->autoMapping = $autoMapping;
        $this->bankManager = $bankManager;
    }

    public function create(BankCreateRequest $request)
    {
        $item = $this->bankManager->create($request);

        return $this->autoMapping->map(BankEntity::class, BankResponse::class, $item);
    }

    public function createFromCaptain($request)
    {
        $item = $this->bankManager->createFromCaptain($request);

        return $this->autoMapping->map(BankEntity::class, BankResponse::class, $item);
    }

    public function updateFromCreateCaptain($request)
    {
        $item = $this->bankManager->updateFromCreateCaptain($request);

        return $this->autoMapping->map(BankEntity::class, BankResponse::class, $item);
    }

    public function update($request)
    {
        $result = $this->bankManager->update($request);

        return $this->autoMapping->map(BankEntity::class, BankResponse::class, $result);
    }

    public function updateFromProfile($request)
    {
        $result = $this->bankManager->updateFromProfile($request);

        return $this->autoMapping->map(BankEntity::class, BankResponse::class, $result);
    }

    public function updateFromCaptain($request)
    {
        $result = $this->bankManager->updateFromCaptain($request);

        return $this->autoMapping->map(BankEntity::class, BankResponse::class, $result);
    }

    public function getAccountByUserId($userId)
    {
        $item = $this->bankManager->getAccountByUserId($userId);
      
        return $this->autoMapping->map('array', BankResponse::class, $item);
    }

    public function getAccount($userID)
    {
        $item = $this->bankManager->getAccount($userID);
     
        return $this->autoMapping->map('array', BankResponse::class, $item);
    }

    // public function getAccount($userID)
    // {
    //     $item = $this->bankManager->getAccount($userID);
     
    //     return $this->autoMapping->map('array', BankResponse::class, $item);
    // }

    public function getAccounts()
    {
        $items = $this->bankManager->getAccounts();
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', BankResponse::class, $item);
        }
        return $response;
    }
}
