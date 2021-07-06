import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_navigation/ui/comunity_screen.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  final String username;
  final String user_image;
  final String placeholder =
      'https://orthosera-dental.com/wp-content/uploads/2016/02/user-profile-placeholder.png';
  final String whatsapp;
  final phone;
  final UserRole role;
  final String chatID;
  final CompanyInfoResponse companyInfo;
  DrawerWidget({
    this.username,
    this.user_image,
    this.whatsapp,
    this.phone,
    @required this.role,
    this.chatID,
    this.companyInfo
  }) : assert(role != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black87
          : Colors.white,
      height: MediaQuery.of(context).size.height,
      width: 256,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Flex(
                direction: Axis.vertical,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ProfileRoutes.EDIT_ACTIVITY_SCREEN);
                    },
                    child: Container(
                      width: 256,
                      padding: EdgeInsets.all(16),
                      color: Colors.blue[400],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 48,
                              width: 48,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${user_image}'.contains('http')
                                            ? '${user_image}'
                                            : '${Urls.IMAGES_ROOT}${user_image}',
                                      ),
                                      fit: BoxFit.cover,
                                      onError: (c, s) {
                                        print('Error ' + c.toString());
                                        return AssetImage(
                                          'assets/images/logo.jpg',
                                        );
                                      },
                                    )),
                              ),
                            ),
                          ),
                          Text(
                            '${username ?? 'user'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        PlanRoutes.PLAN_ROUTE,
                      );
                    },
                    child: ListTile(
                      title: Text(S.of(context).myBalance),
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
                      launch('https://wa.me/$whatsapp');
                    },
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.whatsapp),
                      title: Text(S.of(context).directSupport),
                    ),
                  ),
                  chatID != null
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ChatRoutes.chatRoute,
                              arguments:role == UserRole.ROLE_CAPTAIN?'A#$chatID':'O#$chatID',
                            );
                          },
                          child: ListTile(
                            leading: Icon(Icons.chat),
                            title: Text(S.of(context).directSupport),
                          ),
                        )
                      : Container(),
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
                        print(role);
                        if (role == UserRole.ROLE_CAPTAIN) {
                          Navigator.of(context)
                              .pushNamed(OrdersRoutes.TERMS_SCREEN);
                        } else {
                          String url = 'https://c4d-app.web.app/tos.html';
                          launch(url);
                        }
                      },
                      child: ListTile(
                        title: Text(
                          S.of(context).termsOfService,
                        ),
                        leading: Icon(Icons.privacy_tip),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          SettingRoutes.ROUTE_SETTINGS,
                          arguments: role);
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
                      Share.share(
                          '${S.of(context).pleaseDownloadC4d} https://c4d.yes-soft.de/');
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
                        Navigator.of(context)
                            .pushNamed(OrdersRoutes.UPDATE_SCREEN);
                      },
                      child: ListTile(
                        leading: Icon(Icons.update),
                        title: Text(
                          S.of(context).latestUpdates,
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        String url = 'https://c4d-app.web.app/privacy.html';
                        launch(url);
                      },
                      child: ListTile(
                        leading: Icon(Icons.video_collection),
                        title: Text(
                          S.of(context).howWeWork,
                        ),
                      )),
                companyInfo != null ? GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ComunityScreen(role==UserRole.ROLE_CAPTAIN ? companyInfo.toJsonCaptain() :companyInfo.toJson());
                        }));
                      },
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text(
                          S.of(context).social,
                        ),
                      )):Container(),
                ],
              ),
              Container(
                height: 48,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //     icon: Icon(
                    //       Icons.phone,
                    //     ),
                    //     onPressed: () {
                    //       launch('tel:$phone');
                    //     }),
                    //   IconButton(
                    //       icon: FaIcon(
                    //         FontAwesomeIcons.whatsapp,
                    //       ),
                    //       onPressed: () {
                    //         launch('https://wa.me/$whatsapp');
                    //       }),
                    // //   IconButton(
                    //       icon: FaIcon(
                    //         FontAwesomeIcons.facebook,
                    //       ),
                    //       onPressed: () {}),
                    //   IconButton(
                    //       icon: FaIcon(
                    //         FontAwesomeIcons.twitter,
                    //       ),
                    //       onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
