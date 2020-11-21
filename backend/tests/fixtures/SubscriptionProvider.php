<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class SubscriptionProvider extends TestCase
{
    public function create()
    {
        return [
            'CreateOrder' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }
}
