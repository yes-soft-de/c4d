<?php


class MapperProfile
{
    /**
     * @var ObjectProfile $profile
     */
    private $profile;

    public function __construct()
    {
    }

    /**
     * @return ObjectProfile
     */
    public function getProfile(): ObjectProfile
    {
        return $this->profile;
    }

    public function setProfile($userName, $location, $story, $image): void
    {
        $this->profile = new ObjectProfile();

        //$this->profile->setUserID($userID);
        $this->profile->setUserName($userName);
        $this->profile->setLocation($location);
        $this->profile->setStory($story);
        $this->profile->setImage($image);
    }

    /**
     * @return array
     */
    public function getProfileAsArray(): array
    {
        return [
            "userName"=>$this->profile->getUserName(),
            "location"=>$this->profile->getLocation(),
            "story"=>$this->profile->getUserID(),
            "image"=>$this->profile->getImage()
        ];
    }

}