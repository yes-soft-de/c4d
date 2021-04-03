<?php

namespace App\Repository;

use App\Entity\AcceptedOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\CaptainProfileEntity;
use App\Entity\OrderEntity;
use App\Entity\BranchesEntity;
use App\Entity\UserProfileEntity;
use App\Entity\RecordEntity;
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

    // public function getOrderStatusForCaptain($captainID, $orderId)
    // {
    //     return $this->createQueryBuilder('AcceptedOrderEntity')
    //         ->select('AcceptedOrderEntity.id','AcceptedOrderEntity.captainID', 'AcceptedOrderEntity.orderID', 'AcceptedOrderEntity.date', 'orderEntity.source', 'orderEntity.destination', 'orderEntity.date as orderDate', 'orderEntity.note as orderNote', 'orderEntity.payment ', 'orderEntity.state', 'orderEntity.updateDate as orderUpdateDate')
          
    //         ->join(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = AcceptedOrderEntity.orderID')

    //         ->andWhere('AcceptedOrderEntity.captainID = :captainID')
    //         ->andWhere('AcceptedOrderEntity.orderID = :orderId')
    //         ->setParameter('captainID', $captainID)
    //         ->setParameter('orderId', $orderId)
    //         ->getQuery()
    //         ->getOneOrNullResult();
    // }

    public function countOrdersDeliverd($captainID)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select("count(AcceptedOrderEntity.id) as countOrdersDeliverd ")
            ->andWhere("AcceptedOrderEntity.state = 'deliverd'")
            ->andWhere('AcceptedOrderEntity.captainID = :captainID')
            ->setParameter('captainID', $captainID)
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getAcceptedOrderByOrderId($orderId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select('AcceptedOrderEntity.id', 'AcceptedOrderEntity.date as acceptedOrderDate', 'AcceptedOrderEntity.captainID', 'AcceptedOrderEntity.duration', 'AcceptedOrderEntity.state', 'captainProfileEntity.name as captainName', 'captainProfileEntity.car',  'captainProfileEntity.image',  'captainProfileEntity.uuid', 'captainProfileEntity.phone', 'captainProfileEntity.drivingLicence')

            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.captainID = AcceptedOrderEntity.captainID')

            ->andWhere('AcceptedOrderEntity.orderID = :orderId')
            ->andWhere('captainProfileEntity.captainID = AcceptedOrderEntity.captainID')
            ->setParameter('orderId', $orderId)
            ->getQuery()
            ->getResult();
    }
    
    public function getAcceptedOrderByCaptainId($captainID)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select('AcceptedOrderEntity.id', 'AcceptedOrderEntity.date as acceptedOrderDate', 'AcceptedOrderEntity.captainID', 'AcceptedOrderEntity.duration', 'AcceptedOrderEntity.state',  'AcceptedOrderEntity.orderID')
            ->addSelect('captainProfileEntity.name as captainName', 'captainProfileEntity.car',  'captainProfileEntity.image')
            ->addSelect('orderEntity.id', 'orderEntity.ownerID', 'orderEntity.source', 'orderEntity.destination', 'orderEntity.date', 'orderEntity.updateDate', 'orderEntity.note', 'orderEntity.payment', 'orderEntity.recipientName', 'orderEntity.recipientPhone', 'orderEntity.state', 'orderEntity.fromBranch', 'orderEntity.uuid')
            ->addSelect('userProfileEntity.userName as ownerName')
            ->addSelect('branchesEntity.brancheName', 'branchesEntity.location as brancheLocation')

            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.captainID = AcceptedOrderEntity.captainID')
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = AcceptedOrderEntity.orderID')
            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = orderEntity.ownerID')
            ->leftJoin(BranchesEntity::class, 'branchesEntity', Join::WITH, 'branchesEntity.id = orderEntity.fromBranch')

            ->andWhere('AcceptedOrderEntity.captainID = :captainID')
            ->setParameter('captainID', $captainID)
            ->getQuery()
            ->getResult();
    }

    public function countAcceptedOrder($captainId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select('count(AcceptedOrderEntity.orderID) as countOrdersDeliverd')

            ->join(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = AcceptedOrderEntity.orderID')

            ->andWhere('AcceptedOrderEntity.orderID = orderEntity.id')
            ->andWhere('AcceptedOrderEntity.captainID = :captainId')
            ->andWhere("orderEntity.state = 'deliverd'")
            ->setParameter('captainId', $captainId)
            ->getQuery()
            ->getResult();
    }

    public function getByOrderId($orderId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')

            ->andWhere('AcceptedOrderEntity.orderID = :orderId')
            ->setParameter('orderId', $orderId)
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getTop5Captains()
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')

            ->select('AcceptedOrderEntity.captainID', 'count(AcceptedOrderEntity.captainID) countOrdersDeliverd', 'captainProfileEntity.name', 'captainProfileEntity.car', 'captainProfileEntity.age', 'captainProfileEntity.salary', 'captainProfileEntity.bounce', 'captainProfileEntity.image', 'captainProfileEntity.specialLink')
            
            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.captainID = AcceptedOrderEntity.captainID')

            // ->andWhere("AcceptedOrderEntity.state ='deliverd'")
            // ->andWhere('captainProfileEntity.captainID = AcceptedOrderEntity.captainID')
           
            ->addGroupBy('AcceptedOrderEntity.captainID')
          
            ->addGroupBy('captainProfileEntity.name')
            ->addGroupBy('captainProfileEntity.car')
            ->addGroupBy('captainProfileEntity.age')
            ->addGroupBy('captainProfileEntity.salary')
            ->addGroupBy('captainProfileEntity.bounce')
            ->addGroupBy('captainProfileEntity.image')
            ->addGroupBy('captainProfileEntity.specialLink')
            
            ->having('count(AcceptedOrderEntity.captainID) > 0')
            ->setMaxResults(5)
            ->addOrderBy('countOrdersDeliverd','DESC')
            ->getQuery()
            ->getResult();
    }

    public function countOrdersInMonthForCaptin($fromDate, $toDate, $captainId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')

            ->select('count(AcceptedOrderEntity.id) as countOrdersInMonth')
       

            ->where('AcceptedOrderEntity.date >= :fromDate')
            ->andWhere('AcceptedOrderEntity.date < :toDate')
            ->andWhere('AcceptedOrderEntity.captainID = :captainId')

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('captainId', $captainId)
            ->getQuery()
            ->getResult();
    }

    public function getAcceptedOrderByCaptainIdInMonth($fromDate, $toDate, $captainId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')

            ->select('AcceptedOrderEntity.orderID')

            ->where('AcceptedOrderEntity.date >= :fromDate')
            ->andWhere('AcceptedOrderEntity.date < :toDate')
            ->andWhere('AcceptedOrderEntity.captainID = :captainId')

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getResult();
    }

    public function getTopCaptainsInThisMonth($fromDate, $toDate)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')

            ->select('AcceptedOrderEntity.captainID', 'count(AcceptedOrderEntity.captainID) countOrdersInMonth')
            
            ->addSelect('captainProfileEntity.name as captainName', 'captainProfileEntity.car', 'captainProfileEntity.age', 'captainProfileEntity.salary', 'captainProfileEntity.bounce', 'captainProfileEntity.image', 'captainProfileEntity.specialLink', 'captainProfileEntity.drivingLicence')
            
            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.captainID = AcceptedOrderEntity.captainID')

             ->where('AcceptedOrderEntity.date >= :fromDate')
             ->andWhere('AcceptedOrderEntity.date < :toDate')
            // ->andWhere("AcceptedOrderEntity.state ='deliverd'")
        
            ->addGroupBy('AcceptedOrderEntity.captainID')
            ->addGroupBy('captainProfileEntity.name')
            ->addGroupBy('captainProfileEntity.car')
            ->addGroupBy('captainProfileEntity.age')
            ->addGroupBy('captainProfileEntity.salary')
            ->addGroupBy('captainProfileEntity.bounce')
            ->addGroupBy('captainProfileEntity.image')
            ->addGroupBy('captainProfileEntity.specialLink')
            ->addGroupBy('captainProfileEntity.drivingLicence')
            
            ->having('count(AcceptedOrderEntity.captainID) > 0')
            ->setMaxResults(15)
            ->addOrderBy('countOrdersInMonth','DESC')
         
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            ->getQuery()
            ->getResult();
    }

     
    public function countOrdersInDay($captainID, $fromDate, $toDate)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')

          ->select('AcceptedOrderEntity.dateOnly', 'count(AcceptedOrderEntity.id) as countOrdersInDay')
        
          ->andWhere('AcceptedOrderEntity.captainID = :captainID') 
          ->andWhere('AcceptedOrderEntity.dateOnly >= :fromDate')
          ->andWhere('AcceptedOrderEntity.dateOnly < :toDate')

          ->addGroupBy('AcceptedOrderEntity.captainID')
          ->addGroupBy('AcceptedOrderEntity.dateOnly')

          ->having('count(AcceptedOrderEntity.captainID) > 0')
        
          ->addOrderBy('countOrdersInDay','DESC')

          ->setParameter('captainID', $captainID)
          ->setParameter('fromDate', $fromDate)
          ->setParameter('toDate', $toDate)
          
          ->getQuery()
          ->getResult();
       
    }

    public function getOwnerIdAndUuid($orderId)
    {
        return $this->createQueryBuilder('AcceptedOrderEntity')
            ->select('AcceptedOrderEntity.id', 'AcceptedOrderEntity.captainID')
            ->addSelect('orderEntity.id', 'orderEntity.ownerID', 'orderEntity.uuid')

            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = :orderId')

            ->andWhere('AcceptedOrderEntity.orderID = :orderId')
            ->setParameter('orderId', $orderId)
            ->getQuery()
            ->getResult();
    }
}
