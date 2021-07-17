import 'package:c4d/generated/l10n.dart';

class OrderAverageHelper {
  static String getOrderAlertAverage(String orderAverage) {
    switch (orderAverage) {
      case '35':
        return S.current.orderAverage35;
      case '40':
        return S.current.orderAverage40;
      case '75':
        return S.current.orderAverage75;
      case '80':
        return S.current.orderAverage80;
      default:
        return S.current.errorHappened;
    }
  }
}
