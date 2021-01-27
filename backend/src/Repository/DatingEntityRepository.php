<?php

namespace App\Repository;

use App\Entity\DatingEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DatingEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DatingEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DatingEntity[]    findAll()
 * @method DatingEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DatingEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DatingEntity::class);
    }

    // /**
    //  * @return DatingEntity[] Returns an array of DatingEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('d.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?DatingEntity
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
