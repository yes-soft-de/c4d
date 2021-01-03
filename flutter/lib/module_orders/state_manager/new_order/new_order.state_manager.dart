
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/service/new_order/new_order.service.dart';
import 'package:c4d/module_orders/state/new_order/new_order.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class NewOrderStateManager{
  final NewOrderService _service;
  final PublishSubject<NewOrderState> _stateSubject = new PublishSubject();
  Stream<NewOrderState> get stateStream  => _stateSubject.stream;

  NewOrderStateManager(
      this._service,
      );

  void addNewOrder(
      String fromBranch,
      String destination,
      String note,
      String paymentMethod,
      String recipientName,
      String recipientPhone,
      String date,
      ){
    _service.addNewOrder(fromBranch, destination, note, paymentMethod, recipientName, recipientPhone, date).then((value) {
      if(value){
        _stateSubject.add(NewOrderStateSuccessState());
      }
      else{
        Fluttertoast.showToast(msg: S.current.errorHappened);
        _stateSubject.add(NewOrderStateErrorState());
      }
    });
  }

}