class UpdateOrderRequest {
  int id;
  String state;
  String distance;

  UpdateOrderRequest({
    this.id,
    this.state,
    this.distance,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['state'] = this.state;
    data['kilometer'] = this.distance;
    return data;
  }
}
