<?php

namespace App\Repository;

use App\Entity\SubscribeRecordEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SubscribeRecordEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SubscribeRecordEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SubscribeRecordEntity[]    findAll()
 * @method SubscribeRecordEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SubscribeRecordEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SubscribeRecordEntity::class);
    }

    // /**
    //  * @return SubscribeRecordEntity[] Returns an array of SubscribeRecordEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('s.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?SubscribeRecordEntity
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
