import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class CaptainOrdersListStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;
  final PublishSubject<CaptainOrdersListState> _stateSubject = PublishSubject();

  Stream<CaptainOrdersListState> get stateStream => _stateSubject.stream;

  CaptainOrdersListStateManager(
    this._ordersService,
    this._authService,
  );

  void getMyOrders(CaptainOrdersScreenState screenState) {
    _authService.isLoggedIn.then((value) {
      if (value) {
        _stateSubject.add(CaptainOrdersListStateUnauthorized(screenState));
        _ordersService.getNearbyOrders().then((value) {
          if (value == null) {
            _stateSubject
                .add(CaptainOrdersListStateError('Error Finding Data', screenState));
          } else {
            _stateSubject.add(CaptainOrdersListStateOrdersLoaded(value, screenState));
          }
        });
      } else {
        _stateSubject.add(CaptainOrdersListStateUnauthorized(screenState));
      }
    });
  }
}
