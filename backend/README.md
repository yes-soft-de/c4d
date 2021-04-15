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

Then, create database
```
php bin/console doctrine:database:create
```

After that make migration
```
php bin/console make:migration
```

Finally, run migration versions to create tables
```
php bin/console doctrine:migration:migrate
```

#### API guide
* [Account](#account)
* [Login](#login)
* [Package](#package)
* [Order](#orde)


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

#### Create captain profile 
```
/captainprofile
methods: POST
```
#### Update captain profile 

isOnline: active or inactive .

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
#### Get Captain My Balance 

ROLE_CAPTAIN
```
/captainmybalance
methods: GET
```

### Package

#### get Packages User Compatible
ROLE_OWNER
```
/packages
methods: GET
```

#### get package By Id

```
/getpackageById/id
methods: GET
```

### Subscription
#### Create Subscription
ROLE_OWNER

```
/package
methods: POST
```

#### Get All Subscriptions for owner
ROLE_OWNER

```
/getSubscriptionForOwner
methods: GET
```

#### Get package balance
ROLE_OWNER

```
/packagebalance
methods: GET
```

#### Pay the next payment
ROLE_OWNER

```
/nextsubscription
methods: POST
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

ROLE_OWNER

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

<!-- state: picked or ongoing or deliverd . -->
<!-- next was  adopted -->
state: in store or picked or ongoing or cash or deliverd
kilometer: number of integer

```
/orderUpdateState
methods: PUT
```

#### Delete Order
ROLE_OWNER

```
/order/id
methods: DELETE
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
/getOrderStatusForCaptain/orderId
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

### Bank Account

#### Create bank account
ROLE_OWNER

```
/bankaccount
methods: POST
```

#### Update bank account
ROLE_OWNER

```
/bankaccount
methods: PUT
```

#### Get bank account by userId
ROLE_OWNER

```
/bankaccountbyuserid
methods: GET
```

### report

#### Create report
ROLE_OWNER

```
/report
methods: POST
```
#### Get By id
/report/{id}
methods: GET
```

### Dating

#### Get reports
ROLE_OWNER
```
/dating
methods: POST
```

### Branch

#### create branches
ROLE_OWNER
```
/branches
methods: POST
```

#### update branches
ROLE_OWNER
```
/branches
methods: PUT
```

#### Get branches by UserId
ROLE_OWNER
```
/branches
methods: GET
```

#### Update IsActive branche
ROLE_OWNER
```
/branche
methods: PUT
```

### Payments

#### Get payments
ROLE_OWNER
```
/payments
methods: GET
```

### CompanyInfo

#### GET companyinfo all

```
/companyinfoall
methods: GET
```

### Update

#### GET Update ById

```
update/{id}
methods: GET
```
#### GET Update All

```
updateall
methods: GET
```

### TermsCaptain

#### Get TermsCaptain 

```
/termscaptain
methods: GET
```

#### Get TermsCaptain By Id

```
/termscaptainbyid/{id}
methods: GET
```

### notification

#### Notificationtoken

must run it during start app
send firebase token  
```
/notificationtoken
methods: POST
```

#### Notification New Chat 

send roomID 
```
/notificationnewchat
methods: POST
```

#### Notification Message From Captain Or Reprot To Admin

send roomID 
```
/notificationtoadmin
methods: POST
```





# dashboard 


### dashboard

### user

### User profile update by admin

status : active .

```
/userProfileUpdateByAdmin
methods: PUT
```

### Get user profile by userId

```
/userprofilebyuserid/{userId}
methods: GET
```

### captain profile Update By Admin


```
/captainprofileUpdateByAdmin
methods: PUT
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

state = ongoing or deliverd
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
### The Remaining Captain Has A Boost

```
/remainingcaptain
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

status :  active or inactive .
```
/package
methods: PUT
```

### Order

#### Get Order By ID

```
/order/orderId
methods: GET
```

#### Count All Orders

```
/countAllOrders
methods: GET
```

#### Get (All Orders And Count ) in mounth by ownerId


```
/getAllOrdersAndCount/{year}/{month}/{ownerId}
methods: GET
```

#### Get top owners in this month and count orders for owner in day


```
/getTopOwners
methods: GET
```


### Dashboard orders 

```
/dashboardOrders
methods: GET
```

### Dashboard contracts 

```
/dashboardContracts/{year}/{month}
methods: GET
```

### Get subscriptions pending 

```
/getSubscriptionsPending
methods: GET
```


#### Get subscription by Id

```
/getSubscriptionById/id
methods: GET
```

### Subscription update

status = active or inactive.

```
/subscriptionUpdateState
methods: PUT
```
### Records for Admin

## get orders
```
/getOrders
methods: GET
```
## get users (owners OR captains)

userType = owner OR captain .

```
/getUsers/userType
methods: GET
```

## get Records By OrderId

```
/records/orderId
methods: GET
```

### Bank Account

#### Get bank account by userId for admin

```
/bankaccount/{userID}
methods: GET
```

#### Get bank accounts for admin

```
/bankaccounts
methods: GET
```
### Accepted Order

#### Get top captains in this month

```
/topCaptains
methods: GET
```

### report

#### Get reports
```
/reports
methods: GET
```

#### Update Report NewMeessageStatus

Turn it on when you click chat
```
/reportupdatenewmessagestatus/{id}
methods: PUT
```

### Dating

#### Get datings
```
/datings
methods: GET
```

#### Update dating isDone

isDone = false or true .
```
/dating
methods: PUT
```


### Payments

#### Get payments

```
/payment
methods: POST
```

### CompanyInfo

#### Create CompanyInfo

```
/companyinfo
methods: POST
```

#### Update CompanyInfo

```
/companyinfo
methods: PUT
```

#### GET companyinfo all

```
/companyinfoall
methods: GET
```

### Update

#### Create Update 

```
/update
methods: POST
```

#### Update update

```
/update/{id}
methods: PUT
```

### Vacation

#### Creeate vacation 

state = vacation  OR work
```
/vacation
methods: POST
```

### TermsCaptain

#### Create TermsCaptain 

```
/termscaptain
methods: POST
```

#### Update TermsCaptain 

```
/termscaptain
methods: PUT
```


### notification

#### Notificationtoken

#### Notification To Report From Admin 
```
send roomID 

/notificationtoreportfromadmin
methods: POST
```

#### Notification To Captain From Admin 
```
send roomID 

/notificationtocaptainfromadmin
methods: POST
```

### How send notification from Admin

from all captains page 

1- on click talk with captain

```
/captainupdatenewmessagestatus

methods: PUT

request:
{
    "roomID":" "
}
```

2- on click send from chat

```

/notificationtocaptainfromadmin
methods={"POST"}
request:
{
    "roomID":" "
}
```

from report page 

1- on click chat

```
/reportupdatenewmessagestatus/{id}

methods: PUT

```

2- on click send from chat

```

/notificationtoreportfromadmin
methods={"POST"}
request:
{
    "roomID":" "
}
```