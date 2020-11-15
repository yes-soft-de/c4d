<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Repository\OrderEntityRepository;
use App\Request\OrderCreateRequest;
use App\Request\OrderUpdateRequest;
use App\Request\GetByIdRequest;
use App\Request\DeleteRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class OrderManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $repository;
    private $userProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, OrderEntityRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->repository = $repository;
    }

    public function create(OrderCreateRequest $request)
    {
        $item = $this->autoMapping->map(OrderCreateRequest::class, OrderEntity::class, $request);
      
        $item->setDate($item->getDate());
       
        $this->entityManager->persist($item);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $item;
    }

    public function getOrderById(GetByIdRequest $request)
    {
        return $this->repository->getOrderById($request->getId());
    }

    public function getOrdersByOwnerID($userID)
    {
        return $this->repository->getOrdersByOwnerID($userID);
    }

    public function orderStatus($userID, $ID)
    {
        return $this->repository->orderStatus($userID, $ID);
    }

    public function closestOrders()
    {
        return $this->repository->closestOrders();
    }

    public function update(OrderUpdateRequest $request)
    {
        $item = $this->repository->find($request->getId());

        if ($item)
        {
            $item = $this->autoMapping->mapToObject(OrderUpdateRequest::class,
            OrderEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function delete(DeleteRequest $request)
    {
        $entity = $this->repository->find($request->getId());
        if(!$entity )
        {
        }
        else
        {
            $this->entityManager->remove($entity);
            $this->entityManager->flush();
        }
        return $entity;
    }
}