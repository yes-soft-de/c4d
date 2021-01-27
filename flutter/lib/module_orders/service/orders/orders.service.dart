
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/accept_order_request/accept_order_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/order_details/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/utils/status_helper/status_helper.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';

@provide
class OrdersService {
  final OrdersManager _ordersManager;
  final ProfileService _profileService;

  OrdersService(this._ordersManager, this._profileService);

  Future<List<OrderModel>> getMyOrders() async {
    List<Order> response = await _ordersManager.getMyOrders();
    if (response == null) return null;

    List<OrderModel> orders = [];

    response.forEach((element) {
      orders.add(new OrderModel(
        to: element.location,
        clientPhone: element.recipientPhone,
        from: element.fromBranch.brancheName,
        creationTime:
            DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
        paymentMethod: element.payment,
        id: element.id,
      ));
    });

    return orders.reversed.toList();
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
      chatRoomId: response.uuid,
      ownerPhone: response.phone,
      captainPhone: response.acceptedOrder.isNotEmpty ? response.acceptedOrder.last.phone : null,
    );

    return order;
  }

  Future<List<OrderModel>> getNearbyOrders() async {
    List<Order> response = await _ordersManager.getNearbyOrders();
    if (response == null) {
      return null;
    }

    if (response.isEmpty) {
      return null;
    }

    var orders = <OrderModel>[];
    response.forEach((element) {
      try {
        orders.add(OrderModel(
          to: element.location,
          from: element.fromBranch.id.toString(),
          creationTime: DateTime.fromMillisecondsSinceEpoch(
              element.date.timestamp * 1000),
          paymentMethod: element.payment,
          id: element.id,
        ));
      } catch (e, stack) {
        print(e.toString() + stack.toString());
      }
    });

    print('Final is: ${orders.length}');

    return orders;
  }

  Future<bool> addNewOrder(
      Branch fromBranch,
      GeoJson destination,
      String note,
      String paymentMethod,
      String recipientName,
      String recipientPhone,
      String date) async {
    var orderRequest = CreateOrderRequest(
      note: note,
      date: date,
      payment: paymentMethod,
      fromBranch: fromBranch.id.toString(),
      recipientName: recipientName,
      recipientPhone: recipientPhone,
      destination: destination,
    );
    return _ordersManager.addNewOrder(orderRequest);
  }

  Future<OrderDetailsResponse> updateOrder(int orderId, OrderModel order) {
    switch (order.status) {
      case OrderStatus.GOT_CAPTAIN:
        var request = AcceptOrderRequest(
            orderID: orderId.toString());
        return _ordersManager.acceptOrder(request);
        break;
      case OrderStatus.IN_STORE:
        var request = UpdateOrderRequest(id: orderId, state: 'in store');
        return _ordersManager.updateOrder(request);
        break;
      case OrderStatus.DELIVERING:
        var request = UpdateOrderRequest(id: orderId, state: 'ongoing');
        return _ordersManager.updateOrder(request);
        break;
      case OrderStatus.GOT_CASH:
        var request = UpdateOrderRequest(id: orderId, state: 'got cash');
        return _ordersManager.updateOrder(request);
        break;
      case OrderStatus.FINISHED:
        var request = UpdateOrderRequest(id: orderId, state: 'delivered');
        return _ordersManager.updateOrder(request);
        break;
      default:
        print('Unknown Package State');
        return null;
    }
  }

  Future<List<OrderModel>> getCaptainOrders() async {
    List<Order> response = await _ordersManager.getCaptainOrders();
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
}
