class OrderModel {
  String id;
  String to;
  Map<String, dynamic> toOnMap;
  String from;
  String creationTime;
  String paymentMethod;

  OrderModel({
    this.id,
    this.to,
    this.creationTime,
    this.from,
    this.paymentMethod,
    this.toOnMap,
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
