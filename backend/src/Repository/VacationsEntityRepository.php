<?php

namespace App\Repository;

use App\Entity\VacationsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method VacationsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method VacationsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method VacationsEntity[]    findAll()
 * @method VacationsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class VacationsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, VacationsEntity::class);
    }

    public function getHistoryVacationsForCaptain($captainId)
    {
        return $this->createQueryBuilder('vacations') 
        ->select('vacations.id, vacations.startDate , vacations.endDate')
            ->andWhere('vacations.captainId = :captainId')   
            ->andWhere("vacations.state = 'vacation'")   
            ->setParameter('captainId',$captainId)        
            ->getQuery()
            ->getResult();
    }

    public function getLastVacationForCaptains($captainId)
    {
        return $this->createQueryBuilder('vacations') 
        ->select('vacations.id, vacations.endDate')  
            ->andWhere('vacations.captainId = :captainId') 
            ->andWhere("vacations.state = 'vacation'")  
            ->addOrderBy('vacations.id','DESC') 
            ->setMaxResults(1)
            ->groupBy('vacations.id')
            ->setParameter('captainId',$captainId)       
            ->getQuery()
            ->getResult();
    }
}
