import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:lottie/lottie.dart';

@provide
class AboutStatePageInit extends AboutState {
  AboutScreenStateManager screenState;
  String currentLanguage;
  UserRole currentRole;

  AboutStatePageInit(this.screenState) : super(screenState);
  UserRole get getCurrentRole => currentRole;
  @override
  Widget getUI(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Lottie.asset(
              'assets/animations/settings.json',
              repeat: true,
            ),
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
                _showLanguagePicker(context, myLocale);
              },
              child: Text(_getCurrentLanguage(context, myLocale)),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              screenState.moveNext(currentRole);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).next,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  String _getCurrentLanguage(BuildContext context, Locale locale) {
    if (locale.languageCode == 'en') {
      return 'English';
    } else if (locale.languageCode == 'ar') {
      return 'العربية';
    } else {
      return S.of(context).language;
    }
  }

  String _getCurrentRole(BuildContext context) {
    if (currentRole == UserRole.ROLE_OWNER) {
      return S.of(context).storeOwner;
    } else if (currentRole == UserRole.ROLE_CAPTAIN) {
      return S.of(context).captain;
    } else {
      return S.of(context).andIAm;
    }
  }

  void _showLanguagePicker(BuildContext context, Locale locale) {
    // showCupertinoModalPopup(
    //     context: context,
    //     builder: (_) => Container(
    //           width: MediaQuery.of(context).size.width,
    //           height: 250,
    //           child: CupertinoPicker(
    //             backgroundColor: Colors.white,
    //             itemExtent: 42,
    //             scrollController: FixedExtentScrollController(initialItem: 1),
    //             children: [
    //               Text(S.of(context).language),
    //               Text('English'),
    //               Text('العربية'),
    //             ],
    //             onSelectedItemChanged: (lang) {
    //               if (lang > 0) {
    //                 currentLanguage = lang == 2 ? 'ar' : 'en';
    //                 screenState.setLanguage(lang == 2 ? 'ar' : 'en');
    //               }
    //             },
    //           ),
    //         ));
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.of(context).language,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/united-kingdom.png',
                  width: 25,
                ),
                trailing: locale.languageCode == 'en'
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : null,
                title: new Text('English'),
                onTap: () {
                  screenState.setLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/saudi-arabia.png',
                  width: 25,
                ),
                trailing: locale.languageCode == 'ar'
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : null,
                title: new Text('العربية'),
                onTap: () {
                  screenState.setLanguage('ar');
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _showRolePicker(BuildContext context) {
    // showCupertinoModalPopup(
    //   context: context,
    //   builder: (_) => Container(
    //     width: double.maxFinite,
    //     height: 250,
    //     child: CupertinoPicker(
    //       backgroundColor: Colors.white,
    //       itemExtent: 42,
    //       scrollController: FixedExtentScrollController(initialItem: 1),
    //       children: [
    //         Text(S.of(context).andIAm),
    //         Text(S.of(context).captain),
    //         Text(S.of(context).storeOwner),
    //       ],
    //       onSelectedItemChanged: (type) {
    //         if (type > 0) {
    //           currentRole =
    //               type == 1 ? UserRole.ROLE_CAPTAIN : UserRole.ROLE_OWNER;
    //           screenState.refresh(this);
    //         }
    //       },
    //     ),
    //   ),
    // );
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.of(context).andIAm,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                title: Text(S.of(context).captain),
                leading: Icon(Icons.local_taxi),
                trailing: currentRole == UserRole.ROLE_CAPTAIN
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : null,
                onTap: () {
                  currentRole = UserRole.ROLE_CAPTAIN;
                  screenState.refresh(this);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                trailing: currentRole == UserRole.ROLE_OWNER
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : null,
                leading: Icon(Icons.store),
                title: new Text(S.of(context).storeOwner),
                onTap: () {
                  currentRole = UserRole.ROLE_OWNER;

                  screenState.refresh(this);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
