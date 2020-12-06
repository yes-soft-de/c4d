# c4d App Backend  🚧
*. env file and private-public keys not enclosed .*
## Project setup

### Composer thing
```
composer update
```
### Database setup
First add to** .env** file correct connection string
`DATABASE_URL=mysql://root@127.0.0.1:3306/animeDB?serverVersion=5.7`

Then create database
```
php bin/console doctrine:database:create
```

After that make migration
```
php bin/console make:migration
```

Finaly run migration versions to create tables
```
php bin/console doctrine:migration:migrate
```

### Account
#### Create admin
```
/createAdmin
methods: POST
```

#### Create new user
```
/user
methods: POST
```

#### Create new captain
```
/captain
methods: POST
```
#### login
```
/login_check
methods: POST
```
#### Create user profile
```
/userprofile
methods: POST
```
#### Update user profile
```
/userprofile
methods: PUT
```
#### Get user profile by userID
```
/userprofile
methods: GET
```

### Package
#### Create package
ROLE_ADMIN

status value :  active or inactive .

```
/package
methods: POST
```
#### get Packages User Compatible
ROLE_OWNER
```
/packages
methods: GET
```
#### get All Packages
ROLE_ADMIN
```
/getAllpackages
methods: GET
```
#### get package By Id

```
/getpackageById/id
methods: GET
```
#### Update package
ROLE_ADMIN

status value :  active or inactive .

```
/package
methods: PUT
```


### Subscription
#### Create Subscription
ROLE_OWNER

```
/package
methods: POST
```
#### Get active subscribed package
ROLE_OWNER

```
/getActiveSubscription
methods: GET
```

#### Update Subscription
ROLE_ADMIN
status value :  active or inactive or finished or unaccept.
```
/subscription
methods: PUT
```

#### Get subscriptions pending
ROLE_ADMIN

```
/getSubscriptionsPending
methods: GET
```

#### Get subscription by Id

```
/getSubscriptionById/id
methods: GET
```

#### Dashboard Contracts
ROLE_ADMIN

```
/dashboardContracts
methods: GET
```
