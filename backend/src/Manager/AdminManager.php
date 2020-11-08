<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\UserEntity;
use App\Repository\UserEntityRepository;
use App\Request\AdminCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class AdminManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                UserPasswordEncoderInterface $encoder, UserEntityRepository $userRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
    }

    public function adminCreate(AdminCreateRequest $request)
    {
        $adminCreate = $this->autoMapping->map(AdminCreateRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword())
        {
            $adminCreate->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        $adminCreate->setCreateDate(new \DateTime('now'));

        if ($request->getRoles() == null)
        {
            $request->setRoles(['user']);
        }
        $adminCreate->setRoles($request->getRoles());

        $this->entityManager->persist($adminCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $adminCreate;
    }
}