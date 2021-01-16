import 'package:c4d/consts/order_status.dart';

class StatusHelper {
  static OrderStatus getStatus(String status) {
    if (status == null) {
      return OrderStatus.INIT;
    }
    if (status == 'pending') {
      return OrderStatus.INIT;
    }
    return OrderStatus.INIT;
  }
}