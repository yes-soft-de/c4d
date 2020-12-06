<?php

namespace App\Repository;

use App\Entity\AcceptedOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\CaptainProfileEntity;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method AcceptedOrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AcceptedOrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AcceptedOrderEntity[]    findAll()
 * @method AcceptedOrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AcceptedOrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AcceptedOrderEntity::class);
    }

    public function acceptedOrder($userID, $acceptedOrderId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->addSelect('AcceptedOrderEntity.id', 'AcceptedOrderEntity.orderID', 'AcceptedOrderEntity.date', 'AcceptedOrderEntity.cost', 'AcceptedOrderEntity.state')
            ->andWhere('AcceptedOrderEntity.captainID = :userID')
            ->andWhere('AcceptedOrderEntity.id = :ID')
            ->setParameter('userID', $userID)
            ->setParameter('ID', $acceptedOrderId)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function closestOrders()
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select('AcceptedOrderEntity.orderID as id ')
            ->getQuery()
            ->getResult();
    }

    public function totalEarn($userID)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select("sum(AcceptedOrderEntity.cost) as CaptaintotalEarn ")
            ->andWhere("AcceptedOrderEntity.state = 'deliverd'")
            ->andWhere('AcceptedOrderEntity.captainID = :userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countOrdersDeliverd($userID)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select("count(AcceptedOrderEntity.id) as countOrdersDeliverd ")
            ->andWhere("AcceptedOrderEntity.state = 'deliverd'")
            ->andWhere('AcceptedOrderEntity.captainID = :userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAcceptedOrderByOrderId($orderId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select('AcceptedOrderEntity.id', 'AcceptedOrderEntity.date as acceptedOrderDate', 'AcceptedOrderEntity.cost', 'AcceptedOrderEntity.captainID', 'AcceptedOrderEntity.duration')
            ->andWhere('AcceptedOrderEntity.orderID = :orderId')
            ->setParameter('orderId', $orderId)
            ->getQuery()
            ->getResult();
    }
}
