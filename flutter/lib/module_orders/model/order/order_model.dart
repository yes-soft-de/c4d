import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:latlong/latlong.dart';

class OrderModel {
  int id;
  GeoJson to;
  LatLng toOnMap;
  String from;
  DateTime creationTime;
  String paymentMethod;
  OrderStatus status;
  String ownerPhone;
  String captainPhone;
  String clientPhone;
  String chatRoomId;
  String storeName;
  String distance;

  OrderModel({
    this.id,
    this.to,
    this.from,
    this.creationTime,
    this.paymentMethod,
    this.status,
    this.storeName,
    this.ownerPhone,
    this.captainPhone,
    this.clientPhone,
    this.chatRoomId,
    this.distance,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    creationTime = json['date'];
    id = json['id'];
    from = json['fromBranch'];
    paymentMethod = json['payment'];
  }
}
