<?php


class MapperPackage
{
    /**
     * @var ObjectPackage $package
     */
    private $package;

    public function __construct()
    {
    }

    public function setPackage($name, $cost, $note, $carCount, $city, $orderCount, $status)
    {
        $this->package = new ObjectPackage();

        $this->package->setName($name);
        $this->package->setCost($cost);
        $this->package->setNote($note);
        $this->package->setCarCount($carCount);
        $this->package->setCity($city);
        $this->package->setOrderCount($orderCount);
        $this->package->setStatus($status);
    }

    /**
     * @return ObjectPackage
     */
    public function getPackage(): ObjectPackage
    {
        return $this->package;
    }

    /**
     * @return array
     */
    public function getPackageAsArray(): array
    {
        return ["name"=>$this->package->getName(),
            "cost"=>$this->package->getCost(),
            "note"=>$this->package->getNote(),
            "carCount"=>$this->package->getCarCount(),
            "city"=>$this->package->getCity(),
            "orderCount"=>$this->package->getOrderCount(),
            "status"=>$this->package->getStatus()
        ];
    }
}