class ReportRequest {
  var orderId;
  var reason;

  ReportRequest(this.orderId, this.reason);

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'reason': reason,
    };
  }
}
