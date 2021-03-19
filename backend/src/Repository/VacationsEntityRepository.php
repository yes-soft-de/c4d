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

    // /**
    //  * @return VacationsEntity[] Returns an array of VacationsEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('v')
            ->andWhere('v.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('v.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?VacationsEntity
    {
        return $this->createQueryBuilder('v')
            ->andWhere('v.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
