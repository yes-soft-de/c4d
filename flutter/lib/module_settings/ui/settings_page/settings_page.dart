import 'dart:io';

import 'package:c4d/module_about/about_routes.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_plan/plan_routes.dart';
@provide
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;
  final ProfileService _profileService;
  final FireNotificationService _notificationService;

  SettingsScreen(
    this._authService,
    this._localizationService,
    this._themeDataService,
    this._profileService,
    this._notificationService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    UserRole userRole = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).settings,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).darkMode),
                      Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (mode) {
                            widget._themeDataService
                                .switchDarkMode(mode)
                                .then((value) {});
                          })
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: widget._authService.userRole,
              builder:
                  (BuildContext context, AsyncSnapshot<UserRole> snapshot) {
                if (snapshot.data == UserRole.ROLE_OWNER) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).renewSubscription),
                            IconButton(
                                icon: Icon(Icons.autorenew_sharp),
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10))),
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                S.of(context).renewPlan,
                                                style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25, right: 25),
                                              child: Divider(
                                                thickness: 2.5,
                                              ),
                                            ),
                                            Container(
                                              width: double.maxFinite,
                                              height: 55,
                                              child: FlatButton(
                                                onPressed: () {
                                                   Navigator.pop(context);
                                                  Navigator.of(context).pushNamed(
                                                     PlanRoutes.PLAN_ROUTE,
                                                      arguments: true);
                                                },
                                                child: Text(
                                                    S.of(context).renewOldPlan),
                                              ),
                                            ),
                                            Container(
                                              width: double.maxFinite,
                                              height: 55,
                                              child: FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.of(context).pushNamed(
                                                      InitAccountRoutes
                                                          .INIT_ACCOUNT_SCREEN,
                                                      arguments: true);
                                                },
                                                child: Text(
                                                    S.of(context).renewNewPlan),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            _getCaptainStateSwitch(userRole ?? UserRole.ROLE_OWNER),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).language),
                      FutureBuilder(
                        initialData: Platform.localeName.substring(0, 2),
                        future: widget._localizationService.getLanguage(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return DropdownButton(
                              value: snapshot.data ??
                                  Platform.localeName.substring(0, 2),
                              items: [
                                DropdownMenuItem(
                                  child: Text('العربية'),
                                  value: 'ar',
                                ),
                                DropdownMenuItem(
                                  child: Text('English'),
                                  value: 'en',
                                ),
                              ],
                              onChanged: (String newLang) {
                                widget._localizationService
                                    .setLanguage(newLang);
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                    future: widget._authService.isLoggedIn,
                    initialData: false,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).signOut),
                            IconButton(
                                icon: Icon(Icons.logout),
                                onPressed: () {
                                  widget._authService.logout().then((value) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AuthorizationRoutes.LOGIN_SCREEN,
                                        (route) => false);
                                  });
                                })
                          ],
                        );
                      } else {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).login),
                            IconButton(
                                icon: Icon(Icons.login),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AuthorizationRoutes.LOGIN_SCREEN);
                                })
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> switchBuilder() async {
    var profile = await widget._profileService.getProfile();
    return Switch(
      onChanged: (bool value) {
        profile.isOnline = value;
        widget._notificationService
            .setCaptainActive(value)
            .whenComplete(() => setState(() {}));
        widget._profileService
            .updateCaptainProfile(
              ProfileRequest(
                name: profile.name,
                image: profile.image,
                phone: profile.phone,
                drivingLicence: profile.drivingLicence,
                city: 'Jedda',
                branch: '-1',
                car: profile.car,
                age: profile.age.toString(),
                isOnline: value == true ? 'active' : 'inactive',
              ),
            )
            .whenComplete(() => setState(() {
                  loading = false;
                }));
      },
      value: profile.isOnline == true,
    );
  }

  Widget switchProgressBuilder() {
    return FutureBuilder(
      future: switchBuilder(),
      builder: (_, snape) {
        if (snape.connectionState == ConnectionState.waiting) {
          return Container(
            width: 48,
            height: 48,
            child: Center(
              child: Container(
                  height: 15, width: 15, child: CircularProgressIndicator()),
            ),
          );
        } else if (snape.hasData) {
          return snape.data;
        } else {
          return Container(
            width: 48,
            height: 48,
            child: Center(
              child: Container(
                  height: 15, width: 15, child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }

  Widget _getCaptainStateSwitch(UserRole userRole) {
    if (userRole == UserRole.ROLE_OWNER) {
      return Container();
    } else {
      // The User is a captain
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.black12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).myStatus),
                switchProgressBuilder(),
              ],
            ),
          ),
        ),
      );
    }
  }
}
