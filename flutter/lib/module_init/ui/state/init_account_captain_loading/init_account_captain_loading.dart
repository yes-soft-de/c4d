import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class InitAccountCaptainStateLoading extends InitAccountState {
  final String status;
  InitAccountCaptainStateLoading(InitAccountScreenState screenState, this.status) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinearProgressIndicator(),
          Container(child: Icon(Icons.upload_rounded),),
          Text('${status}'),
        ]
      ),
    );
  }
}