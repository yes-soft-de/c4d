import 'package:c4d/module_init/ui/screens/init_captain/init_account_captain_screen.dart';
import 'package:c4d/module_init/ui/state/init_account_captain/init_account_captain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class InitAccountCaptainStateLoading extends InitAccountCaptainState{
  final String status;
  InitAccountCaptainStateLoading(InitAccountCaptainScreenState screenState, this.status) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(),
        Container(child: Icon(Icons.upload_rounded),),
        Text('${status}'),
      ]
    );
  }
}