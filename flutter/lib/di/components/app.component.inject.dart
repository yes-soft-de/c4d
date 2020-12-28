import 'app.component.dart' as _i1;
import '../../utils/logger/logger.dart' as _i2;
import 'dart:async' as _i3;
import '../../main.dart' as _i4;
import '../../module_orders/orders_module.dart' as _i5;
import '../../module_orders/ui/screens/order_status_for_owner/order_status_for_owner.dart'
    as _i6;
import '../../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i7;
import '../../module_orders/service/order_status/order_status.service.dart'
    as _i8;
import '../../module_orders/manager/order_status/order_status.manager.dart'
    as _i9;
import '../../module_orders/repository/order_status/order_status.repository.dart'
    as _i10;
import '../../module_network/http_client/http_client.dart' as _i11;
import '../../module_orders/ui/screens/order_status_for_captain/order_status_for_captain_screen.dart'
    as _i12;
import '../../module_orders/ui/screens/new_order/new_order_screen.dart' as _i13;
import '../../module_orders/ui/screens/owner_orders/owner_orders_screen.dart'
    as _i14;
import '../../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i15;
import '../../module_orders/service/owner_orders/owner_orders.service.dart'
    as _i16;
import '../../module_orders/manager/owner_orders/owner_orders.manager.dart'
    as _i17;
import '../../module_orders/repository/owner_orders/owner_orders.repository.dart'
    as _i18;
import '../../module_orders/ui/screens/orders/orders_screen.dart' as _i19;
import '../../module_orders/state_manager/orders/orders.state_manager.dart'
    as _i20;
import '../../module_orders/service/orders/orders.service.dart' as _i21;
import '../../module_orders/manager/orders/orders.manager.dart' as _i22;
import '../../module_orders/repository/orders/orders.repository.dart' as _i23;
import '../../module_orders/ui/screens/map/map_screen.dart' as _i24;
import '../../module_authorization/authoriazation_module.dart' as _i25;
import '../../module_authorization/ui/screen/login_screen/login_screen.dart'
    as _i26;
import '../../module_init/init_account_module.dart' as _i27;
import '../../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i28;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.Logger _singletonLogger;

  static _i3.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp(_createOrdersModule(),
      _createAuthorizationModule(), _createInitAccountModule());
  _i5.OrdersModule _createOrdersModule() => _i5.OrdersModule(
      _createOrderStatusForOwnerScreen(),
      _createOrderStatusForCaptainScreen(),
      _createNewOrderScreen(),
      _createOwnerOrdersScreen(),
      _createOrdersScreen(),
      _createMapScreen());
  _i6.OrderStatusForOwnerScreen _createOrderStatusForOwnerScreen() =>
      _i6.OrderStatusForOwnerScreen(_createOrderStatusStateManager());
  _i7.OrderStatusStateManager _createOrderStatusStateManager() =>
      _i7.OrderStatusStateManager(_createOrderStatusService());
  _i8.OrderStatusService _createOrderStatusService() =>
      _i8.OrderStatusService(_createOrderStatusManager());
  _i9.OrderStatusManager _createOrderStatusManager() =>
      _i9.OrderStatusManager(_createOrderStatusRepository());
  _i10.OrderStatusRepository _createOrderStatusRepository() =>
      _i10.OrderStatusRepository(_createApiClient());
  _i11.ApiClient _createApiClient() => _i11.ApiClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i12.OrderStatusForCaptainScreen _createOrderStatusForCaptainScreen() =>
      _i12.OrderStatusForCaptainScreen();
  _i13.NewOrderScreen _createNewOrderScreen() => _i13.NewOrderScreen();
  _i14.OwnerOrdersScreen _createOwnerOrdersScreen() =>
      _i14.OwnerOrdersScreen(_createOwnerOrdersStateManager());
  _i15.OwnerOrdersStateManager _createOwnerOrdersStateManager() =>
      _i15.OwnerOrdersStateManager(_createOwnerOrdersService());
  _i16.OwnerOrdersService _createOwnerOrdersService() =>
      _i16.OwnerOrdersService(_createOwnerOrdersManager());
  _i17.OwnerOrdersManager _createOwnerOrdersManager() =>
      _i17.OwnerOrdersManager(_createOwnerOrdersRepository());
  _i18.OwnerOrdersRepository _createOwnerOrdersRepository() =>
      _i18.OwnerOrdersRepository(_createApiClient());
  _i19.OrdersScreen _createOrdersScreen() =>
      _i19.OrdersScreen(_createOrdersStateManager());
  _i20.OrdersStateManager _createOrdersStateManager() =>
      _i20.OrdersStateManager(_createOrdersService());
  _i21.OrdersService _createOrdersService() =>
      _i21.OrdersService(_createOrdersManager());
  _i22.OrdersManager _createOrdersManager() =>
      _i22.OrdersManager(_createOrdersRepository());
  _i23.OrdersRepository _createOrdersRepository() =>
      _i23.OrdersRepository(_createApiClient());
  _i24.MapScreen _createMapScreen() => _i24.MapScreen();
  _i25.AuthorizationModule _createAuthorizationModule() =>
      _i25.AuthorizationModule(_createLoginScreen());
  _i26.LoginScreen _createLoginScreen() => _i26.LoginScreen();
  _i27.InitAccountModule _createInitAccountModule() =>
      _i27.InitAccountModule(_createInitAccountScreen());
  _i28.InitAccountScreen _createInitAccountScreen() => _i28.InitAccountScreen();
  @override
  _i4.MyApp get app => _createMyApp();
}
