export class AdminConfig {
  // An Example | Delete The Content When Started
  // source api
  public static sourceAPI                   = 'http://localhost:8000/';

  // All Application Api
  public static loginAPI                    = AdminConfig.sourceAPI + 'login_check';
  public static userAPI                     = AdminConfig.sourceAPI + 'user';

  // Dashboard
  public static captainsDashboardAPI        = AdminConfig.sourceAPI + 'dashboardCaptains';
  public static ordersDashboardAPI          = AdminConfig.sourceAPI + 'dashboardOrders';
  public static contractsDashboardAPI       = AdminConfig.sourceAPI + 'dashboardContracts';
  public static captainDetailAPI            = AdminConfig.sourceAPI + 'captainprofile';

  // Captains
  public static dayOffCaptainsAPI           = AdminConfig.sourceAPI + 'getDayOfCaptains';
  public static pendingCaptainsAPI          = AdminConfig.sourceAPI + 'getUserInactive';
  public static ongoingCaptainsAPI          = AdminConfig.sourceAPI + 'getCaptainsState';

  // Orders
  public static pendingOrdersAPI            = AdminConfig.sourceAPI + 'getPendingOrders';
  public static orderDetailsAPI             = AdminConfig.sourceAPI + 'order';

  // Contracts
  public static pendingContractsAPI         = AdminConfig.sourceAPI + 'getSubscriptionsPending';
  public static contractDetailsAPI          = AdminConfig.sourceAPI + 'getSubscriptionById';
  public static contractAcceptAPI           = AdminConfig.sourceAPI + 'subscriptionUpdateState';
  
  // Upload     
  public static generalUploadAPI            = AdminConfig.sourceAPI + 'uploadfile'; 
}
