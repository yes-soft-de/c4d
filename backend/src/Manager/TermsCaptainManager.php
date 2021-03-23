<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\TermsCaptain;
use App\Repository\TermsCaptainRepository;
use App\Request\TermsCaptainCreateRequest;
use App\Request\TermsCaptainUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class TermsCaptainManager
{
    private $autoMapping;
    private $entityManager;
    private $repository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, TermsCaptainRepository $repository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->repository = $repository;
    }

    public function create(TermsCaptainCreateRequest $request)
    {
        $entity = $this->autoMapping->map(TermsCaptainCreateRequest::class, TermsCaptain::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getTermsCaptain()
    {
        return $this->repository->getTermsCaptain();
    }

    public function getTermsCaptainById($id) 
    {
        return $this->repository->getTermsCaptainById($id) ;
    }

    public function update(TermsCaptainUpdateRequest $request)
    {
        $item = $this->repository->find($request->getId());
       
        if ($item) {
            $item = $this->autoMapping->mapToObject(TermsCaptainUpdateRequest::class, TermsCaptain::class, $request, $item);
            
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }
}
