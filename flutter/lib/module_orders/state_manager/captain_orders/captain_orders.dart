import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class CaptainOrdersListStateManager {
  final OrdersService _ordersService;
  final PublishSubject<CaptainOrdersListState> _stateSubject = PublishSubject();

  Stream<CaptainOrdersListState> get stateStream => _stateSubject.stream;

  CaptainOrdersListStateManager(this._ordersService);

  void getMyOrders(CaptainOrdersScreenState screenState) {
    CaptainOrdersListStateLoading(screenState);
    _ordersService.getNearbyOrders().then((value) {
      _stateSubject.add(CaptainOrdersListStateOrdersLoaded(value, screenState));
    }).catchError((e) {
      if (e is UnauthorizedException) {
        _stateSubject.add(CaptainOrdersListStateUnauthorized(screenState));
      }else {
        _stateSubject.add(CaptainOrdersListStateError(e.toString(), screenState));
      }
    });
  }
}
