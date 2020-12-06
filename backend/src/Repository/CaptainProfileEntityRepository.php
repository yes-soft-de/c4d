<?php

namespace App\Repository;

use App\Entity\CaptainProfileEntity;
use App\Entity\AcceptedOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method CaptainProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainProfileEntity[]    findAll()
 * @method CaptainProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainProfileEntity::class);
    }

    public function getCaptainprofile($userID)
    {
        return $this->createQueryBuilder('captainProfile')

            ->andWhere('captainProfile.captainID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getcaptainprofileByCaptainID($userID)
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state')

            ->andWhere('captainProfile.captainID=:userID')
            
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainprofileByID($id)
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state')

            ->andWhere('captainProfile.id=:id')
            
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserInactive()
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status')

            ->andWhere("captainProfile.status = 'inactive' ")

            ->getQuery()
            ->getResult();
    }

    public function getCaptinsActive()
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status')

            ->andWhere("captainProfile.status = 'active' ")

            ->getQuery()
            ->getResult();
    }

    public function captainIsActive($captainID)
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.status')

            ->andWhere('captainProfile.captainID = :captainID')

            ->setParameter('captainID', $captainID)

            ->getQuery()
            ->getResult();
    }
    
    public function ongoingCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.id', 'captainProfile.name', 'acceptedOrderEntity.duration', 'acceptedOrderEntity.date', 'acceptedOrderEntity.orderID', 'acceptedOrderEntity.captainID')

            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'captainProfile.captainID = acceptedOrderEntity.captainID')

            ->andWhere("acceptedOrderEntity.state = 'ongoing'")

            ->getQuery()
            ->getResult();
    }
    
    public function pendingCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state' )

            ->andWhere("captainProfile.status = 'inactive'")

            ->getQuery()
            ->getResult();
    }
    
    public function dayOfCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state')

            ->andWhere("captainProfile.state = 'vacation'")

            ->getQuery()
            ->getResult();
    }

    public function countpendingCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('count (captainProfile.id) as countPendingCaptains')

            ->andWhere("captainProfile.status = 'inactive'")

            ->getQuery()
            ->getOneOrNullResult();
    }
    public function countOngoingCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('count (captainProfile.id) as countOngoingCaptains')

            ->andWhere("captainProfile.state = 'ongoing'")

            ->getQuery()
            ->getOneOrNullResult();
    }
    public function countDayOfCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('count (captainProfile.id) as countDayOfCaptains')

            ->andWhere("captainProfile.state = 'vacation'")

            ->getQuery()
            ->getOneOrNullResult();
    }
}
