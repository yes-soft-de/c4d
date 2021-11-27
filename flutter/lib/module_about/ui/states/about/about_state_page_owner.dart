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
  final _pageController = PageController(initialPage: 0);
  List<PackageModel> packages;

  AboutStatePageOwner(AboutScreenStateManager screenState, this.packages)
      : super(screenState);
  int get getCurrentPage => currentPage;
  String _selectedCity;
  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
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
                    _pageController.animateToPage(1,
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
                    _pageController.animateToPage(2,
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
                    _pageController.animateToPage(3,
                        duration: Duration(seconds: 1), curve: Curves.bounceIn);
                  },
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    S.of(context).ourPackages,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(
                    width: 150,
                    child: DropdownButtonFormField(
                        // value: _selectedCity,
                        decoration: InputDecoration(
                          hintText: S.of(context).chooseYourCity,
                        ),
                        items: _getCities(),
                        onChanged: (value) {
                          _selectedCity = value;
                          screenState.refresh(this);
                        }),
                  ),
                ),
                Container(
                  height: 275,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _selectedCity == null
                        ? _getPackagesCards()
                        : _getPackages(_selectedCity),
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
    for (int i = 0; i < 4; i++) {
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

  List<DropdownMenuItem> _getCities() {
    var cityNames = <String>{};
    packages.forEach((element) {
      cityNames.add('${element.city}');
    });
    cityNames.add(S.current.allcity);
    var cityDropDown = <DropdownMenuItem>[];
    cityNames.forEach((element) {
      cityDropDown.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    return cityDropDown;
  }

  List<Widget> _getPackages(String city) {
    if (packages == null) {
      return [];
    }
    if (packages.isEmpty) {
      return [];
    }
    if (_selectedCity == null) {
      return [];
    }
    List<PackageModel> cityPackage = [];
    for (int i = 0; i < packages.length; i++) {
      if (packages[i].city == city || city == S.current.allcity) {
        cityPackage.add(packages[i]);
      }
    }
    return cityPackage.map((element) {
      return PackageCard(
        package: element,
        active: false,
      );
    }).toList();
  }
}
