import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutStatePageOwner extends AboutState {
  AboutStatePageOwner(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return PageView(
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
              Icons.book_online,
              size: 96,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              S.of(context).bookACar,
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
              S.of(context).weDeliver,
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(S.of(context).toFindOutMorePleaseLeaveYourPhonenandWeWill, textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(direction: Axis.vertical,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: S.of(context).phoneNumber,
                      labelText: S.of(context).phoneNumber,
                      suffix: Icon(Icons.call)),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: S.of(context).name,
                      labelText: S.of(context).name,
                      suffix: Icon(Icons.person)),
                  keyboardType: TextInputType.phone,
                ),
              ],),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                screenState.setBookingSuccess();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(S.of(context).requestMeeting),
              ),
            )
          ],
        ),
      ],
    );
  }
}
