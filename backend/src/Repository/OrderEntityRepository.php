<?php

namespace App\Repository;

use App\Entity\OrderEntity;
use App\Entity\AcceptedOrderEntity;
use App\Entity\CaptainProfileEntity;
use App\Entity\UserProfileEntity;
use App\Entity\BranchesEntity;
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
            ->addSelect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate','OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch', 'OrderEntity.uuid')
            ->andWhere('OrderEntity.id = :id')
            ->setParameter('id', $orderId)
            ->getQuery()
            // ->getResult();
            ->getOneOrNullResult();
    }

    public function orderById($orderId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addSelect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate','OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch', 'OrderEntity.uuid')
            ->andWhere('OrderEntity.id = :id')
            ->setParameter('id', $orderId)
            ->getQuery()
            ->getResult();
    }

    public function getOrdersByOwnerID($userID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addselect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch')

            ->andWhere('OrderEntity.ownerID = :userID')

            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }

    public function orderStatus($orderId)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addselect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch', 'OrderEntity.uuid')

            // ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.orderID = OrderEntity.id')

            // ->andWhere('OrderEntity.ownerID = :userID')
            ->andWhere('OrderEntity.id = :ID')
            // ->setParameter('userID', $userID)
            ->setParameter('ID', $orderId)
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    //for delete
    // public function orderStatusForCaptain($userID, $orderId)
    // {
    //     return $this->createQueryBuilder('OrderEntity')
    //         ->addselect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch')

    //         ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.orderID = OrderEntity.id')

    //         // ->join(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.captainID = acceptedOrderEntity.captainID')

    //         // ->andWhere('acceptedOrderEntity.captainID = :userID')
    //         // ->andWhere('acceptedOrderEntity.orderID = :ID')
    //         ->andWhere('OrderEntity.id = :ID')
    //         // ->setParameter('userID', $userID)
    //         ->setParameter('ID', $orderId)
    //         ->getQuery()
    //         ->getOneOrNullResult();
    // }

    public function closestOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch', 'OrderEntity.uuid')
          
            ->andWhere("OrderEntity.state = 'pending' ")

            ->getQuery()
            ->getResult();
    }

    public function getPendingOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch')

            ->andWhere("OrderEntity.state = 'pending'")

            ->getQuery()
            ->getResult();
    }
    public function countAllOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('count(OrderEntity.id) as ordersCount') 
           
            ->andWhere("OrderEntity.state = 'pending' or OrderEntity.state = 'ongoing' or OrderEntity.state = 'picked'")
           
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
            ->addSelect('OrderEntity.id as orderID', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date as orderDate', 'OrderEntity.updateDate as updateOrderDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'captainProfileEntity.name', 'acceptedOrderEntity.date as acceptedOrderDate', 'acceptedOrderEntity.captainID', 'acceptedOrderEntity.duration', 'captainProfileEntity.car', 'captainProfileEntity.drivingLicence', 'captainProfileEntity.image', 'userProfileEntity.userName as ownerName', 'OrderEntity.fromBranch','captainProfileEntity.specialLink') 
            
            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.orderID = OrderEntity.id')

            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'acceptedOrderEntity.captainID = captainProfileEntity.captainID')

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = OrderEntity.ownerID')

            ->andWhere("OrderEntity.state = 'ongoing' ") 
            ->getQuery()
            ->getResult();
    }

    public function getRecords($ownerID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->addSelect('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date as orderDate', 'OrderEntity.updateDate as updateOrderDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch','branchesEntity.location','branchesEntity.brancheName','branchesEntity.city as branchCity') 

            ->leftJoin(BranchesEntity::class, 'branchesEntity', Join::WITH, 'branchesEntity.id = OrderEntity.fromBranch')

            ->andWhere("OrderEntity.ownerID = :ownerID ")
            ->setParameter('ownerID', $ownerID) 
            ->getQuery()
            ->getResult();
    }

    public function getRecordsForCaptain($CaptainId)
    {
        return $this->createQueryBuilder('OrderEntity')
        
            ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date as orderDate', 'OrderEntity.updateDate as updateOrderDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch','branchesEntity.location','branchesEntity.brancheName','branchesEntity.city as branchCity') 

            ->leftJoin(BranchesEntity::class, 'branchesEntity', Join::WITH, 'branchesEntity.id = OrderEntity.fromBranch')

            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.orderID = OrderEntity.id')

            ->andWhere("acceptedOrderEntity.captainID = :CaptainId ")
            ->setParameter('CaptainId', $CaptainId)  
            ->getQuery()
            ->getResult();
    }

     public function getOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
            ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.updateDate', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch', 'userProfileEntity.userName as userName', 'OrderEntity.kilometer')
            
            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = OrderEntity.ownerID')

            ->getQuery()
            ->getResult();
    }

    public function countOrdersInMonthForOwner($fromDate, $toDate, $ownerId)
    {
        return $this->createQueryBuilder('OrderEntity')

            ->select('count(OrderEntity.id) as countOrdersInMonth')

            ->where('OrderEntity.date >= :fromDate')
            ->andWhere('OrderEntity.date < :toDate')
            ->andWhere('OrderEntity.ownerID = :ownerId')

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('ownerId', $ownerId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllOrders($fromDate, $toDate, $ownerId)
    {
        return $this->createQueryBuilder('OrderEntity')

          ->select('OrderEntity.id', 'OrderEntity.ownerID', 'OrderEntity.source', 'OrderEntity.destination', 'OrderEntity.date', 'OrderEntity.note', 'OrderEntity.payment', 'OrderEntity.recipientName', 'OrderEntity.recipientPhone', 'OrderEntity.state', 'OrderEntity.fromBranch', 'OrderEntity.uuid', 'userProfileEntity.userName as userName')

          ->where('OrderEntity.date >= :fromDate')
          ->andWhere('OrderEntity.date < :toDate')
          ->andWhere('OrderEntity.ownerID = :ownerId')

          ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = :ownerId')
        
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->setParameter('ownerId', $ownerId)
          ->getQuery()
          ->getResult();
       
    }

    public function getTopOwners($fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')
       // countOrdersInMonth = countOrdersForOwnerInMonth
          ->select('OrderEntity.ownerID','OrderEntity.ownerID', 'count(OrderEntity.ownerID) as countOrdersInMonth')
          ->addSelect('userProfileEntity.userName', 'userProfileEntity.image')
          ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = OrderEntity.ownerID')
        
          ->where('OrderEntity.date >= :fromDate')
          ->andWhere('OrderEntity.date < :toDate')

          ->addGroupBy('OrderEntity.ownerID')
          
          ->addGroupBy('userProfileEntity.userName')
          ->addGroupBy('userProfileEntity.image')

          ->having('count(OrderEntity.ownerID) > 0')
          ->setMaxResults(15)
          ->addOrderBy('countOrdersInMonth','DESC')
         
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          ->getQuery()
          ->getResult();
    }
    
    public function countOrdersInDay($ownerID, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('OrderEntity')

          ->select('SUBSTRING(OrderEntity.date, 1, 10) as myDate', 'OrderEntity.date', 'count(OrderEntity.id) as countOrdersInDay')
        
          ->andWhere('OrderEntity.ownerID = :ownerID') 
          ->andWhere('OrderEntity.date >= :fromDate')
          ->andWhere('OrderEntity.date < :toDate')

        //   ->groupBy('OrderEntity.date')
          ->addGroupBy('OrderEntity.ownerID')
          ->addGroupBy('myDate')
          
          ->having('count(OrderEntity.id) > 0')
       
          ->addOrderBy('countOrdersInDay','DESC')

          ->setParameter('ownerID', $ownerID)
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          
          ->getQuery()
          ->getResult();
    }
}
