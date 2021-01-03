
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/service/order_status_for_captain/order_status_for_captain.service.dart';
import 'package:c4d/module_orders/state/order_status_for_captain/order_status_for_captain.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class OrderStatusForCaptainStateManager{
  final OrderStatusForCaptainService _service;
  final PublishSubject<OrderStatusForCaptainState> _stateSubject = new PublishSubject();
  Stream<OrderStatusForCaptainState> get stateStream => _stateSubject.stream;

  OrderStatusForCaptainStateManager(
      this._service,
      );

  void getOrderDetails(int oderId) {
    _stateSubject.add(OrderStatusForCaptainFetchingDataState());

    _service.getOrderDetails(oderId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
        _stateSubject.add(OrderStatusForCaptainFetchingDataErrorState());
      }
      else {
        _stateSubject.add(OrderStatusForCaptainFetchingDataSuccessState(value));
      }
    });
  }
}