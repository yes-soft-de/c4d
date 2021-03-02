<?php

namespace App\Repository;

use App\Entity\PaymentsEntity;
use App\Entity\BankEntity;
use App\Entity\SubscriptionEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method PaymentsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method PaymentsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method PaymentsEntity[]    findAll()
 * @method PaymentsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PaymentsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PaymentsEntity::class);
    }

    public function getpaymentsForOwner($ownerId)
    {
        return $this->createQueryBuilder('Payments')
               ->select('Payments.id, Payments.amount, Payments.date')

               ->andWhere('Payments.ownerId = :ownerId')

               ->setParameter('ownerId', $ownerId)

               ->getQuery()
               ->getResult();
    }
    
    public function getSumAmount($ownerId)
    {
        return $this->createQueryBuilder('Payments')
               ->select('sum(Payments.amount) as sumPayments')
               ->andWhere('Payments.ownerId = :ownerId')

               ->setParameter('ownerId', $ownerId)

               ->getQuery()
               ->getResult();
    }

    public function getNewAmount($ownerId)
    {
        return $this->createQueryBuilder('Payments')
               ->select('Payments.id, Payments.date')
               ->andWhere('Payments.ownerId = :ownerId')

               ->addGroupBy('Payments.id')
               ->setMaxResults(1)
               ->addOrderBy('Payments.id','DESC')

               ->setParameter('ownerId', $ownerId)

               ->getQuery()
               ->getResult();
    }
}
