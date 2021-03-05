<?php

namespace App\Repository;

use App\Entity\BankEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\UserProfileEntity;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method BankEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method BankEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method BankEntity[]    findAll()
 * @method BankEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class BankEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, BankEntity::class);
    }

    public function getAccountByUserId($userId)
    {
        return $this->createQueryBuilder('BankEntity')
            ->addSelect('BankEntity.id', 'BankEntity.bankName', 'BankEntity.userID', 'BankEntity.stcPay', 'BankEntity.accountID', 'userProfileEntity.userName') 

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = BankEntity.userID')

            ->andWhere("BankEntity.userID = :userId ")

            ->setParameter('userId',$userId)
            ->getQuery()
            ->getOneOrNullResult();
    }
    public function getByUserId($userId)
    {
        return $this->createQueryBuilder('BankEntity')
            ->andWhere("BankEntity.userID = :userId ")

            ->setParameter('userId',$userId)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAccount($userId)
    {
        return $this->createQueryBuilder('BankEntity')
            ->addSelect('BankEntity.id', 'BankEntity.bankName', 'BankEntity.userID', 'BankEntity.accountID, userProfileEntity.userName') 

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = BankEntity.userID')

            ->andWhere("BankEntity.userID = :userId ")

            ->setParameter('userId',$userId)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAccounts()
    {
        return $this->createQueryBuilder('BankEntity')
            ->addSelect('BankEntity.id', 'BankEntity.bankName', 'BankEntity.userID', 'BankEntity.accountID, userProfileEntity.userName') 

            ->leftJoin(UserProfileEntity::class, 'userProfileEntity', Join::WITH, 'userProfileEntity.userID = BankEntity.userID')
            
            ->getQuery()
            ->getResult();
    }
}
