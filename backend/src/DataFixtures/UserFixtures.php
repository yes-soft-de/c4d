<?php

namespace App\DataFixtures;

use App\Entity\UserEntity;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Core\User\UserInterface;

class UserFixtures extends Fixture
{
    private $encode;

    public function __construct(UserPasswordEncoderInterface $encoder)
    {
        $this->encode = $encoder;
    }

    public function load(ObjectManager $manager)
    {
        for ($i = 2; $i < 20; $i++) {
            $user = new UserEntity("u" . $i);

            $password = $this->encode->encodePassword($user, "000");

            $user->setUserID("u" . $i);
            $user->setEmail("u" . $i . "@test.com");
            $user->setPassword($password);
            $user->setRoles(['user']);

            $manager->persist($user);
        }
        $manager->flush();
    }
}
