import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:lottie/lottie.dart';

@provide
class AboutStatePageInit extends AboutState {
  AboutScreenState screenState;
  String currentLanguage = 'en';
  UserRole currentRole;

  AboutStatePageInit(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Lottie.asset(
            'assets/animations/settings.json',
            repeat: true,
          ),
        ),
        Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).iSpeak,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              onPressed: () {
                _showLanguagePicker(context);
              },
              child: Text(_getCurrentLanguage(context)),
            ),
          ],
        ),
        Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.of(context).andIAm,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              padding: const EdgeInsets.all(8.0),
              onPressed: () {
                _showRolePicker(context);
              },
              child: Text(_getCurrentRole(context)),
            ),
          ],
        ),
      ],
    );
  }

  String _getCurrentLanguage(BuildContext context) {
    if (currentLanguage == 'en') {
      return 'English';
    } else if (currentLanguage == 'ar') {
      return 'العربية';
    } else {
      return S.of(context).iSpeak;
    }
  }

  String _getCurrentRole(BuildContext context) {
    if (currentRole == UserRole.ROLE_OWNER) {
      return S.of(context).storeOwner;
    } else if (currentRole == UserRole.ROLE_CAPTAIN) {
      return S.of(context).captain;
    } else {
      return S.of(context).iAm;
    }
  }

  void _showLanguagePicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: 300,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: [
                  Text('English'),
                  Text('العربية'),
                ],
                onSelectedItemChanged: (lang) {
                  currentLanguage = lang == 1 ? 'ar' : 'en';
                  screenState.setLanguage(lang == 1 ? 'ar' : 'en');
                },
              ),
            ));
  }

  void _showRolePicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: 300,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: [
                  Text(S.of(ctx).captain),
                  Text(S.of(ctx).storeOwner),
                ],
                onSelectedItemChanged: (type) {
                  currentRole = type == 0 ? UserRole.ROLE_CAPTAIN : UserRole.ROLE_OWNER;
                  screenState.setCurrentUser(
                      type == 0 ? UserRole.ROLE_CAPTAIN : UserRole.ROLE_OWNER);
                  screenState.refresh();
                },
              ),
            ));
  }
}
