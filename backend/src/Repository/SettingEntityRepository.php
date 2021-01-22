<?php

namespace App\Repository;

use App\Entity\SettingEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SettingEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SettingEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SettingEntity[]    findAll()
 * @method SettingEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SettingEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SettingEntity::class);
    }

    public function getSetting()
    {
        $result =  $this->createQueryBuilder('setting')

            ->andWhere('setting.id=:id')
            ->setParameter('id','1')
            ->getQuery()
            ->getOneOrNullResult();

        return $result;
    }
}
