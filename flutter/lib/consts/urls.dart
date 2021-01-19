class Urls {
  static const String DOMAIN = 'http://34.121.141.34';
  static const String BASE_API = DOMAIN + '/html/public';
  static const String IMAGES_ROOT = DOMAIN + '/upload';

  static const API_SIGN_UP = BASE_API + '/user';
  static const PROFILE = BASE_API + '/userprofile';
  static const BRANCH = BASE_API + '/branches';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const LOG_API = BASE_API + '/getRecords';

  static const CREATE_CAPTAIN_ACCOUNT = BASE_API + '/captainprofile';

  static const NEARBY_ORDERS = BASE_API + '/closestOrders';
  static const OWNER_ORDERS = BASE_API + '/orders/';
  static const CAPTAIN_ACCEPTED_ORDERS = BASE_API + '/getAcceptedOrder/';
  static const NEW_ORDER = BASE_API + '/order';
  static const CAPTAIN_ORDER_UPDATE_API = BASE_API + '/orderUpdateState';
  static const ACCEPT_ORDER = BASE_API + '/acceptedOrder';
  static const ORDER_STATUS = BASE_API + '/orderStatus/';
  static const ORDER_STATUS_FOR_CAPTAIN =
      BASE_API + '/getOrderStatusForCaptain/';

  static const UPDATE_CAPTAIN_ORDER_API = '/orderUpdateState';
  static const API_UPLOAD = BASE_API + '/upload';

  static const PACKAGES = BASE_API + '/packages';
  static const SUBSCRIPTION = BASE_API + '/subscription';
}
