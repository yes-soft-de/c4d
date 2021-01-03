export class AdminConfig {
  // An Example | Delete The Content When Started
  // source api
  public static sourceAPI                   = 'http://34.121.141.34//html/public/index.php/';
  // public static sourceAPI                   = 'http://localhost:8000/';

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
  public static captainSalaryBounceAPI      = AdminConfig.sourceAPI + 'captainprofileUpdateByAdmin';
  
  // Orders
  public static pendingOrdersAPI            = AdminConfig.sourceAPI + 'getPendingOrders';
  public static orderDetailsAPI             = AdminConfig.sourceAPI + 'order';

  // Contracts
  public static pendingContractsAPI         = AdminConfig.sourceAPI + 'getSubscriptionsPending';
  public static contractDetailsAPI          = AdminConfig.sourceAPI + 'getSubscriptionById';
  public static contractAcceptAPI           = AdminConfig.sourceAPI + 'subscriptionUpdateState';

  // Packages
  public static allpackagesAPI              = AdminConfig.sourceAPI + 'getAllpackages';
  public static packageDetailsAPI           = AdminConfig.sourceAPI + 'getpackageById';
  public static createPackageAPI            = AdminConfig.sourceAPI + 'package';
  public static packageAcceptAPI            = AdminConfig.sourceAPI + 'package';

  // Upload     
  public static generalUploadAPI            = AdminConfig.sourceAPI + 'uploadfile'; 
}
