<?php

namespace App\DataFixtures;

use App\Entity\SubscriptionEntity;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class SubscriptionFixtures extends Fixture
{

    public function load(ObjectManager $manager)
    {
        for ($i = 0; $i < 20; $i++) {
            $startDate = \DateTime::createFromFormat('Ymd', '2019' . $i . '01');
            $endDate = \DateTime::createFromFormat('Ymd', '2020' . $i . '01');

            $subscription = new SubscriptionEntity();

            $subscription->setOwnerID("a" . $i);
            $subscription->setPackageID($i);
            $subscription->setStartDate($startDate);
            $subscription->setEndDate($endDate);
            $subscription->setStatus('current');

            $manager->persist($subscription);
        }
        $manager->flush();
    }
}
