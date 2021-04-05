<?php

namespace App\Repository;

use App\Entity\NotificationTokenEntity;
use App\Entity\ReportEntity;
use App\Entity\CaptainProfileEntity;
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
    
    public function getByReprotUuid($uuid)
    {
        return $this->createQueryBuilder('NotificationTokenEntity')
        ->addSelect('reportEntity.userId') 

        ->leftJoin(ReportEntity::class, 'reportEntity', Join::WITH, 'reportEntity.uuid = :uuid')

        ->andWhere("reportEntity.uuid = :uuid ")
        ->setParameter('uuid', $uuid) 
        ->getQuery()
        ->getResult();
    }
    
    public function getCaptainUuid($uuid)
    {
        return $this->createQueryBuilder('NotificationTokenEntity')
        ->addSelect('captainProfileEntity.captainID') 

        ->leftJoin(CaptainProfileEntity::class, 'captainProfileEntity', Join::WITH, 'captainProfileEntity.uuid = :uuid')

        ->andWhere("captainProfileEntity.uuid = :uuid ")
        ->setParameter('uuid', $uuid) 
        ->getQuery()
        ->getResult();
    }
}