<?php

namespace App\Repository;

use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
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

    public function activeSubscription($userId)
    {
        return $this->createQueryBuilder('subscription')
            ->select('subscription.id', 'subscription.packageID', 'packageEntity.name', 'subscription.startDate', 'subscription.endDate', 'subscription.status', 'subscription.note')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->andWhere("subscription.status = 'active'")
            ->andWhere("subscription.ownerID = :userId")

            ->setParameter('userId', $userId)

            ->getQuery()
            ->getResult()
        ;
    }

    public function getSubscriptionsPending()
    {
        return $this->createQueryBuilder('subscription')
        
            ->select('subscription.id','subscription.status',  'packageEntity.name as packageName', 'subscription.startDate','subscription.endDate', 'subscription.note as subscriptionNote', 'userProfileEntity.userName', 'userProfileEntity.location', 'userProfileEntity.city', 'packageEntity.note as packageNote')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->join(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = subscription.ownerID')

            ->andWhere("subscription.status = 'inactive'")

            ->getQuery()
            ->getResult()
        ;
    }

    public function getSubscriptionById($id)
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.id','subscription.status',  'packageEntity.name as packageName', 'subscription.startDate','subscription.endDate', 'subscription.note as subscriptionNote', 'userProfileEntity.userName', 'userProfileEntity.location', 'userProfileEntity.city', 'packageEntity.note as packageNote')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->join(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = subscription.ownerID')

            ->andWhere("subscription.id = :id")

            ->setParameter('id', $id)

            ->getQuery()
            ->getResult()
        ;
    }

    public function subscriptionIsActive($ownerID)
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.status')

            ->andWhere("subscription.ownerID = :ownerID")

            ->setParameter('ownerID', $ownerID)

            ->getQuery()
            ->getResult()
        ;
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
}
