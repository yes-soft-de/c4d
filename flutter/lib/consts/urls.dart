class Urls {
  static const String DOMAIN = 'http://161.35.72.235';
  static const String BASE_API = DOMAIN + '';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';

  static const SIGN_UP_API = BASE_API + '/user';
  static const OWNER_PROFILE_API = BASE_API + '/userprofile';
  static const CAPTAIN_PROFILE_API = BASE_API + '/captainprofile';
  static const CREATE_BANK_ACCOUNT_API = BASE_API + '/captainprofile';
  static const BRANCHES_API = BASE_API + '/branches';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const LOG_API = BASE_API + '/getRecords';
  static const DELETE_ORDER = BASE_API + '/ordercancel/';

  static const REPORT_API = BASE_API + '/report';

  static const NEARBY_ORDERS_API = BASE_API + '/closestOrders';
  static const OWNER_ORDERS_API = BASE_API + '/orders/';
  static const CAPTAIN_ACCEPTED_ORDERS_API = BASE_API + '/getAcceptedOrder/';
  static const NEW_ORDER_API = BASE_API + '/order';
  static const CAPTAIN_ORDER_UPDATE_API = BASE_API + '/orderUpdateState';
  static const ACCEPT_ORDER_API = BASE_API + '/acceptedOrder';
  static const ORDER_STATUS_API = BASE_API + '/orderStatus/';
  static const ORDER_STATUS_FOR_CAPTAIN_API =
      BASE_API + '/getOrderStatusForCaptain/';

  static const UPDATE_CAPTAIN_ORDER_API = '/orderUpdateState';
  static const UPLOAD_API = BASE_API + '/uploadfile';

  static const PACKAGES_API = BASE_API + '/packages';
  static const SUBSCRIPTION_API = BASE_API + '/subscription';
  static const RENEW_SUBSCRIPTION_API = BASE_API + '/nextsubscription';

  static const APPOINTMENT_API = BASE_API + '/dating';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
  static const COMPANYINFO_API = BASE_API + '/companyinfoforuser';
  static const UPDATES_API = BASE_API + '/updateall';
  static const ORDER_BY_ID = BASE_API + '/orderStatus/';
  static const TERMS_CAPTAIN = BASE_API + '/termscaptain';
  static const TERMS_OWNER = BASE_API + '/';
  static const NOTIFICATIONNEWCHAT_API = BASE_API + '/notificationnewchat';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const CAPTAIN_ACTIVE_STATUS_API = BASE_API + '/captainisactive';
  static const UPDATE_BRANCH_API = BASE_API + '/branches';
  static const GET_CAPTAIN_BALANCE_DETAILS =
      BASE_API + '/getCaptainBalanceDetails';
  static const SEND_TO_RECORD = BASE_API + '/record';
  static const PACKAGE_BALANCE = BASE_API + '/packagebalance';
  static const PAYMENT = BASE_API + '/payments';
  static const GET_CAPTAIN_BALANCE = BASE_API + '/captainmybalance';
}
