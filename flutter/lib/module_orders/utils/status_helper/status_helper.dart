import 'package:c4d/consts/order_status.dart';

class StatusHelper {
  static OrderStatus getStatus(String status) {
    if (status == null) {
      return OrderStatus.INIT;
    } else if (status == 'on way to pick order') {
      return OrderStatus.GOT_CAPTAIN;
    } else if (status == 'in store') {
      return OrderStatus.IN_STORE;
    } else if (status == 'ongoing') {
      return OrderStatus.DELIVERING;
    } else if (status == 'cash') {
      return OrderStatus.GOT_CASH;
    } else if (status == 'delivered') {
      return OrderStatus.FINISHED;
    }
    return OrderStatus.INIT;
  }
}
