import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_profile/ui/screen/order_info/order_info_screen.dart';
import 'package:c4d/module_profile/ui/states/order_details_state/order_details_state.dart';
import 'package:inject/inject.dart';

import 'package:rxdart/rxdart.dart';

@provide
class OrderInfoStateManager {
  final OrdersService _ordersService;
  OrderInfoStateManager(
    this._ordersService,
  );

  final _stateSubject = PublishSubject<OrderInfoState>();
  Stream<OrderInfoState> get stateStream => _stateSubject.stream;

  void getOrderdetails(OrderInfoScreenState state, orderId) {
    _stateSubject.add(OrderInfoStateLoading(state));
    _ordersService.getOrder(orderId).then((value) {
      _stateSubject.add(OrderInfoStateInit(state, value));
    });
  }
}
