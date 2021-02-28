import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: 256,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                color: Colors.black54,
              ),
            ),
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
                    )),
                GestureDetector(
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
