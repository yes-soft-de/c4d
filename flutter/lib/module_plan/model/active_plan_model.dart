import 'package:c4d/module_plan/model/captain_balance_model.dart';

class ActivePlanModel {
  String name;
  int cars;
  int orders;
  int activeOrders;
  int activeCars;
  List<PaymentModel> payments = <PaymentModel>[];

  ActivePlanModel({
    this.name,
    this.cars,
    this.orders,
    this.activeOrders,
    this.activeCars,
    this.payments,
  });
}
