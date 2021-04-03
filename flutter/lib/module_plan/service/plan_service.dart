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
      this.getOwnerPayments(),
    ]);
    List orders = responses[0];
    PackageBalanceResponse packages = responses[1];
    BalanceModel balanceModel = responses[2];
    var activePlan = ActivePlanModel(
      activeCars: orders == null ? 0 : orders.length,
      activeOrders: packages.data.countOrdersDelivered,
      name: packages.data.packagename,
      cars: int.tryParse(packages.data.packageCarCount),
      orders: int.tryParse(packages.data.packageOrderCount),
      payments: balanceModel.payments,
      total: balanceModel.currentBalance
    );
    return activePlan;
  }

  Future<BalanceModel> getOwnerPayments() async {
    var result = await _packageBalanceManager.getOwnerPayments();

    if (result == null) {
      return null;
    }

    var resultModel = BalanceModel(payments: [],currentBalance:result.data.currentTotal);
    result.data.payments.forEach((element) {
      resultModel.payments.add(PaymentModel(
        DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
        element.amount,
      ));
    });

    return resultModel;
  }

  Future<BalanceModel> getCaptainBalance() async {
    var result = await _packageBalanceManager.getCaptainBalance();

    if (result == null) {
      return null;
    }

    var resultModel = BalanceModel(payments: []);
    resultModel.bonus = result.data.bounce;
    if (result.data.total != null) {
      resultModel.currentBalance = result.data.total;
    }
    result.data.payments.forEach((element) {
      resultModel.payments.add(PaymentModel(
        DateTime.fromMillisecondsSinceEpoch(element.date.timestamp * 1000),
        element.amount,
      ));
    });

    return resultModel;
  }
}
