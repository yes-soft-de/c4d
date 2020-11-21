<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class PackageProvider extends TestCase
{

    public function create()
    {
        return [
            'CreatePackage' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function getPackages()
    {
        return [
            'getPackages' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function getActivePackages()
    {
        return [
            'getActivePackages' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function update()
    {
        return [
            'update' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }
}
