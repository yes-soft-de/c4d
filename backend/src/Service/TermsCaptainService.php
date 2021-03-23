<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\TermsCaptain;
use App\Manager\TermsCaptainManager;
use App\Request\TermsCaptainCreateRequest;
use App\Request\TermsCaptainUpdateRequest;
use App\Response\TermsCaptainCreateResponse;

class TermsCaptainService
{
    private $autoMapping;
    private $termsCaptainManager;

    public function __construct(AutoMapping $autoMapping, TermsCaptainManager $termsCaptainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->termsCaptainManager = $termsCaptainManager;
    }

    public function create(TermsCaptainCreateRequest $request)
    {
        $item = $this->termsCaptainManager->create($request);

        return $this->autoMapping->map(TermsCaptain::class, TermsCaptainCreateResponse::class, $item);
    }

    public function getTermsCaptain() {
        $response = [];
        $items = $this->termsCaptainManager->getTermsCaptain();
      
        foreach ($items as $item) {
            $response[] =  $this->autoMapping->map('array', TermsCaptainCreateResponse::class, $item);
            }
            return $response;
    }

    public function getTermsCaptainById($id) {
       
        $item = $this->termsCaptainManager->getTermsCaptainById($id);
        
        return $this->autoMapping->map(TermsCaptain::class, TermsCaptainCreateResponse::class, $item);
            
    }

    public function update(TermsCaptainUpdateRequest $request)
    {
        $item = $this->termsCaptainManager->update($request);

        return $this->autoMapping->map(TermsCaptain::class, TermsCaptainCreateResponse::class, $item);
    }
}
