<?php


class MapperAdmin
{
    /**
     * @var ObjectAdmin $admin
     */
    private $admin;

    /**
     * @return ObjectAdmin
     */
    public function getAdmin(): ObjectAdmin
    {
        return $this->admin;
    }

    public function setAdmin($email, $roles, $password, $userID): void
    {
        $this->admin = new ObjectAdmin();

        $this->admin->setEmail($email);
        $this->admin->setRoles($roles);
        $this->admin->setPassword($password);
        $this->admin->setUserID($userID);
    }

    /**
     * @return array
     */
    public function getAdminAsArray(): array
    {
        return [
            "email"=>$this->admin->getEmail(),
            "roles"=>$this->admin->getRoles(),
            "password"=>$this->admin->getPassword(),
            "userID"=>$this->admin->getUserID()
        ];
    }
}