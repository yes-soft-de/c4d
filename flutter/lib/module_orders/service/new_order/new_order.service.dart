import 'package:c4d/module_orders/manager/new_order/new_order.manager.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:inject/inject.dart';

@provide
class NewOrderService{
  final NewOrderManager _manager;

  NewOrderService(
      this._manager,
      );

  Future<bool> addNewOrder(
    String fromBranch,
    String destination,
    String note,
    String paymentMethod,
    String recipientName,
    String recipientPhone,
    String date,
      )async{

      OrderRequest orderRequest = new OrderRequest(
        note: note,
        paymentMethod: paymentMethod,
        date: date,
        destination: destination,
        fromBranch: fromBranch,
        recipientName: recipientName,
        recipientPhone: recipientPhone,
      );

      return await _manager.addNewOrder(orderRequest);
  }

}