import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_error.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_loading.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_unauthorized.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_orders_loaded.dart';
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
    Future.wait(
            [_ordersService.getNearbyOrders(), _ordersService.getCaptainOrders()])
        .then((value) {
      _stateSubject.add(
          CaptainOrdersListStateOrdersLoaded(screenState, value[0], value[1]));
    }).catchError((e) {
      if (e is UnauthorizedException) {
        _stateSubject.add(CaptainOrdersListStateUnauthorized(screenState));
      } else {
        _stateSubject
            .add(CaptainOrdersListStateError(e.toString(), screenState));
      }
    });
  }
}
