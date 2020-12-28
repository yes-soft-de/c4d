class Urls {
  static const String DOMAIN = 'http://34.121.141.34';
  static const String BASE_API = DOMAIN + '/html/public/index.php';

  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const CREATE_CAPTAIN_ACCOUNT = BASE_API + '/captainprofile';
  static const NEARBY_ORDERS = BASE_API + '/closestOrders';
  static const OWNER_ORDERS = BASE_API + '/orders/';
  static const ORDER_STATUS = BASE_API + '/orderById/';

}
