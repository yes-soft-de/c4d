import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class InitAccountStateProfileCreated extends InitAccountState {
  InitAccountStateProfileCreated(InitAccountScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Lottie.asset('assets/animations/register-success.json'),
          RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(S.of(context).paySubscription),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (r) => false);
              })
        ],
      ),
    );
  }

}