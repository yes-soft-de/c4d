<?php

namespace App\DataFixtures;

use App\Entity\UserProfileEntity;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class UserProfileFixtures extends Fixture
{

    public function load(ObjectManager $manager)
    {
        for ($i = 2; $i < 20; $i++) {
            $userProfile = new UserProfileEntity();

            $userProfile->setUserID("u" . $i);
            $userProfile->setImage("imagePath" . $i);
            $userProfile->setUserName("u" . $i);
            $userProfile->setLocation("address " . $i);
            $userProfile->setStory('Bio');

            $manager->persist($userProfile);
        }

        $manager->flush();
    }
}
