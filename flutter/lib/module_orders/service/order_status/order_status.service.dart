

import 'package:c4d/module_orders/manager/order_status/order_status.manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';

@provide
class OrderStatusService{
  final OrderStatusManager _manager;

  OrderStatusService(
      this._manager,
      );

  Future<OrderModel> getOrderDetails(int oderId)async{
    OrderStatusResponse response = await _manager.getOrderDetails(oderId);
    if(response == null ) return null;
    var df = new DateFormat('hh:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(response.date.timestamp * 1000);

    OrderModel order = new OrderModel(
      paymentMethod: response.payment,
      from: response.source[0],
      to:  response.destination[0],
      creationTime: df.format(date).toString()??'',
      id: response.id,
    );

    return order;
  }
}