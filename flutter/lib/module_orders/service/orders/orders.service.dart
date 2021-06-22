import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/update/update_model.dart';
import 'package:c4d/module_orders/request/accept_order_request/accept_order_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/response/order_details/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/utils/status_helper/status_helper.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/order_info_respons.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      if (element.state != 'delivered') {
        orders.add(new OrderModel(
          to: element.destination,
          clientPhone: element.recipientPhone,
          from: element.fromBranch.brancheName,
          creationTime: DateTime.fromMillisecondsSinceEpoch(
              element.date.timestamp * 1000),
          paymentMethod: element.payment,
          id: element.id,
        ));
      }
    });

    return orders.reversed.toList();
  }

  Future<String> getCaptainStatus() async {
    String response = await _ordersManager.getCaptainStatus();
    return response;
  }

  Future<bool> getConfirmOrderState(var orderId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var confirm = await sharedPreferences
        .getBool('captain is in store owner for order $orderId');
    return confirm == null;
  }

  Future<void> setConfirmOrderState(var orderId, bool answar) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(
        'captain is in store owner for order $orderId', answar);
  }

  Future sendOrderReportState(var orderId, bool answar) async {
    await setConfirmOrderState(orderId, answar);
    var result = await _ordersManager.sendToRecord(orderId, answar);
    return result;
  }

  Future<OrderModel> getOrderDetails(int orderId) async {
    OrderDetailsData response = await _ordersManager.getOrderDetails(orderId);
    if (response == null) return null;
    bool canRemove = false;
    var date;
    if (response.createAt != null) {
      date = DateTime.fromMillisecondsSinceEpoch(
          response.createAt.timestamp * 1000);
    } else {
      date =
          DateTime.fromMillisecondsSinceEpoch(response.date.timestamp * 1000);
    }

    if (DateTime.now().difference(date).inMinutes <= 30) {
      canRemove = true;
    }
    bool showConfirmingOrderState = await getConfirmOrderState(orderId);
    OrderModel order = new OrderModel(
        paymentMethod: response.payment,
        from: response.fromBranch.toString(),
        to: response.destination,
        creationTime:
            DateTime.fromMillisecondsSinceEpoch(response.date.timestamp * 1000),
        branchLocation: response.fromBranch?.location,
        status: StatusHelper.getStatus(response.state),
        id: orderId,
        chatRoomId: response.uuid,
        clientPhone: response.recipientPhone,
        ownerPhone: response.phone ?? response.ownerResponse.phone,
        captainPhone: response.acceptedOrder.isNotEmpty
            ? response.acceptedOrder.last.phone
            : null,
        canRemove: canRemove,
        showConfirm: showConfirmingOrderState,
        costumerLocation:
            response.destination2 ?? GeoJson(lon: null, lat: null));

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
    if (response.isNotEmpty) {
      response.forEach((element) {
        try {
          bool flag = true;
          var creationDate =
              DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000)
                  .toLocal();
          if (creationDate.difference(DateTime.now()).inMinutes <= 30) {
            flag = true;
          } else {
            flag = false;
          }
          if (flag) {
            orders.add(OrderModel(
                to: element.destination,
                from: element.fromBranch?.id.toString(),
                storeName: element.owner.userName,
                creationTime: DateTime.fromMillisecondsSinceEpoch(
                    element.date.timestamp * 1000),
                paymentMethod: element.payment,
                id: element.id,
                branchLocation: element.fromBranch?.location ??
                    GeoJson(lat: 40.159419, lon: -107.860011)));
          }
        } catch (e, stack) {
          Logger().error('Mapping Error',
              '${e.toString()}:\n${stack.toString()}', StackTrace.current);
        }
      });
    }

    return orders;
  }

  Future<bool> addNewOrder(
      Branch fromBranch,
      String destination,
      String note,
      String paymentMethod,
      String recipientName,
      String recipientPhone,
      String date,
      LatLng destination2) async {
    var orderRequest = CreateOrderRequest(
        note: note,
        date: date,
        payment: paymentMethod,
        fromBranch: fromBranch.id.toString(),
        recipientName: recipientName,
        recipientPhone: recipientPhone,
        destination: destination,
        destination2: destination2 != null
            ? GeoJson(lat: destination2.latitude, lon: destination2.longitude)
            : null);
    return _ordersManager.addNewOrder(orderRequest);
  }

  Stream onUpdateChangeWatcher(int orderId) {
    return FirebaseFirestore.instance
        .collection('order_state')
        .doc(orderId.toString())
        .collection('order_history')
        .snapshots();
  }

  Stream onInsertChangeWatcher() {
    return FirebaseFirestore.instance
        .collection('orders')
        .doc('new_order')
        .collection('order_history')
        .snapshots();
  }

  Future<OrderDetailsResponse> updateOrder(int orderId, OrderModel order) {
    FirebaseFirestore.instance
        .collection('order_state')
        .doc(orderId.toString())
        .collection('order_history')
        .add({'date': DateTime.now().toLocal().toIso8601String()});

    switch (order.status) {
      case OrderStatus.GOT_CAPTAIN:
        var request = AcceptOrderRequest(orderID: orderId.toString());
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
        var request = UpdateOrderRequest(
            id: orderId, state: 'delivered', distance: order.distance);
        return _ordersManager.updateOrder(request);
        break;
      default:
        return null;
    }
  }

  Future<List<OrderModel>> getCaptainOrders() async {
    List<Order> response = await _ordersManager.getCaptainOrders();
    if (response == null) return null;

    List<OrderModel> orders = [];
    response.forEach((element) {
      orders.add(new OrderModel(
        to: element.destination,
        clientPhone: element.recipientPhone,
        branchLocation: element.fromBranch?.location,
        from: '',
        storeName: element.ownerName,
        creationTime:
            DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
        paymentMethod: element.payment,
        id: element.id,
      ));
    });

    return orders;
  }

  Future<CompanyInfoResponse> getCompanyInfo() async {
    CompanyInfoResponse response = await _ordersManager.getCompanyInfo();
    if (response == null) return null;
    return response;
  }

  Future<List<UpdateModel>> getUpdates() async {
    List response = await _ordersManager.getUpdates();
    if (response == null) return null;

    List<UpdateModel> updates = [];

    response.forEach((element) {
      updates.add(UpdateModel.fromJson(element));
    });
    return updates;
  }

  Future<OrderInfoRespons> getOrder(int orderId) async {
    Map response = await _ordersManager.getOrder(orderId);
    if (response == null) return null;
    return OrderInfoRespons.fromJson(response);
  }

  Future<bool> deleteOrder(int id) async {
    bool response = await _ordersManager.deleteOrder(id);
    if (response == null) return null;
    return response;
  }
}
