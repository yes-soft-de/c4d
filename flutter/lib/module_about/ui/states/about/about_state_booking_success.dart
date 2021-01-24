import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageOwnerBookingSuccess extends AboutState {
  AboutStatePageOwnerBookingSuccess(AboutScreenState screenState) : super(screenState);

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
