<?php

namespace App\Repository;

use App\Entity\ReportEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\UserProfileEntity;
use Doctrine\ORM\Query\Expr\Join;
/**
 * @method ReportEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ReportEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ReportEntity[]    findAll()
 * @method ReportEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ReportEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ReportEntity::class);
    }

    public function getReports()
    {
        return $this->createQueryBuilder('ReportEntity')
            ->addSelect('ReportEntity.id', 'ReportEntity.orderId', 'ReportEntity.reason', 'ReportEntity.userId', 'userProfileEntity.userName', 'ReportEntity.uuid', 'ReportEntity.newMessageStatus') 

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = ReportEntity.userId')
            
            ->getQuery()
            ->getResult();
    }

    public function getReport($id)
    {
        return $this->createQueryBuilder('ReportEntity')
            ->addSelect('ReportEntity.id', 'ReportEntity.orderId', 'ReportEntity.reason', 'ReportEntity.userId', 'userProfileEntity.userName', 'ReportEntity.uuid', 'ReportEntity.newMessageStatus') 

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = ReportEntity.userId')
            ->andWhere('ReportEntity.id = :id')
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getreortByUuid($uuid)
    {
        return $this->createQueryBuilder('ReportEntity')
            ->andWhere('ReportEntity.uuid = :uuid')
            ->setParameter('uuid',$uuid)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
