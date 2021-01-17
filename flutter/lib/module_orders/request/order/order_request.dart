class CreateOrderRequest {
  String fromBranch;
  List<String> destination;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  String date;

  CreateOrderRequest(
      {this.fromBranch,
      this.destination,
      this.note,
      this.payment,
      this.recipientName,
      this.recipientPhone,
      this.date});

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    fromBranch = json['fromBranch'];
    destination = json['destination'].cast<String>();
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromBranch'] = this.fromBranch;
    data['destination'] = this.destination;
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['date'] = this.date;
    return data;
  }
}
