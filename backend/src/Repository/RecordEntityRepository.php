<?php

namespace App\Repository;

use App\Entity\RecordEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RecordEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RecordEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RecordEntity[]    findAll()
 * @method RecordEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RecordEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RecordEntity::class);
    }

    // /**
    //  * @return RecordEntity[] Returns an array of RecordEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('r.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?RecordEntity
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
