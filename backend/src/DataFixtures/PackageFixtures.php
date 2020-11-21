<?php

namespace App\DataFixtures;

use App\Entity\PackageEntity;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class PackageFixtures extends Fixture
{
    public function load(ObjectManager $manager)
    {
        for ($i = 0; $i < 20; $i++) {
            $package = new PackageEntity();

            $package->setName("p" . $i);
            $package->setCity("fixture city");
            $package->setCarCount($i);
            $package->setOrderCount($i);
            $package->setCost($i * 20);
            $package->setStatus('');
            $package->setNote('fake');

            $manager->persist($package);
        }

        $manager->flush();
    }
}
