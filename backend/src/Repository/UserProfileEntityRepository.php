<?php

namespace App\Repository;

use App\Entity\UserProfileEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
use App\Entity\BranchesEntity;
use App\Entity\OrderEntity;
use App\Entity\CaptainProfileEntity;
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

            ->select('profile.id', 'profile.userName','profile.userID', 'profile.image', 'profile.story',
                'profile.branch', 'profile.free', 'profile.status', 'profile.city', 'profile.phone', 'profile.image')
            ->andWhere('profile.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserProfileByID($id)
    {
        return $this->createQueryBuilder('profile')
            ->select('profile.id', 'profile.userName','profile.userID', 'profile.image', 'profile.story', 'profile.branch', 'profile.free', 'profile.status', 'profile.phone')

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
            ->select('subscriptionEntity.id as subscriptionID', 'subscriptionEntity.status as subscriptionstatus', 'subscriptionEntity.packageID as packageID', 'packageEntity.name as packagename', 'packageEntity.orderCount - count(orderEntity.id) as remainingOrders', 'count(orderEntity.id) as countOrdersDelivered', 'subscriptionEntity.startDate as subscriptionStartDate', 'subscriptionEntity.endDate as subscriptionEndDate')

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

    public function getOwners()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.userID', 'profile.userName', 'profile.image', 'profile.story', 'profile.free', 'profile.branch as branchcount')
            ->addSelect('orderEntity.id as orderID', 'orderEntity.date', 'orderEntity.source', 'orderEntity.fromBranch', 'orderEntity.payment', 'orderEntity.destination','branchesEntity.location','branchesEntity.brancheName','branchesEntity.city as branchCity', 'acceptedOrderEntity.captainID','captainProfileEntity.name as captainName')
       
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'profile.userID = orderEntity.ownerID')

            ->leftJoin(BranchesEntity::class, 'branchesEntity', Join::WITH, 'orderEntity.fromBranch = branchesEntity.id')

            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'orderEntity.id = acceptedOrderEntity.orderID')

            ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'acceptedOrderEntity.captainID = captainProfileEntity.captainID')

            ->getQuery()
            ->getResult();
    }

    public function getAllOwners()
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.userID', 'profile.userName', 'profile.free', 'profile.branch', 'profile.uuid')

            ->getQuery()
            ->getResult();
    }
}
