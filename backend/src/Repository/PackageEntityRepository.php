<?php

namespace App\Repository;

use App\Entity\PackageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method PackageEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method PackageEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method PackageEntity[]    findAll()
 * @method PackageEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PackageEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PackageEntity::class);
    }

    public function getActivePackages()
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.city, package.orderCount')
            ->andWhere('package.status = :status')
            ->setParameter('status', "active")
            ->getQuery()
            ->getResult()
        ;
    }

    public function getPackagesByCityOwner($location)
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount, package.status')
            ->andWhere('package.city = :city')
            ->setParameter('city', $location)
            ->getQuery()
            ->getResult()
            ;
    }
}
