<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RatingEntity;
use App\Manager\RatingManager;
use App\Request\RatingCreateRequest;
use App\Response\RatingResponse;

class RatingService
{
    private $autoMapping;
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->ratingManager = $ratingManager;
    }

    public function create(RatingCreateRequest $request)
    {
        $rating = $this->ratingManager->create($request);

        return $this->autoMapping->map(RatingEntity::class, RatingResponse::class, $rating);
    }

    public function getRatingByCaptainID($captainID)
    {
        return $this->ratingManager->getRatingByCaptainID($captainID);
     }

    public function ratingByCaptainID($captainID)
    {
        return $this->ratingManager->ratingByCaptainID($captainID);
     }
}
