import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

@provide
class OrdersService {
  final OrdersManager _manager;

  OrdersService(
    this._manager,
  );

  Future<List<OrderModel>> getMyOrders() async {
    var ordersSnapshot = await FirebaseFirestore.instance
        .collection('c4d')
        .doc('data')
        .collection('orders')
        .get();

    print('Got ${ordersSnapshot.size} elements');
    List<OrderModel> ordersList = [];
    ordersSnapshot.docs.forEach((element) {
      var model = OrderModel.fromJson(element.data());
      model.id = element.id;
      ordersList.add(model);
    });
    return ordersList;

    // List<Order> response = await _manager.getMyOrders();
    // if (response == null) return null;

    // List<OrderModel> orders = [];
    // var df = new DateFormat('hh:mm');

    // response.forEach((element) {
    //   var date = new DateTime.fromMillisecondsSinceEpoch(
    //       element.date.timestamp * 1000);
    //   orders.add(new OrderModel(
    //     to: element.destination.isNotEmpty
    //         ? element.destination.elementAt(0)
    //         : '',
    //     from: element.source.isNotEmpty ? element.source.elementAt(0) : '',
    //     creationTime: df.format(date).toString() ?? '',
    //     paymentMethod: element.payment,
    //     id: element.id,
    //   ));
    // });
  }

  Future<OrderModel> getOrderDetails(String orderId) async {
    var ordersSnapshot = await FirebaseFirestore.instance
        .collection('c4d')
        .doc('data')
        .collection('orders')
        .doc('${orderId}')
        .get();

    ordersSnapshot.data()['id'] = orderId;

    return OrderModel.fromJson(ordersSnapshot.data());
    // OrderStatusResponse response = await _manager.getOrderDetails(orderId);
    // if (response == null) return null;
    // var df = new DateFormat('hh:mm');
    // var date =
    //     new DateTime.fromMillisecondsSinceEpoch(response.date.timestamp * 1000);

    // OrderModel order = new OrderModel(
    //   paymentMethod: response.payment,
    //   from: response.source[0],
    //   to: response.destination[0],
    //   creationTime: df.format(date).toString() ?? '',
    //   id: response.id,
    // );

    // return order;
  }

  Future<List<OrderModel>> getNearbyOrders() async {
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
    var orderRequest = new CreateOrderRequest(
        note: note,
        date: date,
        payment: paymentMethod,
        fromBranch: fromBranch,
        recipientName: recipientName,
        recipientPhone: recipientPhone,
        destination: [destination]);
    await FirebaseFirestore.instance
        .collection('c4d')
        .doc('data')
        .collection('orders')
        .add(orderRequest.toJson());
    return true;
  }
}
