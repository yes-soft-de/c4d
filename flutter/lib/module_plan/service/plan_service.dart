import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_plan/manager/package_balance_manager.dart';
import 'package:c4d/module_plan/model/active_plan_model.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/response/package_balance_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';

@provide
class PlanService {
  final OrdersService _ordersService;
  final ProfileService _profileService;
  final PackageBalanceManager _packageBalanceManager;

  PlanService(
    this._ordersService,
    this._profileService,
    this._packageBalanceManager,
  );

  Future<ActivePlanModel> getOwnerCurrentPlan() async {
    var responses = await Future.wait([
      this._ordersService.getMyOrders(),
      this._packageBalanceManager.getOwnerPackage(),
    ]);
    List orders = responses[0];
    PackageBalanceResponse packages = responses[1];
    var activePlan = ActivePlanModel(
      activeCars: orders == null ? 0 : orders.length,
      activeOrders: packages.data.countOrdersDelivered,
      name: packages.data.packagename,
      cars: int.tryParse(packages.data.packageCarCount),
      orders: int.tryParse(packages.data.packageOrderCount),
    );
    return activePlan;
  }

  Future<CaptainBalanceModel> getCaptainBalance() async {
    var result = await _packageBalanceManager.getCaptainBalance();

    if (result == null) {
      return null;
    }

    var resultModel = CaptainBalanceModel(payments: []);
    resultModel.bonus = result.data.bounce;
    resultModel.currentBalance = int.tryParse(result.data.sumPayments);
    result.data.payments.forEach((element) {
      resultModel.payments.add(PaymentModel(
        DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
        element.amount,
      ));
    });

    return resultModel;
  }
}
