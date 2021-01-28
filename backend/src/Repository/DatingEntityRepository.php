<?php

namespace App\Repository;

use App\Entity\DatingEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DatingEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DatingEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DatingEntity[]    findAll()
 * @method DatingEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DatingEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DatingEntity::class);
    }

    public function datings()
    {
        return $this->createQueryBuilder('DatingEntityRepository')
            ->select('DatingEntityRepository.id','DatingEntityRepository.userName', 'DatingEntityRepository.phone', 'DatingEntityRepository.isDone')
            ->getQuery()
            ->getResult();
    }

}
