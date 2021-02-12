class Urls {
  static const String DOMAIN = 'http://c4d.yes-cloud.de';
  static const String BASE_API = DOMAIN + '/html/public';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';

  static const SIGN_UP_API = BASE_API + '/user';
  static const OWNER_PROFILE_API = BASE_API + '/userprofile';
  static const CAPTAIN_PROFILE_API = BASE_API + '/captainprofile';
  static const CREATE_BANK_ACCOUNT_API = BASE_API + '/captainprofile';
  static const BRANCHES_API = BASE_API + '/branches';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const LOG_API = BASE_API + '/getRecords';

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

  static const APPOINTMENT_API = BASE_API + '/dating';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
}
