import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';

@provide
class SettingsScreen extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final AppThemeDataService _themeDataService;

  SettingsScreen(
    this._authService,
    this._localizationService,
    this._themeDataService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Flex(
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
                    Text('Dark Mode'),
                    Switch(
                        value: Theme.of(context).brightness == Brightness.dark,
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
                      future: widget._localizationService.getLanguage(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return DropdownButton(
                            value: snapshot.data,
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
                              widget._localizationService.setLanguage(newLang);
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
    );
  }
}
