<?php


namespace App\Controller;


use App\Entity\AcceptedOrderEntity;
use App\Entity\BranchesEntity;
use App\Entity\CaptainProfileEntity;
use App\Entity\OrderEntity;
use App\Entity\PackageEntity;
use App\Entity\RatingEntity;
use App\Entity\RecordEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;

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
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }
}