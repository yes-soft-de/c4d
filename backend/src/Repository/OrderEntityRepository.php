<?php

namespace App\Repository;

use App\Entity\OrderEntity;
use App\Entity\AcceptedOrderEntity;
use App\Entity\CaptainProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method OrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderEntity[]    findAll()
 * @method OrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderEntity::class);
    }

    public function getOrderById($orderId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addselect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate','OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state')
            ->andWhere('OrderEntity.id = :id')
            ->setParameter('id', $orderId)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOrdersByOwnerID($userID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addselect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state')

            ->andWhere('OrderEntity.ownerID = :userID')

            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }

    public function orderStatus($userID, $orderId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addselect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state')

            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.orderID = OrderEntity.id')

            ->andWhere('OrderEntity.ownerID = :userID')
            ->andWhere('OrderEntity.id = :ID')
            ->setParameter('userID', $userID)
            ->setParameter('ID', $orderId)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function closestOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch')

            ->andWhere("OrderEntity.state = 'pending' ")

            ->getQuery()
            ->getResult();
    }

    public function getPendingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch')

            ->andWhere("OrderEntity.state = 'pending' ")

            ->getQuery()
            ->getResult();
    }
    public function countAllOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as ordersCount') 
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countpendingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as countpendingOrders')

            ->andWhere("OrderEntity.state = 'pending' ")

            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function countOngoingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as countOngoingOrders')

            ->andWhere("OrderEntity.state = 'ongoing' ") 

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countCancelledOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as countCancelledOrders') 

            ->andWhere("OrderEntity.state = 'cancelled' ") 
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function ongoingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addSelect('OrderEntity.id as orderID', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date as orderDate', 'OrderEntity.updateDate as updateOrderDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'captainProfileEntity.name', 'acceptedOrderEntity.date as acceptedOrderDate', 'acceptedOrderEntity.captainID', 'acceptedOrderEntity.duration', 'captainProfileEntity.car', 'captainProfileEntity.drivingLicence', 'captainProfileEntity.image') 
            
            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.orderID = OrderEntity.id')

            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'acceptedOrderEntity.captainID = captainProfileEntity.captainID')

            ->andWhere("OrderEntity.state = 'ongoing' ") 
            ->getQuery()
            ->getResult();
    }
}
