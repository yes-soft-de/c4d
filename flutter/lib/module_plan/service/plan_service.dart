import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_plan/manager/package_balance_manager.dart';
import 'package:c4d/module_plan/model/active_plan_model.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/response/package_balance_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if (balanceModel != null && packages != null) {
      var totalOrder = ((packages.data?.countOrdersDelivered ?? 0) * 100) /
          int.tryParse(packages.data?.packageOrderCount ?? '1');
      bool alert;
      String orderAverage;
      if (totalOrder >= 80.0) {
        alert = await seenByUser(80);
        orderAverage = '80';
      } else if (totalOrder >= 50.0) {
        alert = await seenByUser(50);
        orderAverage = '50';
      } else if (totalOrder >= 35.0) {
        alert = await seenByUser(35);
        orderAverage = '35';
      } else {
        alert = await seenByUser(totalOrder.toInt());
        orderAverage = ' ';
      }
      if (packages.data.subscriptionstatus == 'unsubscribed') {
        return ActivePlanModel(state: packages.data.subscriptionstatus);
      }
      var activePlan = ActivePlanModel(
          id: packages.data.packageID,
          activeCars: packages.data.countActiveCar,
          activeOrders: packages.data.countOrdersDelivered,
          name: packages.data.packagename,
          cars: int.tryParse(packages.data.packageCarCount),
          orders: int.tryParse(packages.data.packageOrderCount),
          payments: balanceModel.payments,
          total: balanceModel.currentBalance,
          nextPayment: balanceModel.nextPay.toString(),
          state: packages.data.carsStatus ?? packages.data.subscriptionstatus,
          alert: alert,
          averageOrder: orderAverage);
      return activePlan;
    }
    return null;
  }

  Future<BalanceModel> getOwnerPayments() async {
    var result = await _packageBalanceManager.getOwnerPayments();

    if (result == null) {
      return null;
    }

    var resultModel = BalanceModel(
        payments: [],
        currentBalance: result.data.currentTotal,
        nextPay: result.data.nextPay);
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

  Future<bool> seenByUser(int percent) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    var user = await sh.getString('email') ?? '';
    if (percent < 35) {
      await sh.remove('$user consumed 80%');
      await sh.remove('$user consumed 50%');
      await sh.remove('$user consumed 35%');
      return false;
    }
    bool seen = await sh.getBool('$user consumed $percent%') ?? false;
    if (!seen) {
      await sh.setBool('$user consumed $percent%', true);
      return true;
    }
    return false;
  }
}
