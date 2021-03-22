<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\BankEntity;
use App\Repository\BankEntityRepository;
use App\Request\BankCreateRequest;
use App\Request\BankUpdateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\CaptainProfileCreateRequest;
use App\Request\CaptainProfileUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class BankManager
{
    private $autoMapping;
    private $entityManager;
    private $bankEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, BankEntityRepository $bankEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->bankEntityRepository = $bankEntityRepository;
    }

    public function create(BankCreateRequest $request)
    {
        $entity = $this->autoMapping->map(BankCreateRequest::class, BankEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function createFromCaptain(CaptainProfileCreateRequest $request)
    {
       
        $entity = $this->autoMapping->map(CaptainProfileCreateRequest::class, BankEntity::class, $request);
        $entity->setUserID($request->getCaptainID());

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function updateFromCreateCaptain(CaptainProfileUpdateRequest $request)
    {
       
        $entity = $this->autoMapping->map(CaptainProfileUpdateRequest::class, BankEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function update(BankUpdateRequest $request)
    {
        $entity = $this->bankEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(BankUpdateRequest::class, BankEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    } 

    public function updateFromProfile(UserProfileUpdateRequest $request)
    {
        $entity = $this->bankEntityRepository->getByUserId($request->getUserID());
        if (!$entity) {
            return null;
        }
                
        $entity = $this->autoMapping->mapToObject(UserProfileUpdateRequest::class, BankEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }  
    
    public function updateFromCaptain(CaptainProfileUpdateRequest $request)
    {
        $entity = $this->bankEntityRepository->getByUserId($request->getUserID());
        if (!$entity) {
            return null;
        }
                
        $entity = $this->autoMapping->mapToObject(CaptainProfileUpdateRequest::class, BankEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }  
    
    public function getAccountByUserId($userId)
    {
        return $this->bankEntityRepository->getAccountByUserId($userId);
    }

    public function getAccount($userID)
    {
        return $this->bankEntityRepository->getAccount($userID);
    }

    public function getAccounts()
    {
        return $this->bankEntityRepository->getAccounts();
    }
}
