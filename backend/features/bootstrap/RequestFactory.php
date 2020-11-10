<?php


class RequestFactory
{
    public function prepareCreateUserRequestPayload()
    {
        $userMapper = new MapperUser();

        $userMapper->setUser("u22@test.com",
            ['user'],
            "000",
            "u22"
        );

        return $userMapper->getUserAsArray();
    }

    public function prepareUserLoginRequestPayload()
    {
        return [
            "username"=>"u22",
            "password"=>"000"
        ];
    }

    public function prepareCreateProfileRequestPayload()
    {
        $profileMapper = new MapperProfile();

        $profileMapper->setProfile(
            "u22",
            "address 22",
            "Bio",
            "imagePath22"
        );

        return $profileMapper->getProfileAsArray();
    }

    public function prepareUserProfileUpdateRequestPayload()
    {
        return [
            "userName" => "u22",
            "location" => "updated location",
            "story" => "updated story",
            "image" => "updatedImage"
        ];
    }

    public function prepareCreateAdminRequestPayload()
    {
        $adminMapper = new MapperAdmin();

        $adminMapper->setAdmin("a22@test.com",
            ['admin'],
            "000",
            "a22"
        );

        return $adminMapper->getAdminAsArray();
    }

    public function prepareAdminLoginRequestPayload()
    {
        return [
            "username"=>"a22",
            "password"=>"000"
        ];
    }

    public function prepareCreatePackageRequestPayload()
    {
        $packageMapper = new MapperPackage();

        $packageMapper->setPackage("p22",
            "2000",
            "",
            "22",
            "fake city",
            "120",
            "not active"
        );

        return $packageMapper->getPackageAsArray();
    }

    public function preparePackageUpdateRequestPayload($id)
    {
        return [
            "id"=>$id,
            "name" => "p22",
            "cost" => "2000",
            "carCount" => "20",
            "city" => "updated address",
            "orderCount"=>"120",
            "status"=>"active"
        ];
    }

    public function prepareCreateSubscriptionRequestPayload()
    {
        $subscriptionMapper = new MapperSubscription();

        $subscriptionMapper->setSubscription(
            "a22",
            "11",
            "current"
        );

        return $subscriptionMapper->getSubscriptionAsArray();
    }
}