import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';

@provide
class OrdersService {
  final OrdersManager _manager;

  OrdersService(
    this._manager,
  );

  Future<List<OrderModel>> getNearbyOrders() async {
    OrdersResponse response = await _manager.getNearbyOrders();
    if (response == null) return null;

    List<OrderModel> orders = [];
    var df = new DateFormat('hh:mm');

    response.data.forEach((element) {
      var date = new DateTime.fromMillisecondsSinceEpoch(
          element.date.timestamp * 1000);
      orders.add(new OrderModel(
        to: element.destination.isNotEmpty
            ? element.destination.elementAt(0)
            : '',
        from: element.source.isNotEmpty ? element.source.elementAt(0) : '',
        creationTime: df.format(date).toString() ?? '',
        paymentMethod: element.payment,
        id: element.id,
      ));
    });

    return orders;
  }

  Future<OrderModel> getOrderDetails(int oderId) async {
    OrderStatusResponse response = await _manager.getOrderDetails(oderId);
    if (response == null) return null;
    var df = new DateFormat('hh:mm');
    var date =
        new DateTime.fromMillisecondsSinceEpoch(response.date.timestamp * 1000);

    OrderModel order = new OrderModel(
      paymentMethod: response.payment,
      from: response.source[0],
      to: response.destination[0],
      creationTime: df.format(date).toString() ?? '',
      id: response.id,
    );

    return order;
  }

  Future<List<OrderModel>> getNearByOrders() async {
    OrdersResponse response = await _manager.getNearbyOrders();
    if (response == null) return null;

    List<OrderModel> orders = [];
    var df = new DateFormat('hh:mm');

    response.data.forEach((element) {
      var date = new DateTime.fromMillisecondsSinceEpoch(
          element.date.timestamp * 1000);
      orders.add(new OrderModel(
        to: element.destination.isNotEmpty
            ? element.destination.elementAt(0)
            : '',
        from: element.source.isNotEmpty ? element.source.elementAt(0) : '',
        creationTime: df.format(date).toString() ?? '',
        paymentMethod: element.payment,
        id: element.id,
      ));
    });

    return orders;
  }

  Future<bool> addNewOrder(
    String fromBranch,
    String destination,
    String note,
    String paymentMethod,
    String recipientName,
    String recipientPhone,
    String date,
  ) async {
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
