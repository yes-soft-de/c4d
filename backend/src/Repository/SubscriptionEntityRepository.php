<?php

namespace App\Repository;

use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
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

    public function getCurrentSubscribedPackages($userId)
    {
        return $this->createQueryBuilder('subscription')
            ->select('subscription.id', 'subscription.packageID', 'packageEntity.name', 'subscription.startDate', 'subscription.endDate', 'subscription.status')
            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')
            ->andWhere("subscription.status = 'active'")
            ->andWhere("subscription.ownerID = :userId")
            ->setParameter('userId', $userId)
            ->getQuery()
            ->getResult()
        ;
    }
}
