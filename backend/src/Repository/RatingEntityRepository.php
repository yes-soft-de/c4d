<?php

namespace App\Repository;

use App\Entity\RatingEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RatingEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RatingEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RatingEntity[]    findAll()
 * @method RatingEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RatingEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RatingEntity::class);
    }

    public function getRatingByCaptainID($captainID)
    {
        return $this->createQueryBuilder('Rating')
               ->select('AVG(Rating.type) as rate ')
              
               ->andWhere('Rating.captainID = :captainID')

               ->setParameter('captainID', $captainID)

               ->getQuery()
               ->getOneOrNullResult();
    }
    public function ratingByCaptainID($captainID)
    {
        return $this->createQueryBuilder('Rating')
               ->select('AVG(Rating.type) as rate ')
              
               ->andWhere('Rating.captainID = :captainID')

               ->setParameter('captainID', $captainID)

               ->getQuery()
               ->getResult();
    }
}
