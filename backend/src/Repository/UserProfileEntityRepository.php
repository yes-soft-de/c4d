<?php

namespace App\Repository;

use App\Entity\UserProfileEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
use App\Entity\OrderEntity;
use App\Entity\AcceptedOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method UserProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method UserProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method UserProfileEntity[]    findAll()
 * @method UserProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, UserProfileEntity::class);
    }

    public function getUserProfileByUserID($userID)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.userName','profile.userID', 'profile.image', 'profile.story', 'profile.branch', 'profile.free', 'profile.status')
            ->andWhere('profile.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserProfileByID($id)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.userName','profile.userID', 'profile.image', 'profile.story', 'profile.branch', 'profile.free', 'profile.status')

            ->andWhere('profile.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserProfile($userID)
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.userID = :userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getremainingOrders($userID)
    {
        return $this->createQueryBuilder('profile')
            ->select('subscriptionEntity.id as subscriptionID', 'subscriptionEntity.status as subscriptionstatus', 'subscriptionEntity.packageID as packageID', 'packageEntity.name as packagename', 'packageEntity.orderCount - count(orderEntity.id) as remainingOrders', 'subscriptionEntity.startDate as subscriptionStartDate', 'subscriptionEntity.endDate as subscriptionEndDate')

            ->leftJoin(SubscriptionEntity::class, 'subscriptionEntity', Join::WITH, 'subscriptionEntity.ownerID = profile.userID')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscriptionEntity.packageID')

            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.ownerID = profile.userID')
            
            ->andWhere('profile.userID=:userID')
            ->andWhere("orderEntity.state ='deliverd'")

            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
    }

    public function getUserInactive()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.userName', 'profile.image', 'profile.story', 'profile.status', 'profile.free', 'profile.branch')

            ->andWhere("profile.status = 'inactive' ")

            ->getQuery()
            ->getResult();
    }
}
