<?php

namespace App\Repository;

use App\Entity\BranchesEntity;
use App\Entity\UserProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method BranchesEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method BranchesEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method BranchesEntity[]    findAll()
 * @method BranchesEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class BranchesEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, BranchesEntity::class);
    }

    public function getBranchesByUserId($userId)
    {
        return $this->createQueryBuilder('BranchesEntity')
            ->select('BranchesEntity.id', 'BranchesEntity.ownerID', 'BranchesEntity.location', 'BranchesEntity.city', 'BranchesEntity.brancheName','userProfileEntity.free','userProfileEntity.userName','userProfileEntity.status','BranchesEntity.isActive') 

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = BranchesEntity.ownerID')

            ->andWhere("BranchesEntity.ownerID = :userId ")

            ->setParameter('userId',$userId)
            ->getQuery()
            ->getResult();
    }

    public function branchesByUserId($userId)
    {
        return $this->createQueryBuilder('BranchesEntity')
            ->select('BranchesEntity.id', 'BranchesEntity.ownerID', 'BranchesEntity.location', 'BranchesEntity.city', 'BranchesEntity.brancheName') 

            ->andWhere("BranchesEntity.ownerID = :userId ")

            ->setParameter('userId',$userId)
            ->getQuery()
            ->getResult();
    }

    public function getBrancheById($Id)
    {
        return $this->createQueryBuilder('BranchesEntity')
            ->select('BranchesEntity.id', 'BranchesEntity.ownerID', 'BranchesEntity.location', 'BranchesEntity.city', 'BranchesEntity.brancheName') 

            ->andWhere("BranchesEntity.ownerID = :userId ")

            ->setParameter('userId',$userId)
            ->getQuery()
            ->getResult();
    }
}
