class UpdateOrderRequest {
  int id;
  String state;

  UpdateOrderRequest({this.id, this.state});

  UpdateOrderRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    return data;
  }
}
