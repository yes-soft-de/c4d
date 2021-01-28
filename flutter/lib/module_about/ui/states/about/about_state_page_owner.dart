import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageOwner extends AboutState {
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);

  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AboutStatePageOwner(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    S.of(context).toFindOutMorePleaseLeaveYourPhonenandWeWill,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          validator: (phone) {
                            if (phone.isEmpty) {
                              return S.of(context).pleaseInputPhoneNumber;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: S.of(context).phoneNumber,
                              labelText: S.of(context).phoneNumber,
                              suffix: Icon(Icons.call)),
                          keyboardType: TextInputType.phone,
                        ),
                        TextFormField(
                          controller: _nameController,
                          validator: (name) {
                            if (name.isEmpty) {
                              return S.of(context).nameIsRequired;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: S.of(context).name,
                              labelText: S.of(context).name,
                              suffix: Icon(Icons.person)),
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      screenState.setBookingSuccess();
                    } else {
                      screenState.showSnackBar(S.of(context).pleaseCompleteTheForm);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(S.of(context).requestMeeting),
                  ),
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
