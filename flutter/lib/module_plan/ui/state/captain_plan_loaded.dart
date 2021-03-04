import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:c4d/module_plan/ui/widget/payment_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CaptainPlanScreenStateLoaded extends PlanScreenState {
  CaptainBalanceModel captainBalanceModel;

  CaptainPlanScreenStateLoaded(PlanScreen screen, this.captainBalanceModel)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _getUI(context),
      ),
    );
  }

  List<Widget> _getUI(BuildContext context) {
    var list = <Widget>[];

    int paymentDay = captainBalanceModel.payments.last.paymentDate.day;
    int paymentMonth = captainBalanceModel.payments.last.paymentDate.day + 1;
    int paymentYear = captainBalanceModel.payments.last.paymentDate.year;

    list.add(
      ListTile(
        title: Text(S.of(context).nextPaymentDate),
        trailing: Text(
          paymentDay.toString() + '/' + paymentMonth.toString()+ '/' + paymentYear.toString(),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );

    list.add(
      ListTile(
        title: Text(S.of(context).currentBalance),
        trailing: Text(
          '${captainBalanceModel.currentBalance} ' + S.of(context).saudiRiyal,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );

    list.add(ListTile(title: Text('Payment History', style: TextStyle(fontWeight: FontWeight.bold),),));

    captainBalanceModel.payments.forEach((element) {
      list.add(PaymentRow(element.paymentDate, element.amount));
    });

    return list;
  }
}
