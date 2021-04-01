<?php

namespace App\Repository;

use App\Entity\NotificationTokenEntity;
use App\Entity\CaptainProfileEntity;
use App\Entity\UserProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
/**
 * @method NotificationTokenEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method NotificationTokenEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method NotificationTokenEntity[]    findAll()
 * @method NotificationTokenEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class NotificationTokenEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, NotificationTokenEntity::class);
    }

    public function getNotificationTokenByCaptainUuid($uuid)
    {
        return $this->createQueryBuilder('notification')
                ->addSelect('captainProfile.captainID', 'captainProfile.name')

                ->leftJoin(CaptainProfileEntity::class, 'captainProfile', Join::WITH, 'captainProfile.uuid =:uuid ')
              
                ->andWhere("captainProfile.uuid = :uuid")
             
                ->setParameter('uuid', $uuid)

                ->getQuery()
                ->getResult();
    }

    public function getNotificationTokenByOwnerUuid($uuid)
    {
        return $this->createQueryBuilder('notification')
                ->addSelect('userProfileEntity.userID')

                ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.uuid =:uuid ')
              
                ->andWhere("userProfileEntity.uuid = :uuid")
             
                ->setParameter('uuid', $uuid)

                ->getQuery()
                ->getResult();
    }

}
