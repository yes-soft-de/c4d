<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class AcceptedOrderProvider extends TestCase
{
    public function create()
    {
        return [
            'CreateAcceptedOrder' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function totalEarn()
    {
        return [
            'totalEarn' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function acceptedOrder()
    {
        return [
            'acceptedOrder' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }
    public function closestOrders()
    {
        return [
            'closestOrders' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }
}
