<?php

namespace App\Response;

class SubscriptionByIdResponse
{
    public $id;
    
    public $status;

    public $packageName;

    public $startDate;

    public $endDate;

    public $userName;

    public $city;

    public $location = [];

    public $packageNote;

    public $subscriptionNote;

}
