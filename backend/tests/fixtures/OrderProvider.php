<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class OrderProvider extends TestCase
{
    public function create()
    {
        return [
            'CreateOrder' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function getOrderById()
    {
        return [
            'getOrderById' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function getOrdersByOwnerID()
    {
        return [
            'getOrdersByOwnerID' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }
    public function orderStatus()
    {
        return [
            'orderStatus' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }
    public function closestOrders()
    {
        return [
            'closestOrders' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function update()
    {
        return [
            'update' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function delete()
    {
        return [
            'delete' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }
}
