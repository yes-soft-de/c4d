import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/state/orders/orders.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class OrdersStateManager {
  final OrdersService _ordersService;
  final PublishSubject<OrdersState> _stateSubject = PublishSubject();

  Stream<OrdersState> get stateStream => _stateSubject.stream;

  OrdersStateManager(
    this._ordersService,
  );

  void getNearbyOrders() {
    _stateSubject.add(OrdersFetchingDataState());

    _ordersService.getNearbyOrders().then((value) {
      if (value == null) {
        _stateSubject.add(OrdersFetchingDataSuccessState([]));
      } else {
        _stateSubject.add(OrdersFetchingDataSuccessState(value));
      }
    });
  }

  void getMyOrders() {
    _stateSubject.add(OrdersFetchingDataState());

    _ordersService.getMyOrders().then((value) {
      if (value == null) {
        _stateSubject.add(OrdersFetchingDataSuccessState([]));
      } else {
        _stateSubject.add(OrdersFetchingDataSuccessState(value));
      }
    });
  }
}
