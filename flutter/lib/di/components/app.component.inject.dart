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
import '../../module_authorization/service/auth_service/auth_service.dart'
    as _i12;
import '../../module_authorization/presistance/auth_prefs_helper.dart' as _i13;
import '../../module_authorization/manager/auth/auth_manager.dart' as _i14;
import '../../module_authorization/repository/auth/auth_repository.dart'
    as _i15;
import '../../module_orders/ui/screens/order_status_for_captain/order_status_for_captain_screen.dart'
    as _i16;
import '../../module_orders/ui/screens/new_order/new_order_screen.dart' as _i17;
import '../../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i18;
import '../../module_orders/service/new_order/new_order.service.dart' as _i19;
import '../../module_orders/manager/new_order/new_order.manager.dart' as _i20;
import '../../module_orders/repository/new_order/new_order.repository.dart'
    as _i21;
import '../../module_orders/ui/screens/owner_orders/owner_orders_screen.dart'
    as _i22;
import '../../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i23;
import '../../module_orders/service/owner_orders/owner_orders.service.dart'
    as _i24;
import '../../module_orders/manager/owner_orders/owner_orders.manager.dart'
    as _i25;
import '../../module_orders/repository/owner_orders/owner_orders.repository.dart'
    as _i26;
import '../../module_orders/ui/screens/orders/orders_screen.dart' as _i27;
import '../../module_orders/state_manager/orders/orders.state_manager.dart'
    as _i28;
import '../../module_orders/service/orders/orders.service.dart' as _i29;
import '../../module_orders/manager/orders/orders.manager.dart' as _i30;
import '../../module_orders/repository/orders/orders.repository.dart' as _i31;
import '../../module_orders/ui/screens/map/map_screen.dart' as _i32;
import '../../module_authorization/authoriazation_module.dart' as _i33;
import '../../module_authorization/ui/screen/login_screen/login_screen.dart'
    as _i34;
import '../../module_authorization/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i35;
import '../../module_init/init_account_module.dart' as _i36;
import '../../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i37;
import '../../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i38;
import '../../module_init/service/init_account/init_account.service.dart'
    as _i39;
import '../../module_init/manager/init_account/init_account.manager.dart'
    as _i40;
import '../../module_init/repository/init_account/init_account.repository.dart'
    as _i41;
import '../../module_profile/service/profile/profile.service.dart' as _i42;
import '../../module_profile/manager/profile/profile.manager.dart' as _i43;
import '../../module_profile/repository/profile/profile.repository.dart'
    as _i44;

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
      _i10.OrderStatusRepository(_createApiClient(), _createAuthService());
  _i11.ApiClient _createApiClient() => _i11.ApiClient(_createLogger());
  _i2.Logger _createLogger() => _singletonLogger ??= _i2.Logger();
  _i12.AuthService _createAuthService() =>
      _i12.AuthService(_createAuthPrefsHelper(), _createAuthManager());
  _i13.AuthPrefsHelper _createAuthPrefsHelper() => _i13.AuthPrefsHelper();
  _i14.AuthManager _createAuthManager() =>
      _i14.AuthManager(_createAuthRepository());
  _i15.AuthRepository _createAuthRepository() =>
      _i15.AuthRepository(_createApiClient());
  _i16.OrderStatusForCaptainScreen _createOrderStatusForCaptainScreen() =>
      _i16.OrderStatusForCaptainScreen();
  _i17.NewOrderScreen _createNewOrderScreen() =>
      _i17.NewOrderScreen(_createNewOrderStateManager());
  _i18.NewOrderStateManager _createNewOrderStateManager() =>
      _i18.NewOrderStateManager(_createNewOrderService());
  _i19.NewOrderService _createNewOrderService() =>
      _i19.NewOrderService(_createNewOrderManager());
  _i20.NewOrderManager _createNewOrderManager() =>
      _i20.NewOrderManager(_createNewOrderRepository());
  _i21.NewOrderRepository _createNewOrderRepository() =>
      _i21.NewOrderRepository(_createApiClient(), _createAuthService());
  _i22.OwnerOrdersScreen _createOwnerOrdersScreen() =>
      _i22.OwnerOrdersScreen(_createOwnerOrdersStateManager());
  _i23.OwnerOrdersStateManager _createOwnerOrdersStateManager() =>
      _i23.OwnerOrdersStateManager(_createOwnerOrdersService());
  _i24.OwnerOrdersService _createOwnerOrdersService() =>
      _i24.OwnerOrdersService(_createOwnerOrdersManager());
  _i25.OwnerOrdersManager _createOwnerOrdersManager() =>
      _i25.OwnerOrdersManager(_createOwnerOrdersRepository());
  _i26.OwnerOrdersRepository _createOwnerOrdersRepository() =>
      _i26.OwnerOrdersRepository(_createApiClient(), _createAuthService());
  _i27.OrdersScreen _createOrdersScreen() =>
      _i27.OrdersScreen(_createOrdersStateManager());
  _i28.OrdersStateManager _createOrdersStateManager() =>
      _i28.OrdersStateManager(_createOrdersService());
  _i29.OrdersService _createOrdersService() =>
      _i29.OrdersService(_createOrdersManager());
  _i30.OrdersManager _createOrdersManager() =>
      _i30.OrdersManager(_createOrdersRepository());
  _i31.OrdersRepository _createOrdersRepository() =>
      _i31.OrdersRepository(_createApiClient(), _createAuthService());
  _i32.MapScreen _createMapScreen() => _i32.MapScreen();
  _i33.AuthorizationModule _createAuthorizationModule() =>
      _i33.AuthorizationModule(_createLoginScreen());
  _i34.LoginScreen _createLoginScreen() =>
      _i34.LoginScreen(_createAuthStateManager());
  _i35.AuthStateManager _createAuthStateManager() =>
      _i35.AuthStateManager(_createAuthService());
  _i36.InitAccountModule _createInitAccountModule() =>
      _i36.InitAccountModule(_createInitAccountScreen());
  _i37.InitAccountScreen _createInitAccountScreen() =>
      _i37.InitAccountScreen(_createInitAccountStateManager());
  _i38.InitAccountStateManager _createInitAccountStateManager() =>
      _i38.InitAccountStateManager(
          _createInitAccountService(), _createProfileService());
  _i39.InitAccountService _createInitAccountService() =>
      _i39.InitAccountService(_createInitAccountManager());
  _i40.InitAccountManager _createInitAccountManager() =>
      _i40.InitAccountManager(_createInitAccountRepository());
  _i41.InitAccountRepository _createInitAccountRepository() =>
      _i41.InitAccountRepository(_createApiClient(), _createAuthService());
  _i42.ProfileService _createProfileService() =>
      _i42.ProfileService(_createProfileManager());
  _i43.ProfileManager _createProfileManager() =>
      _i43.ProfileManager(_createProfileRepository());
  _i44.ProfileRepository _createProfileRepository() =>
      _i44.ProfileRepository(_createApiClient(), _createAuthService());
  @override
  _i4.MyApp get app => _createMyApp();
}
