import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/state/order_status/order_status.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class OrderStatusForCaptainStateManager {
  final OrdersService _service;
  final PublishSubject<dynamic> _stateSubject = new PublishSubject();

  Stream<dynamic> get stateStream => _stateSubject.stream;

  OrderStatusForCaptainStateManager(
    this._service,
  );

  void getOrderDetails(String orderId) {
    _stateSubject.add(OrderStatusFetchingDataState());

    _service.getOrderDetails(orderId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
        _stateSubject.add(OrderStatusFetchingDataErrorState());
      } else {
        _stateSubject.add(OrderStatusFetchingDataSuccessState(value));
      }
    });
  }
}
