<?php


namespace App\Controller;


use App\Entity\AcceptedOrderEntity;
use App\Entity\BankEntity;
use App\Entity\BranchesEntity;
use App\Entity\CaptainProfileEntity;
use App\Entity\CompanyInfoEntity;
use App\Entity\DatingEntity;
use App\Entity\OrderEntity;
use App\Entity\PackageEntity;
use App\Entity\PaymentsCaptainEntity;
use App\Entity\PaymentsEntity;
use App\Entity\RatingEntity;
use App\Entity\RecordEntity;
use App\Entity\ReportEntity;
use App\Entity\SettingEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\TermsCaptain;
use App\Entity\UpdateEntity;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Entity\VacationsEntity;

use Symfony\Component\Routing\Annotation\Route;

class EraseController extends BaseController
{
    /**
     * @Route("eraseAll", name="deleteAllData", methods={"DELETE"})
     */
    public function eraseAllData()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $swap = $em->getRepository(AcceptedOrderEntity::class)->createQueryBuilder('acceptedOrderEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $swapItems = $em->getRepository(BranchesEntity::class)->createQueryBuilder('branchesEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $usersProfiles = $em->getRepository(CaptainProfileEntity::class)->createQueryBuilder('captainProfileEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $report = $em->getRepository(OrderEntity::class)->createQueryBuilder('orderEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $comments = $em->getRepository(PackageEntity::class)->createQueryBuilder('packageEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $interactions = $em->getRepository(RatingEntity::class)->createQueryBuilder('ratingEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $images = $em->getRepository(RecordEntity::class)->createQueryBuilder('recordEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $users = $em->getRepository(SubscriptionEntity::class)->createQueryBuilder('subscriptionEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $setting = $em->getRepository(UserEntity::class)->createQueryBuilder('userEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $setting = $em->getRepository(UserProfileEntity::class)->createQueryBuilder('userProfileEntity')
                ->delete()
                ->getQuery()
                ->execute();
                
            $bank = $em->getRepository(BankEntity::class)->createQueryBuilder('BankEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $companyInfoEntity = $em->getRepository(CompanyInfoEntity::class)->createQueryBuilder('CompanyInfoEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $dating = $em->getRepository(DatingEntity::class)->createQueryBuilder('DatingEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $paymentsCaptain = $em->getRepository(PaymentsCaptainEntity::class)->createQueryBuilder('PaymentsCaptainEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $payments = $em->getRepository(PaymentsEntity::class)->createQueryBuilder('PaymentsEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $report = $em->getRepository(ReportEntity::class)->createQueryBuilder('ReportEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $setting = $em->getRepository(SettingEntity::class)->createQueryBuilder('SettingEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $termsCaptain = $em->getRepository(TermsCaptain::class)->createQueryBuilder('TermsCaptain')
                ->delete()
                ->getQuery()
                ->execute();

            $update = $em->getRepository(UpdateEntity::class)->createQueryBuilder('UpdateEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $vacations = $em->getRepository(VacationsEntity::class)->createQueryBuilder('VacationsEntity')
                ->delete()
                ->getQuery()
                ->execute();
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }
}