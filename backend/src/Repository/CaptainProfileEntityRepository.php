<?php

namespace App\Repository;

use App\Entity\CaptainProfileEntity;
use App\Entity\AcceptedOrderEntity;
use App\Entity\UserProfileEntity;
use App\Entity\OrderEntity;
use App\Entity\BranchesEntity;
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

    public function getcaptainprofileByCaptainID($captainID)
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state')

            ->andWhere('captainProfile.captainID=:captainID')
            
            ->setParameter('captainID', $captainID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getByCaptainIDForUpdate($captainID)
    {
        return $this->createQueryBuilder('captainProfile')

            ->andWhere('captainProfile.captainID = :captainID')
            ->setParameter('captainID', $captainID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainprofileByID($captainProfileId)
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'acceptedOrderEntity.state', 'captainProfile.bounce', 'captainProfile.uuid')

            
            ->addSelect('acceptedOrderEntity.captainID', 'acceptedOrderEntity.state')
            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.captainID = captainProfile.captainID')

            ->andWhere('captainProfile.id=:captainProfileId')
            
            ->setParameter('captainProfileId', $captainProfileId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainprofileByIDStateDayOff($captainProfileId)
    {
        return $this->createQueryBuilder('captainProfile')
            ->addSelect('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state', 'captainProfile.bounce', 'captainProfile.uuid')

            ->andWhere('captainProfile.id=:captainProfileId')
            
            ->setParameter('captainProfileId', $captainProfileId)

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

    public function getCaptainsState($state)
    {
        return  $this->createQueryBuilder('captainProfile')
         
            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.bounce')
            ->addSelect('acceptedOrderEntity.captainID', 'acceptedOrderEntity.state')
            
            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'acceptedOrderEntity.captainID = captainProfile.captainID')

            ->andWhere('acceptedOrderEntity.state =:state')
            ->setParameter('state', $state)
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
            ->select('count (acceptedOrderEntity.captainID) as countOngoingCaptains')

            ->join(AcceptedOrderEntity::class, 'acceptedOrderEntity')

            ->andWhere("acceptedOrderEntity.state = 'ongoing'")

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
   
    public function getDayOfCaptains()
    {
        return $this->createQueryBuilder('captainProfile')
            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.state')

            ->andWhere("captainProfile.state = 'vacation'")

            ->getQuery()
            ->getResult();
    }

    public function totalBounceCaptain($id)
    {
        return $this->createQueryBuilder('captainProfile')

            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.bounce')

            ->andWhere('captainProfile.id =:id')
            ->setParameter('id', $id)
            ->getQuery()
            ->getResult();
    }

    public function getCaptains()
    {
        return $this->createQueryBuilder('captainProfile')

            ->select('captainProfile.id', 'captainProfile.captainID', 'captainProfile.name as captainName', 'captainProfile.image', 'captainProfile.location', 'captainProfile.age', 'captainProfile.car', 'captainProfile.drivingLicence', 'captainProfile.salary', 'captainProfile.status', 'captainProfile.bounce')

            ->addSelect('acceptedOrderEntity.captainID')

            ->addSelect('orderEntity.id as orderID', 'orderEntity.date', 'orderEntity.source', 'orderEntity.fromBranch', 'orderEntity.payment', 'orderEntity.destination','branchesEntity.location','branchesEntity.brancheName','branchesEntity.city as branchCity','orderEntity.ownerID')

            ->addSelect('userProfileEntity.id', 'userProfileEntity.userID', 'userProfileEntity.userName', 'userProfileEntity.image', 'userProfileEntity.story', 'userProfileEntity.free', 'userProfileEntity.branch as branchcount')
       
            
            ->leftJoin(AcceptedOrderEntity::class, 'acceptedOrderEntity', Join::WITH, 'captainProfile.captainID = acceptedOrderEntity.captainID')

            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'acceptedOrderEntity.orderID  = orderEntity.id')

            ->leftJoin(BranchesEntity::class, 'branchesEntity', Join::WITH, 'orderEntity.fromBranch = branchesEntity.id')

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'orderEntity.ownerID = userProfileEntity.userID')

            ->getQuery()
            ->getResult();
    }
}
