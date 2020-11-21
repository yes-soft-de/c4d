<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class UserProvider extends TestCase
{
    public function register()
    {
        return [
            'userRegister' => [1, 1], [33, 33], [55, 55]
        ];
    }

    public function userProfileCreate()
    {
        return [
            'userProfileCreate' => [1, 1], [330, 330]
        ];
    }

    public function userProfileUpdate()
    {
        return [
            'userProfileUpdate' => [1, 1]
        ];
    }

    public function getUserProfileByUserID()
    {
        return [
            'getUserProfileByUserID' => [11, 11]
        ];
    }

    public function getremainingOrders()
    {
        return [
            'getremainingOrders' => ["11", "11"]
        ];
    }

    public function captainprofileCreate()
    {
        return [
            'captainprofileCreate' => ["11", "11"]
        ];
    }

    public function captainprofileUpdate()
    {
        return [
            'captainprofileUpdate' => ["11", "11"]
        ];
    }

    public function getcaptainprofileByID()
    {
        return [
            'getcaptainprofileByID' => ["11", "11"]
        ];
    }
}
