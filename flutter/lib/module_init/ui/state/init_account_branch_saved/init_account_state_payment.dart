import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InitAccountStatePayment extends InitAccountState {
  final _bankNameController = TextEditingController();
  final _bankAccountController = TextEditingController();

  InitAccountStatePayment(InitAccountScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FaIcon(FontAwesomeIcons.ccVisa, size: 72),
                Text(S.of(context).ourBankName),
                Text(S.of(context).ourBankAccountNumber),
              ],
            ),
          ),
          RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(S.of(context).next),
              onPressed: () {
                screen.moveToOrders();
              })
        ],
      ),
    );
  }
}
