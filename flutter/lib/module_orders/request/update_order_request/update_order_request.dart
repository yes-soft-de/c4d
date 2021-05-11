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
    if (distance != null) {
      data['kilometer'] = double.tryParse(this.distance);
    }
    return data;
  }
}
