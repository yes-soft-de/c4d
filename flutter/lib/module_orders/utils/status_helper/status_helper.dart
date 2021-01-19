import 'package:c4d/consts/order_status.dart';

class StatusHelper {
  static OrderStatus getStatus(String status) {
    if (status == null) {
      return OrderStatus.INIT;
    } else if (status == 'on way to pick order') {
      return OrderStatus.GOT_CAPTAIN;
    } else if (status == 'ongoing') {
      return OrderStatus.GOT_CASH;
    } else if (status == 'delivered') {
      return OrderStatus.FINISHED;
    }
    return OrderStatus.INIT;
  }
}
