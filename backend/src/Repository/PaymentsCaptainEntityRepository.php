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

    public function  getpayments($captainId)
    {
        return $this->createQueryBuilder('PaymentsCaptain')
               ->select('PaymentsCaptain.id, PaymentsCaptain.captainId, PaymentsCaptain.amount, PaymentsCaptain.date')

               ->andWhere('PaymentsCaptain.captainId = :captainId')

               ->setParameter('captainId', $captainId)

               ->getQuery()
               ->getResult();
    }
    
    public function getSumAmount($captainId)
    {
        return $this->createQueryBuilder('PaymentsCaptain')
               ->select('sum(PaymentsCaptain.amount) as sumPayments')
               ->andWhere('PaymentsCaptain.captainId = :captainId')

               ->setParameter('captainId', $captainId)

               ->getQuery()
               ->getResult();
    }
}
