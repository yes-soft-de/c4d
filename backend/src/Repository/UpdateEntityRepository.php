<?php

namespace App\Repository;

use App\Entity\UpdateEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method UpdateEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method UpdateEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method UpdateEntity[]    findAll()
 * @method UpdateEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UpdateEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, UpdateEntity::class);
    }

    public function  getUpdateById($id)
    {
        return $this->createQueryBuilder('UpdateEntity') 
            ->andWhere("UpdateEntity.id = :id ")
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function  getUpdateAll()
    {
        return $this->createQueryBuilder('UpdateEntity') 
            ->select('UpdateEntity.id, UpdateEntity.title, UpdateEntity.content')
            ->getQuery()
            ->getResult();
    }
}
