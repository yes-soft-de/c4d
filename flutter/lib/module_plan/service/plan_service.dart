import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_plan/model/active_plan_model.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';

@provide
class PlanService {
  final OrdersService _ordersService;
  final ProfileService _profileService;

  PlanService(
    this._ordersService,
    this._profileService,
  );

  Future<ActivePlanModel> getCurrentPlan() async {
    var orders = await this._ordersService.getMyOrders();
    var records = await this._profileService.getActivity();
    var activePlan = ActivePlanModel(
      activeCars: orders.length,
      activeOrders: records.length,
      name: 'Plan',
      cars: 2,
      orders: 20,
    );
    return activePlan;
  }
}
