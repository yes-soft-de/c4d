<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\RatingEntity;
use App\Repository\RatingEntityRepository;
use App\Request\RatingCreateRequest;
// use App\Request\RatingUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RatingManager
{
    private $autoMapping;
    private $entityManager;
    private $ratingRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RatingEntityRepository $ratingRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->ratingRepository = $ratingRepository;
    }

    public function create(RatingCreateRequest $request)
    {
        $entity = $this->autoMapping->map(RatingCreateRequest::class, RatingEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getRatingByCaptainID($captainID)
    {
        return $this->ratingRepository->getRatingByCaptainID($captainID);
    }

    public function ratingByCaptainID($captainID)
    {
        return $this->ratingRepository->ratingByCaptainID($captainID);
    }
}
