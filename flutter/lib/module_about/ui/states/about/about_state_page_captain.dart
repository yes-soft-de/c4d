import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageCaptain extends AboutState {
  AboutStatePageCaptain(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return PageView(
      children: [
        Column(
          children: [
            Icon(Icons.mobile_friendly),
            Text(S.of(context).openTheApp)
          ],
        ),
        Column(
          children: [
            Icon(Icons.map),
            Text(S.of(context).checkOrders)
          ],
        ),
        Column(
          children: [
            Icon(Icons.check),
            Text(S.of(context).accept)
          ],
        ),
        Column(
          children: [
            FaIcon(FontAwesomeIcons.car),
            Text(S.of(context).deliver)
          ],
        ),
        Column(
          children: [
            Icon(Icons.mobile_friendly),
            Text(S.of(context).earnCash)
          ],
        ),
      ],
    );
  }
}