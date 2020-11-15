<?php


class MapperUser
{
    /**
     * @var ObjectUser $user
     */
    private $user;

    public function __construct()
    {
    }

    public function setUser($email, $roles, $password, $userID)
    {
        $this->user = new ObjectUser();

        $this->user->setEmail($email);
        $this->user->setRoles($roles);
        $this->user->setPassword($password);
        $this->user->setUserID($userID);
    }

    /**
     * @return ObjectUser
     */
    public function getUser(): ObjectUser
    {
        return $this->user;
    }

    /**
     * @return array
     */
    public function getUserAsArray(): array
    {
        return ["email"=>$this->user->getEmail(),
            "roles"=>$this->user->getRoles(),
            "password"=>$this->user->getPassword(),
            "userID"=>$this->user->getUserID()
        ];
    }
}