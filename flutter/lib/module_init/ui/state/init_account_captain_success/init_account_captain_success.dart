import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class InitAccountCaptainStateSuccess extends InitAccountState {
  InitAccountCaptainStateSuccess(InitAccountScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.check),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(S.of(context).accountCreated),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
          },
          child: Text(S.of(context).moveToOrders),
        )
      ],
    );
  }
}
