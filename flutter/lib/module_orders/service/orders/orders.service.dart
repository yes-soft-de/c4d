import 'dart:convert';

import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_details/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/utils/status_helper/status_helper.dart';
import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';

@provide
class OrdersService {
  final OrdersManager _ordersManager;
  final ProfileService _profileService;

  OrdersService(this._ordersManager, this._profileService);

  Future<List<OrderModel>> getMyOrders() async {
    List<Order> response = await _ordersManager.getMyOrders();
    print('Orders ${response.length}');
    if (response == null) return null;

    List<OrderModel> orders = [];

    response.forEach((element) {
      orders.add(new OrderModel(
        to: element.location,
        clientPhone: element.recipientPhone,
        from: '',
        creationTime:
            DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
        paymentMethod: element.payment,
        id: element.id,
      ));
    });

    return orders;
  }

  Future<OrderModel> getOrderDetails(int orderId) async {
    OrderDetailsData response = await _ordersManager.getOrderDetails(orderId);
    if (response == null) return null;

    var date =
        DateTime.fromMillisecondsSinceEpoch(response.date.timestamp * 1000);

    OrderModel order = new OrderModel(
      paymentMethod: response.payment,
      from: response.fromBranch.toString(),
      to: response.location,
      creationTime: date,
      status: StatusHelper.getStatus(response.state),
      id: orderId,
    );

    return order;
  }

  Future<List<OrderModel>> getNearbyOrders() async {
    List<Order> response = await _ordersManager.getNearbyOrders();
    if (response == null) {
      print('Null Response');
      return null;
    }

    if (response.isEmpty) {
      print('Empty Response');
      return null;
    }

    var orders = <OrderModel>[];
    response.forEach((element) {
      try {
        orders.add(OrderModel(
          to: element.location,
          from: '',
          creationTime: DateTime.fromMillisecondsSinceEpoch(
              element.date.timestamp * 1000),
          paymentMethod: element.payment,
          id: element.id,
        ));
      } catch (e) {
        print(e.toString());
      }
    });

    print('Final is: ${orders.length}');

    return orders;
  }

  Future<bool> addNewOrder(
      String fromBranch,
      GeoJson destination,
      String note,
      String paymentMethod,
      String recipientName,
      String recipientPhone,
      String date) async {
    var branchId = await _profileService.getMyBranches();
    var orderRequest = new CreateOrderRequest(
      note: note,
      date: date,
      payment: paymentMethod,
      fromBranch: branchId.toString(),
      recipientName: recipientName,
      recipientPhone: recipientPhone,
      destination: destination,
    );
    return _ordersManager.addNewOrder(orderRequest);
  }

  Future<OrderDetailsResponse> updateOrder(int orderId, OrderModel order) {
    return _ordersManager.updateOrder(
        orderId,
        CreateOrderRequest(
          fromBranch: order.from,
          destination: order.to,
          note: ' ',
          payment: order.paymentMethod,
          recipientPhone: order.clientPhone,
        ));
  }
}
