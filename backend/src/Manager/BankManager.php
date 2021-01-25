<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\BankEntity;
use App\Repository\BankEntityRepository;
use App\Request\BankCreateRequest;
use App\Request\BankUpdateRequest;
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
