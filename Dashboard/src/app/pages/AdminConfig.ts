export class AdminConfig {
  // An Example | Delete The Content When Started
  // source api
  // public static sourceAPI                   = 'http://34.121.141.34/html/public/index.php/';
  public static sourceAPI                   = 'http://c4d.yes-cloud.de/html/public/index.php/';

  // All Application Api
  public static loginAPI                    = AdminConfig.sourceAPI + 'login_check';
  public static userAPI                     = AdminConfig.sourceAPI + 'user';

  // Dashboard
  public static captainsDashboardAPI        = AdminConfig.sourceAPI + 'dashboardCaptains';
  public static ordersDashboardAPI          = AdminConfig.sourceAPI + 'dashboardOrders';
  public static contractsDashboardAPI       = AdminConfig.sourceAPI + 'dashboardContracts';

  // Captains
  public static dayOffCaptainsAPI           = AdminConfig.sourceAPI + 'getDayOfCaptains';
  public static pendingCaptainsAPI          = AdminConfig.sourceAPI + 'getUserInactive';
  public static ongoingCaptainsAPI          = AdminConfig.sourceAPI + 'getCaptainsState';
  public static captainDetailAPI            = AdminConfig.sourceAPI + 'captainprofile';
  public static dayOffCaptainDetailAPI      = AdminConfig.sourceAPI + 'captainprofileStateDayOff';
  public static captainSalaryBounceAPI      = AdminConfig.sourceAPI + 'captainprofileUpdateByAdmin';
  public static captianPaymentAPI           = AdminConfig.sourceAPI + 'paymentcaptain';
  public static captianTotalBounceAPI       = AdminConfig.sourceAPI + 'totalBounceCaptain';
  public static remainingCaptainsAPI        = AdminConfig.sourceAPI + 'remainingcaptain';
  public static termsCaptainsAPI            = AdminConfig.sourceAPI + 'termscaptain';
  public static termsCaptainByIdAPI         = AdminConfig.sourceAPI + 'termscaptainbyid';
  public static giveDayOffAPI               = AdminConfig.sourceAPI + 'vacation';

  // Orders
  public static pendingOrdersAPI            = AdminConfig.sourceAPI + 'getPendingOrders';
  public static orderDetailsAPI             = AdminConfig.sourceAPI + 'order';

  // Contracts
  public static pendingContractsAPI         = AdminConfig.sourceAPI + 'getSubscriptionsPending';
  public static contractDetailsAPI          = AdminConfig.sourceAPI + 'getSubscriptionById';
  public static ownerDetailsAPI             = AdminConfig.sourceAPI + 'userprofilebyuserid';
  public static contractAcceptAPI           = AdminConfig.sourceAPI + 'subscriptionUpdateState';
  public static paymentAPI                  = AdminConfig.sourceAPI + 'payment';
  public static paymentOfOwnerAPI           = AdminConfig.sourceAPI + 'paymentsOfOwner';

  // Packages
  public static allpackagesAPI              = AdminConfig.sourceAPI + 'getAllpackages';
  public static packageDetailsAPI           = AdminConfig.sourceAPI + 'getpackageById';
  public static createPackageAPI            = AdminConfig.sourceAPI + 'package';
  public static packageAcceptAPI            = AdminConfig.sourceAPI + 'package';

  // Recordes
  public static ordersAPI                   = AdminConfig.sourceAPI + 'getOrders';
  public static ownersCaptainsAPI           = AdminConfig.sourceAPI + 'getUsers';
  public static recordsAPI                  = AdminConfig.sourceAPI + 'records';

  // Statics
  public static topOwnersAPI                = AdminConfig.sourceAPI + 'getTopOwners';
  public static topCaptainsAPI              = AdminConfig.sourceAPI + 'topCaptains';
  public static allUsersAPI                 = AdminConfig.sourceAPI + 'getAllUsers';
  public static statisticDetailsAPI         = AdminConfig.sourceAPI + 'getAllOrdersAndCount';

  // Reports
  public static reportsAPI                  = AdminConfig.sourceAPI + 'reports';

  // Datings
  public static datingsAPI                  = AdminConfig.sourceAPI + 'datings';
  public static datingAPI                   = AdminConfig.sourceAPI + 'dating';

  // Support Information
  public static getSupportInfoAPI           = AdminConfig.sourceAPI + 'companyinfoall';
  public static supportInfoAPI              = AdminConfig.sourceAPI + 'companyinfo';

  // Updated
  public static getUpdatesAPI               = AdminConfig.sourceAPI + 'updateall';
  public static updateAPI                   = AdminConfig.sourceAPI + 'update';


  // Upload
  public static generalUploadAPI            = AdminConfig.sourceAPI + 'uploadfile';
}
