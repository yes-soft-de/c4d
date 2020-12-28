


class OrderModel{
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
}