class OrderModel {
  int id;
  String to;
  String from;
  String creationTime;
  String paymentMethod;

  OrderModel({
    this.id,
    this.to,
    this.creationTime,
    this.from,
    this.paymentMethod,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    creationTime = json['date'];
    // if (json['destination'] != null) {
    //   to = json['destination'].cast<String>();
    // }
    from = json['fromBranch'];
    paymentMethod = json['payment'];
  }
}
