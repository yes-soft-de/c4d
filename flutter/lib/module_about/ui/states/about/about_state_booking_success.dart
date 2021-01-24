import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageOwner extends AboutState {
  AboutStatePageOwner(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.check),
        Text(S.of(context).weWillContactYouSoon)
      ],
    );
  }
}
