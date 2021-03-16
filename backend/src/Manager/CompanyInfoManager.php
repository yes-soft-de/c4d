<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\CompanyInfoEntity;
use App\Repository\CompanyInfoEntityRepository;
use App\Request\companyInfoCreateRequest;
use App\Request\companyInfoUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CompanyInfoManager
{
    private $autoMapping;
    private $entityManager;
    private $companyInfoEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CompanyInfoEntityRepository $companyInfoEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->companyInfoEntityRepository = $companyInfoEntityRepository;
    }

    public function create(companyInfoCreateRequest $request)
    {
        $entity = $this->autoMapping->map(companyInfoCreateRequest::class, CompanyInfoEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function update(companyInfoUpdateRequest $request)
    {
        $entity = $this->companyInfoEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(companyInfoUpdateRequest::class, CompanyInfoEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    } 

    public function getcompanyinfoById($id)
    {
        return $this->companyInfoEntityRepository->getcompanyinfoById($id);
    }

    public function getcompanyinfoAll()
    {
       return $this->companyInfoEntityRepository->getcompanyinfoAll();
    }

}
