import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';

class AboutStatePageOwnerBookingSuccess extends AboutState {
  AboutStatePageOwnerBookingSuccess(AboutScreenStateManager screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.check, color: Theme.of(context).primaryColor, size: 96,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(S.of(context).weWillContactYouSoon, style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
        )
      ],
    );
  }
}
