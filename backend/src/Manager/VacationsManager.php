<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\VacationsEntity;
use App\Repository\VacationsEntityRepository;
use App\Request\VacationsCreateRequest;
use App\Request\VacationsUpdateStateRequest;
use Doctrine\ORM\EntityManagerInterface;

class VacationsManager
{
    private $autoMapping;
    private $entityManager;
    private $vacationsRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, VacationsEntityRepository $vacationsRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->vacationsRepository = $vacationsRepository;
    }

    public function create(VacationsCreateRequest $request)
    {
        $entity = $this->autoMapping->map(VacationsCreateRequest::class, VacationsEntity::class, $request);

        $entity->setStartDate($request->getStartDate());
        $entity->setEndDate($request->getEndDate());

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getHistoryVacationsForCaptain($captainID) {
        return $this->vacationsRepository->getHistoryVacationsForCaptain($captainID);
    }

    public function getLastVacationForCaptains($captainId) {
        return $this->vacationsRepository->getLastVacationForCaptains($captainId);
        
    }

}
