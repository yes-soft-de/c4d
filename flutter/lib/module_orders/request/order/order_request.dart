import 'package:c4d/module_orders/response/orders/orders_response.dart';

class CreateOrderRequest {
  String fromBranch;
  String destination;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  String date;
  GeoJson destination2;
  CreateOrderRequest(
      {this.fromBranch,
      this.destination,
      this.note,
      this.payment,
      this.recipientName,
      this.recipientPhone,
      this.date,
      this.destination2});

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    fromBranch = json['fromBranch'];
    //destination = GeoJson.fromJson(json['destination']);
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromBranch'] = this.fromBranch;
    //data['destination'] = this.destination.toJson();
    data['destination'] = this.destination;
    if (this.destination2 != null) {
      data['destination2'] = this.destination2.toJson();
    }
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['date'] = this.date;
    return data;
  }
}
