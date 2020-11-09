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
            ['user'],
            "000",
            "a22"
        );

        return $adminMapper->getAdminAsArray();
    }
}