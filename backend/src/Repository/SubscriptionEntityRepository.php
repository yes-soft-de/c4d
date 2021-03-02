<?php

namespace App\Repository;

use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
use App\Entity\OrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\UserProfileEntity;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method SubscriptionEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SubscriptionEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SubscriptionEntity[]    findAll()
 * @method SubscriptionEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SubscriptionEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SubscriptionEntity::class);
    }

    public function getSubscriptionForOwner($userId)
    {
        return $this->createQueryBuilder('subscription')
            ->select('subscription.id', 'subscription.packageID', 'packageEntity.name', 'subscription.startDate', 'subscription.endDate', 'subscription.status', 'subscription.note')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->andWhere("subscription.ownerID = :userId")

            ->setParameter('userId', $userId)

            ->getQuery()
            ->getResult()
        ;
    }

    public function getSubscriptionsPending()
    {
        return $this->createQueryBuilder('subscription')
        
            ->select('subscription.id','subscription.status',  'packageEntity.name as packageName', 'subscription.startDate','subscription.endDate', 'subscription.note as subscriptionNote', 'userProfileEntity.userName', 'packageEntity.note as packageNote')

            ->Join(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->join(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = subscription.ownerID')

            ->andWhere("subscription.status = 'inactive'")

            ->getQuery()
            ->getResult()
        ;
    }

    public function getSubscriptionById($id)
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.id','subscription.status',  'packageEntity.name as packageName', 'subscription.startDate','subscription.endDate', 'subscription.note as subscriptionNote', 'userProfileEntity.userName', 'packageEntity.note as packageNote')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->join(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = subscription.ownerID')

            ->andWhere("subscription.id = :id")

            ->setParameter('id', $id)

            ->getQuery()
            ->getResult()
        ;
    }

    public function subscriptionIsActive($ownerID, $subscribeId)
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.status')

            // ->andWhere("subscription.ownerID = :ownerID")
            ->andWhere("subscription.id = :subscribeId")

            // ->setParameter('ownerID', $ownerID)
            ->setParameter('subscribeId', $subscribeId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countpendingContracts()
    {
        return $this->createQueryBuilder('subscription')

            ->select('count (subscription.id) as countPendingContracts')

            ->andWhere("subscription.status = 'inactive'")

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countDoneContracts()
    {
        return $this->createQueryBuilder('subscription')

            ->select('count (subscription.id) as countDoneContracts')

            ->andWhere("subscription.status = 'active'")

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function countCancelledContracts()
    {
        return $this->createQueryBuilder('subscription')

            ->select('count (subscription.id) as countCancelledContracts')

            ->andWhere("subscription.status = 'unaccept'")

            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getRemainingOrders($ownerID, $id)
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.id as subscriptionID', 'packageEntity.orderCount - count(orderEntity.id) as remainingOrders', 'packageEntity.orderCount', 'packageEntity.name as packagename', 'packageEntity.id as packageID', 'count(orderEntity.id) as countOrdersDelivered ', 'subscription.startDate as subscriptionStartDate', 'subscription.endDate as subscriptionEndDate', 'userProfileEntity.userID', 'userProfileEntity.userName', 'packageEntity.carCount as packageCarCount', 'packageEntity.orderCount as packageOrderCount')

            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.subscribeId = subscription.id')

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = subscription.ownerID')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')
            
            ->andWhere('subscription.ownerID=:ownerID')
            ->andWhere('subscription.id=:id')
            // ->andWhere("orderEntity.state ='deliverd'")

            ->addGroupBy('subscription.id')
            ->setMaxResults(1)
            ->addOrderBy('subscription.id','DESC')
           
            ->setParameter('ownerID', $ownerID)
            ->setParameter('id', $id)
           
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function subscripeNewUsers($fromDate, $toDate)
    {
        return $this->createQueryBuilder('subscription')

            ->select('count(subscription.id) as NewUsersThisMonth')

            ->where('subscription.startDate >= :fromDate')
            ->andWhere('subscription.startDate < :toDate')

            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getSubscriptionCurrent($ownerID)
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.id')
            
            ->andWhere('subscription.ownerID=:ownerID')
            ->andWhere('subscription.isFuture= 0')

            // ->addGroupBy('subscription.id')
            ->addGroupBy('subscription.startDate')
            ->setMaxResults(1)
            ->addOrderBy('subscription.startDate','DESC')
           
            ->setParameter('ownerID', $ownerID)
           
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getNextSubscription($ownerID)
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.id')
            
            ->andWhere('subscription.ownerID=:ownerID')
            ->andWhere('subscription.isFuture= 1')
           
            ->setParameter('ownerID', $ownerID)
           
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function totalAmountOfSubscriptions($ownerID)
    {
        return $this->createQueryBuilder('subscription')
            ->select('packageEntity.cost * count(subscription.id) as totalAmountOfSubscriptions')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->andWhere('subscription.ownerID=:ownerID')
            ->addGroupBy('subscription.packageID')
            ->setParameter('ownerID', $ownerID)
           
            ->getQuery()
            ->getResult();
    }
}
