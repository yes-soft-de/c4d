import 'package:c4d/consts/order_status.dart';
import 'package:latlong/latlong.dart';

class OrderModel {
  int id;

  OrderModel({
    this.id,
    this.to,
    this.toOnMap,
    this.from,
    this.creationTime,
    this.paymentMethod,
    this.status,
    this.ownerPhone,
    this.captainPhone,
    this.clientPhone,
    this.chatRoomId,
  });

  String to;
  LatLng toOnMap;
  String from;
  DateTime creationTime;
  String paymentMethod;
  OrderStatus status;
  String ownerPhone;
  String captainPhone;
  String clientPhone;
  String chatRoomId;

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
