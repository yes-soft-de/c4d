

import 'package:c4d/module_orders/manager/orders/orders.manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';

@provide
class OrdersService{
  final OrdersManager _manager;

  OrdersService(
      this._manager,
      );

  Future<List<OrderModel>> getNearbyOrders()async {
    OrdersResponse response = await _manager.getNearbyOrders();
    if(response == null ) return null;

    List<OrderModel> orders = [];
    var df = new DateFormat('hh:mm');

    response.data.forEach((element) {
      var date = new DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000);
      orders.add(
        new OrderModel(
          to: element.destination.isNotEmpty? element.destination.elementAt(0): '',
          from: element.source.isNotEmpty? element.source.elementAt(0): '',
          creationTime: df.format(date).toString()??'',
          paymentMethod: element.payment,
          id: element.id,
        )
      );
    });

    return orders;
  }
}