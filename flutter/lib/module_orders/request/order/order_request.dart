


class OrderRequest{
  String fromBranch;
  String destination;
  String note;
  String paymentMethod;
  String recipientName;
  String recipientPhone;
  String date;
  
  OrderRequest({
    this.note,
    this.paymentMethod,
    this.destination,
    this.date,
    this.fromBranch,
    this.recipientName,
    this.recipientPhone,
});
  
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['recipientPhone'] = this.recipientPhone;
    data['fromBranch'] = this.fromBranch;
    data['destination'] = this.destination;
    data['note'] = this.note;
    data['paymentMethod'] = this.paymentMethod;
    data['recipientName'] = this.recipientName;
    data['date'] = this.date;
    
    return data;
  }
}