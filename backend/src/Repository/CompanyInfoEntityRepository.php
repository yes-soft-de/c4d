<?php

namespace App\Repository;

use App\Entity\CompanyInfoEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CompanyInfoEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CompanyInfoEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CompanyInfoEntity[]    findAll()
 * @method CompanyInfoEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CompanyInfoEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CompanyInfoEntity::class);
    }
 
    public function  getcompanyinfoById($id)
    {
        return $this->createQueryBuilder('CompanyInfoEntity') 
            ->andWhere("CompanyInfoEntity.id = :id ")
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }
    public function  getcompanyinfoAll()
    {
        return $this->createQueryBuilder('CompanyInfoEntity') 
            ->select('CompanyInfoEntity.id, CompanyInfoEntity.phone')
            ->getQuery()
            ->getResult();
    }
}
