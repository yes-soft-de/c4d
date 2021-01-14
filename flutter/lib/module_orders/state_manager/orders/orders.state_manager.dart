import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders/orders_screen.dart';
import 'package:c4d/module_orders/ui/state/orders/orders.state.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class OrdersStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;
  final PublishSubject<OrdersListState> _stateSubject = PublishSubject();

  Stream<OrdersListState> get stateStream => _stateSubject.stream;

  OrdersStateManager(
    this._ordersService,
    this._authService,
  );

  void getMyOrders(OrdersScreenState screenState) {
    _authService.isLoggedIn.then((value) {
      if (value) {
        _stateSubject.add(OrdersListStateLoading(screenState));
        _ordersService.getNearbyOrders();
        _ordersService.getMyOrders().then((value) {
          if (value == null) {
            _stateSubject
                .add(OrdersListStateError('Error Finding Data', screenState));
          } else {
            _stateSubject.add(OrdersListStateOrdersLoaded(value, screenState));
          }
        });
      } else {
        _stateSubject.add(OrdersListStateUnauthorized(screenState));
      }
    });
  }
}
