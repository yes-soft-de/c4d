<?php

namespace App\Repository;

use App\Entity\PaymentsCaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method PaymentsCaptainEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method PaymentsCaptainEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method PaymentsCaptainEntity[]    findAll()
 * @method PaymentsCaptainEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PaymentsCaptainEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PaymentsCaptainEntity::class);
    }

    // /**
    //  * @return PaymentsCaptainEntity[] Returns an array of PaymentsCaptainEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('p.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?PaymentsCaptainEntity
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
