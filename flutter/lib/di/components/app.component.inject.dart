import 'app.component.dart' as _i1;
import 'dart:async' as _i2;
import '../../main.dart' as _i3;
import '../../module_orders/orders_module.dart' as _i4;
import '../../module_orders/ui/screens/order_status_for_owner/order_status_for_owner.dart'
    as _i5;
import '../../module_orders/ui/screens/order_status_for_captain/order_status_for_captain_screen.dart'
    as _i6;
import '../../module_orders/ui/screens/new_order/new_order_screen.dart' as _i7;
import '../../module_orders/ui/screens/owner_orders/owner_orders_screen.dart'
    as _i8;
import '../../module_orders/ui/screens/orders/orders_screen.dart' as _i9;
import '../../module_orders/ui/screens/map/map_screen.dart' as _i10;
import '../../module_authorization/authoriazation_module.dart' as _i11;
import '../../module_authorization/ui/screen/login_screen/login_screen.dart'
    as _i12;
import '../../module_init/init_account_module.dart' as _i13;
import '../../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i14;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  static _i2.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i3.MyApp _createMyApp() => _i3.MyApp(_createOrdersModule(),
      _createAuthorizationModule(), _createInitAccountModule());
  _i4.OrdersModule _createOrdersModule() => _i4.OrdersModule(
      _createOrderStatusForOwnerScreen(),
      _createOrderStatusForCaptainScreen(),
      _createNewOrderScreen(),
      _createOwnerOrdersScreen(),
      _createOrdersScreen(),
      _createMapScreen());
  _i5.OrderStatusForOwnerScreen _createOrderStatusForOwnerScreen() =>
      _i5.OrderStatusForOwnerScreen();
  _i6.OrderStatusForCaptainScreen _createOrderStatusForCaptainScreen() =>
      _i6.OrderStatusForCaptainScreen();
  _i7.NewOrderScreen _createNewOrderScreen() => _i7.NewOrderScreen();
  _i8.OwnerOrdersScreen _createOwnerOrdersScreen() => _i8.OwnerOrdersScreen();
  _i9.OrdersScreen _createOrdersScreen() => _i9.OrdersScreen();
  _i10.MapScreen _createMapScreen() => _i10.MapScreen();
  _i11.AuthorizationModule _createAuthorizationModule() =>
      _i11.AuthorizationModule(_createLoginScreen());
  _i12.LoginScreen _createLoginScreen() => _i12.LoginScreen();
  _i13.InitAccountModule _createInitAccountModule() =>
      _i13.InitAccountModule(_createInitAccountScreen());
  _i14.InitAccountScreen _createInitAccountScreen() => _i14.InitAccountScreen();
  @override
  _i3.MyApp get app => _createMyApp();
}
