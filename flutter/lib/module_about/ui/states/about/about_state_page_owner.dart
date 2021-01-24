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
          children: [
            Icon(Icons.mobile_friendly),
            Text(S.of(context).openTheApp)
          ],
        ),
        Column(
          children: [
            Icon(Icons.book_online),
            Text(S.of(context).bookACar),
          ],
        ),
        Column(
          children: [
            FaIcon(FontAwesomeIcons.car),
            Text(S.of(context).weDeliver)
          ],
        ),
        Column(
          children: [
            Text(S.of(context).toFindOutMorePleaseLeaveYourPhonenandWeWill),
            TextFormField(
              decoration: InputDecoration(
                  hintText: S.of(context).phoneNumber,
                  labelText: S.of(context).phoneNumber,
                  suffix: Icon(Icons.call)),
              keyboardType: TextInputType.phone,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                // TODO: Request a booking
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
