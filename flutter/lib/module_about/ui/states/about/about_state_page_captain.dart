import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageCaptain extends AboutState {
  int currentPage = 0;

  AboutStatePageCaptain(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (pos) {
            currentPage = pos;
            screenState.refresh();
          },
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.mobile_friendly,
                  size: 96,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  S.of(context).openTheApp,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.map,
                  size: 96,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  S.of(context).checkOrders,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.check,
                  size: 96,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  S.of(context).accept,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FaIcon(
                  FontAwesomeIcons.car,
                  size: 96,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  S.of(context).deliver,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.mobile_friendly,
                  size: 96,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  S.of(context).earnCash,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: getIndicator(),
        )
      ],
    );
  }

  Widget getIndicator() {
    var circles = <Widget>[];
    for (int i = 0; i < 5; i++) {
      circles.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              color: i <= currentPage ? Colors.cyan : Colors.grey,
              shape: BoxShape.circle),
        ),
      ));
    }
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: circles,
    );
  }
}
