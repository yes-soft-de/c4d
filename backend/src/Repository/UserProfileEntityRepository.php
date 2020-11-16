<?php

namespace App\Repository;

use App\Entity\UserProfileEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
use App\Entity\OrderEntity;
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

    public function getProfileByUSerID($userID)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.userName', 'profile.image', 'profile.story', 'profile.location')
            ->andWhere('profile.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserProfile($userID)
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getremainingOrders($userID, $date)
    {
        return $this->createQueryBuilder('profile')
            ->select('subscriptionEntity.id as subscriptionID', 'subscriptionEntity.status as subscriptionstatus', 'subscriptionEntity.packageID as packageID', 'packageEntity.orderCount - count(orderEntity.id) as remainingOrders', 'subscriptionEntity.startDate as subscriptionStartDate')
            ->leftJoin(SubscriptionEntity::class, 'subscriptionEntity', Join::WITH, 'subscriptionEntity.ownerID = profile.userID')
            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscriptionEntity.packageID')
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.ownerID = profile.userID')
            ->andWhere('profile.userID=:userID')
            ->andWhere('subscriptionEntity.endDate < :date')
            ->setParameter('userID', $userID)
            ->setParameter('date', $date)

            ->getQuery()
            ->getResult();
    }
}
