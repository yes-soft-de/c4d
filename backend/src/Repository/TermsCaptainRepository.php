<?php

namespace App\Repository;

use App\Entity\TermsCaptain;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method TermsCaptain|null find($id, $lockMode = null, $lockVersion = null)
 * @method TermsCaptain|null findOneBy(array $criteria, array $orderBy = null)
 * @method TermsCaptain[]    findAll()
 * @method TermsCaptain[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class TermsCaptainRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, TermsCaptain::class);
    }

    public function getTermsCaptain()
    {
        return $this->createQueryBuilder('terms')
            ->select('terms.id', 'terms.content')             
            ->getQuery()
            ->getResult();
    }

    public function getTermsCaptainById($id) 
    {
        return $this->createQueryBuilder('terms') 
            ->andWhere('terms.id = :id')   
            ->setParameter('id',$id)        
            ->getQuery()
            ->getOneOrNullResult();
    }
}
