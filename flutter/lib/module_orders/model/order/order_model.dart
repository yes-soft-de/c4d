import 'package:c4d/consts/order_status.dart';
import 'package:latlong/latlong.dart';

class OrderModel {
  String id;
  String to;
  LatLng toOnMap;
  String from;
  String creationTime;
  String paymentMethod;
  OrderStatus status;
  String ownerPhone;
  String captainPhone;
  String clientPhone;
  String chatRoomId;

  OrderModel({
    this.id,
    this.to,
    this.creationTime,
    this.from,
    this.paymentMethod,
    this.toOnMap,
    this.status,
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
