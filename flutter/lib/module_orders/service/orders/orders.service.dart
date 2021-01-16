import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_details/order_details_response.dart';
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

  Future<List<OrderModel>> getMyOrders() async {
    List<Order> response = await _manager.getMyOrders();
    if (response == null) return null;

    List<OrderModel> orders = [];
    var df = new DateFormat('hh:mm');

    response.forEach((element) {
      var date = new DateTime.fromMillisecondsSinceEpoch(
          element.date.timestamp * 1000);
      orders.add(new OrderModel(
        to: element.destination.isNotEmpty
            ? element.destination.elementAt(0)
            : '',
        clientPhone: element.recipientPhone,
        from: element.source.isNotEmpty ? element.source.elementAt(0) : '',
        creationTime: DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
        paymentMethod: element.payment,
        id: element.id,
      ));
    });

    return orders;
  }

  Future<OrderModel> getOrderDetails(int orderId) async {
    OrderStatusResponse response =
        await _manager.getOrderDetails(orderId);
    if (response == null) return null;

    var date =
        DateTime.fromMillisecondsSinceEpoch(response.date.timestamp * 1000);

    OrderModel order = new OrderModel(
      paymentMethod: response.payment,
      from: response.source[0],
      to: response.destination[0],
      creationTime: date,
      id: orderId,
    );

    return order;
  }

  Future<List<OrderModel>> getNearbyOrders() async {
    List<Order> response = await _manager.getNearbyOrders();
    if (response == null) return null;

    List<OrderModel> orders = [];
    var df = new DateFormat('hh:m');

    response.forEach((element) {
      var date = new DateTime.fromMillisecondsSinceEpoch(
          element.date.timestamp * 1000);
      orders.add(new OrderModel(
        to: element.destination.isNotEmpty
            ? element.destination.elementAt(0)
            : '',
        from: element.source.isNotEmpty ? element.source.elementAt(0) : '',
        creationTime: DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
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
      String date) async {
    var orderRequest = new CreateOrderRequest(
      note: note,
      date: date,
      payment: paymentMethod,
      fromBranch: fromBranch,
      recipientName: recipientName,
      recipientPhone: recipientPhone,
      destination: [destination],
    );
    return _manager.addNewOrder(orderRequest);
  }

  Future<OrderDetailsResponse> updateOrder(int orderId, OrderModel order) {
    return _manager.updateOrder(
        orderId,
        CreateOrderRequest(
          fromBranch: order.from,
          destination: [order.to],
          note: ' ',
          payment: order.paymentMethod,
          recipientPhone: order.clientPhone,
        ));
  }
}
