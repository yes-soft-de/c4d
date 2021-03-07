import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  final username;
  final user_image;
  final placeholder =
      'https://orthosera-dental.com/wp-content/uploads/2016/02/user-profile-placeholder.png';

  DrawerWidget(
      {this.username = 'user',
      this.user_image =
          'https://orthosera-dental.com/wp-content/uploads/2016/02/user-profile-placeholder.png'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black87
          : Colors.white,
      child: Container(
        width: 256,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            username != null || user_image != null
                ? Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ProfileRoutes.EDIT_ACTIVITY_SCREEN);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.blue[400],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(8),
                              child: Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(user_image),
                                    onError: (e, s) {
                                      return Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://orthosera-dental.com/wp-content/uploads/2016/02/user-profile-placeholder.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Text(
                              username,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            Flex(
              direction: Axis.vertical,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      PlanRoutes.PLAN_ROUTE,
                    );
                  },
                  child: ListTile(
                    title: Text(S.of(context).myPlan),
                    leading: Icon(Icons.money),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProfileRoutes.ACTIVITY_SCREEN,
                    );
                  },
                  child: ListTile(
                    title: Text(S.of(context).myOrders),
                    leading: Icon(Icons.compare_arrows),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://wa.me/+966502722204');
                  },
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(S.of(context).directSupport),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      String url = 'https://c4d-app.web.app/privacy.html';
                      launch(url);
                    },
                    child: ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text(
                        S.of(context).privacyPolicy,
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      String url = 'https://c4d-app.web.app/tos.html';
                      launch(url);
                    },
                    child: ListTile(
                      title: Text(
                        S.of(context).termsOfService,
                      ),
                      leading: Icon(Icons.privacy_tip),
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(SettingRoutes.ROUTE_SETTINGS);
                  },
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      S.of(context).settings,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://wa.me/?text=' +
                        S.of(context).pleaseDownloadC4d);
                  },
                  child: ListTile(
                    leading: Icon(Icons.ios_share),
                    title: Text(
                      S.of(context).share,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      String url = 'https://c4d-app.web.app/privacy.html';
                      launch(url);
                    },
                    child: ListTile(
                      leading: Icon(Icons.update),
                      title: Text(
                        S.of(context).latestUpdates,
                      ),
                    )),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.phone,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.whatsapp,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.facebook,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                    ),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
