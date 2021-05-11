import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';

class PlanScreenStateLoading extends PlanState {
  PlanScreenStateLoading(PlanScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}

class PlanScreenStateError extends PlanState {
  PlanScreenStateError(PlanScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myPlan),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(S.of(context).notVerified),
          )
        ],
      ),
    );
  }
}

class PlanScreenStateSuccess extends PlanState {
  PlanScreenStateSuccess(PlanScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).myPlan),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
              size: 125,
            )),
            SizedBox(height: 16),
            Center(child: Text(S.of(context).successRenew)),
            SizedBox(height: 16),
            Center(
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
                    },
                    child: Text(S.of(context).next))),
          ],
        ));
  }
}
