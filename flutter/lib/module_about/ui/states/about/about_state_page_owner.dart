import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:c4d/module_init/ui/widget/package_card/package_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageOwner extends AboutState {
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);
  List<PackageModel> packages;

  AboutStatePageOwner(AboutScreenStateManager screenState, this.packages)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (pos) {
            currentPage = pos;
            screenState.refresh(this);
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
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(S.of(context).next),
                  onPressed: () {
                    pageController.animateToPage(1,
                        duration: Duration(seconds: 1), curve: Curves.bounceIn);
                  },
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.book_online,
                  size: 96,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  S.of(context).bookACar,
                  style: TextStyle(fontSize: 24),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(S.of(context).next),
                  onPressed: () {
                    pageController.animateToPage(2,
                        duration: Duration(seconds: 1), curve: Curves.bounceIn);
                  },
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
                  S.of(context).weDeliver,
                  style: TextStyle(fontSize: 24),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(S.of(context).next),
                  onPressed: () {
                    pageController.animateToPage(3,
                        duration: Duration(seconds: 1), curve: Curves.bounceIn);
                  },
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  S.of(context).ourPackages,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Container(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _getPackagesCards(),
                  ),
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        S
                            .of(context)
                            .toFindOutMorePleaseLeaveYourPhonenandWeWill,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        screenState.requestBooking();
                      },
                      child: Text(
                        S.of(context).requestMeeting,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 16,
                ),
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

  List<Widget> _getPackagesCards() {
    var packagesCards = <Widget>[];
    packages.forEach((package) {
      packagesCards.add(PackageCard(
        package: package,
        active: false,
      ));
    });
    return packagesCards;
  }
}
