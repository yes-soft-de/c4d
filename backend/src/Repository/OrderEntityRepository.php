<?php

namespace App\Repository;

use App\Entity\OrderEntity;
use App\Entity\AcceptedOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
/**
 * @method OrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderEntity[]    findAll()
 * @method OrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderEntity::class);
    }

    public function getOrderById($id)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->andWhere('OrderEntity.id = :id')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOrdersByOwnerID($userID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->andWhere('OrderEntity.ownerID = :userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getResult();
    }

    public function orderStatus($userID, $ID)
    {
        return $this->createQueryBuilder('OrderEntity')
            ->andWhere('OrderEntity.ownerID = :userID')
            ->andWhere('OrderEntity.id = :ID')
            ->setParameter('userID', $userID)
            ->setParameter('ID', $ID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function closestOrders()
    {
        return $this->createQueryBuilder('OrderEntity')
      
            // ->andWhere('OrderEntity.ownerID = :userID')
            // ->setParameter('userID', $userID)
            ->getQuery()
            ->getArrayResult();
                        // ->getResult();
    }
}
