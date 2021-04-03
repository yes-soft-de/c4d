<?php

namespace App\Repository;

use App\Entity\RoomIdHelperEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RoomIdHelperEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RoomIdHelperEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RoomIdHelperEntity[]    findAll()
 * @method RoomIdHelperEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RoomIdHelperEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RoomIdHelperEntity::class);
    }

    function getByRoomID($roomID)
    {
        return $this->createQueryBuilder('RoomIdHelperEntity')
            ->addSelect('RoomIdHelperEntity.id', 'RoomIdHelperEntity.captainID', 'RoomIdHelperEntity.ownerID') 
            ->andWhere('RoomIdHelperEntity.roomID = :roomID')
            ->setParameter('roomID',$roomID)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
