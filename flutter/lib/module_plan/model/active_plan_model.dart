import 'package:c4d/module_plan/model/captain_balance_model.dart';

class ActivePlanModel {
  int id;
  String name;
  int cars;
  int orders;
  int activeOrders;
  int activeCars;
  int total;
  String nextPayment;
  List<PaymentModel> payments = <PaymentModel>[];

  ActivePlanModel(
      {this.id,
      this.name,
      this.cars,
      this.orders,
      this.activeOrders,
      this.activeCars,
      this.payments,
      this.total,
      this.nextPayment});
}
