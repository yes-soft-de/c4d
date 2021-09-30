import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/active_plan_model.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:c4d/module_plan/ui/widget/payment_row.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlanScreenStateLoaded extends PlanState {
  final ActivePlanModel activePlanModel;
  PlanScreenStateLoaded(PlanScreenState screen, this.activePlanModel)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    bool renew = ModalRoute.of(context).settings.arguments ?? false;
    if (activePlanModel.cars == 0) {
      activePlanModel.cars = 999999999;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${S.of(context).myPlan}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            renew
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        tileColor: Theme.of(context).primaryColor,
                        title: Text(
                          S.of(context).renewSubscription,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onTap: () {
                          screen.renewPackage(activePlanModel.id);
                        },
                      ),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.of(context).activePlan),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.car),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: activePlanModel.cars >= 999999999
                                  ? Text('${S.of(context).unknownNumberOfCar}')
                                  : Text('${activePlanModel.cars} ' +
                                      S.of(context).activeCars),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.sync),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('${activePlanModel.orders} ' +
                                  S.of(context).ordersMonth),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _getOrderRow(
                context,
                activePlanModel.activeOrders,
                (activePlanModel.orders - activePlanModel.activeOrders).abs(),
                (activePlanModel.activeOrders / activePlanModel.orders) > 0.8),
            _getCarsRow(
                context,
                activePlanModel.activeCars,
                (activePlanModel.cars - activePlanModel.activeCars).abs(),
                (activePlanModel.activeCars / activePlanModel.cars) > 0.8),
            _getPaymentList(activePlanModel.payments, context),
          ],
        ),
      ),
    );
  }

  Widget _getOrderRow(BuildContext context, int filled, int empty,
      [bool danger = false]) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.compare_arrows),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: filled,
                    child: Container(
                      height: 8,
                      color: danger == true
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: empty,
                    child: Container(
                      height: 8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text('${activePlanModel.activeOrders} / '),
          Text(
            '${activePlanModel.orders}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _getCarsRow(BuildContext context, int filled, int empty,
      [bool danger = false]) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.car_rental),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: filled,
                    child: Container(
                      height: 8,
                      color: danger == true
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: empty,
                    child: Container(
                      height: 8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text('${activePlanModel.activeCars} / '),
          Text(
            '${activePlanModel.cars >= 999999999 ? '∞' : activePlanModel.cars}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _getPaymentList(List<PaymentModel> payments, BuildContext context) {
    var list = <Widget>[];

    try {
      int paymentDay = activePlanModel.payments.last.paymentDate.day;
      int paymentMonth = activePlanModel.payments.last.paymentDate.month;
      int paymentYear = activePlanModel.payments.last.paymentDate.year;
      String paymentDate = activePlanModel.nextPayment;
      list.add(ListTile(
        title: Text(
          S.of(context).nextPaymentDate,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
      list.add(
        Card(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            // title: Text(
            //   S.of(context).nextPaymentDate,
            //   style: TextStyle(color: Colors.white),
            // ),
            title: Center(
              child: Text(
                '$paymentDate',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
      list.add(
        Card(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            title: Text(
              S.of(context).myBalance,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              activePlanModel.total.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } catch (e) {}

    list.add(ListTile(
      title: Text(
        S.of(context).paymentHistory,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ));

    payments.forEach((element) {
      list.add(PaymentRow(element.paymentDate, element.amount));
    });

    return Flex(
      direction: Axis.vertical,
      children: list,
    );
  }
}
