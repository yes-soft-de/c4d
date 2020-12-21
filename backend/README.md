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

"roles":["ROLE_ADMIN"]
```
/createAdmin
methods: POST
```

#### Create new user

"roles":["ROLE_OWNER"]
"roles":["ROLE_CAPTAIN"]
```
/user
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
#### Get remaining orders for specific owner
```
/remainingOrders
methods: GET
```
``
#### Create captain profile 
```
/captainprofile
methods: POST
```
#### Update captain profile 
send value id within the postman body .
```
/captainprofile
methods: PUT
```
#### Get captainprofile by captainID 

ROLE_CAPTAIN
```
/captainprofile
methods: GET
```
#### Get Captainprofile By ID 

ROLE_ADMIN
```
/captainprofile/id
methods: GET
```
#### Get Owner Or Captain Inactive (pending) 

ROLE_ADMIN
userType: captain or owner.

```
/getUserInactive/userType
methods: GET
```

#### Get captains state

ROLE_ADMIN
state: vacation or free or ongoing
```
/getCaptainsState/{state}
methods: GET
```

#### dashboard Captains

ROLE_ADMIN

```
/dashboardCaptains
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

### Order
#### Create Order
ROLE_OWNER

must send value for source(map json) or fromBranch(branch name)

```
/order
methods: POST
```
#### Get Order By ID

```
/order/orderId
methods: GET
```
#### Get Orders By Owner ID

```
/orders
methods: GET
```
#### Order status For Owner

```
/orderStatus/orderId
methods: GET
```
#### Get Pending Orders | orders that no captain has taken yet
ROLE_CAPTAIN
```
/closestOrders
methods: GET
```

#### Update Order
ROLE_OWNER

state: deliverd or cancelled.

```
/order
methods: PUT
```

#### Update order State By Captain
ROLE_CAPTAIN

state: ongoing or deliverd .

```
/orderUpdateStateByCaptain
methods: PUT
```

#### Delete Order
ROLE_OWNER

```
/order/id
methods: DELETE
```

#### Count All Orders
ROLE_ADMIN

```
/countAllOrders
methods: DELETE
```

#### dashboard Orders
ROLE_ADMIN

```
/dashboardOrders
methods: GET
```

#### GetActiveOrders
ROLE_ADMIN

```
/ongoingOrders
methods: GET
```

### AcceptedOrder
#### Create acceptedOrder
ROLE_CAPTAIN

```
/acceptedOrder
methods: POST
```
#### Get order status for captain
ROLE_CAPTAIN

```
/GetOrderStatusForCaptain/orderId
methods: GET
```
#### Get total Earn for captain
ROLE_CAPTAIN

```
/totalEarn
methods: GET
```
#### Update AcceptedOrder
ROLE_CAPTAIN

```
/acceptedOrder
methods: PUT
```

### Rating
#### Create Rating
ROLE_OWNER

```
/rating
methods: POST
```




### dashboard

### user

### User profile update by admin

status : active .

```
/userProfileUpdateByAdmin
methods: PUT
```

### Get user profile by ID

```
/userprofileByID/{id}
methods: GET
```

### get captain profile by captainProfileId

```
/captainprofile/{captainProfileId}
methods: GET
```

### get owner or captain pending (inactive)

userType = owner or captain.

```
/getUserInactive/{userType}
methods: GET
```

### Get captains state

state = ongoing or vacation or free
```
/getCaptainsState/{state}
methods: GET
```

### dashboard Captains

```
/dashboardCaptains
methods: GET
```

### Get day of captains

```
/getDayOfCaptains
methods: GET
```

### total bounce captain

```
/totalBounceCaptain/{captainProfileId}
methods: GET
```

### Package

### Package create 

```
/package
methods: POST
```

### Get all packages 

```
/getAllpackages
methods: GET
```

### Get package by Id

```
/getpackageById/{id}
methods: GET
```

### Package update

```
/package
methods: PUT
```

### Package update

```
/package
methods: PUT
```


### Order

### Dashboard orders 

```
/dashboardOrders
methods: GET
```

### Dashboard contracts 

```
/dashboardContracts
methods: GET
```

### Get subscriptions pending 

```
/getSubscriptionsPending
methods: GET
```

### Subscription update

status = active or inactive.

```
/SubscriptionUpdateState
methods: PUT
```






