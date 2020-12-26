
import 'package:c4d/module_authorization/authoriazation_module.dart';
import 'package:c4d/module_init/init_account_module.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_authorization/authorization_routes.dart';

typedef Provider<T> = T Function();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    runApp(container.app);
  });
}

@provide
class MyApp extends StatefulWidget {
  final InitAccountModule _initAccountModule;
  final AuthorizationModule _authorizationModule;
  final OrdersModule _ordersModule;

  MyApp(
      this._ordersModule,
      this._authorizationModule,
      this._initAccountModule,
      );

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  static FirebaseAnalytics analytics = FirebaseAnalytics();
//  static FirebaseAnalyticsObserver observer =
//  FirebaseAnalyticsObserver(analytics: analytics);

  String lang;
  bool isDarkMode;
  bool authorized = false;

  @override
  void initState() {
    super.initState();

//    widget._localizationService.localizationStream.listen((event) {
//      setState(() {});
//    });
//
//    widget._swapThemeService.darkModeStream.listen((event) {
//      isDarkMode = event;
//      setState(() {});
//    });
  }


  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = {};

    fullRoutesList.addAll(widget._initAccountModule.getRoutes());
    fullRoutesList.addAll(widget._authorizationModule.getRoutes());
    fullRoutesList.addAll(widget._ordersModule.getRoutes());


//    widget._swapThemeService.isDarkMode().then((value) {
//      isDarkMode  = value ?? false;
//    });

    return FutureBuilder(
      future: getConfiguratedApp(fullRoutesList),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) return snapshot.data;
        return Scaffold();
      },
    );
  }

  Future<Widget> getConfiguratedApp(
      Map<String, WidgetBuilder> fullRoutesList) async {
//    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);



    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      navigatorObservers: <NavigatorObserver>[observer],
      locale: Locale.fromSubtags(
        languageCode: 'ar',
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: isDarkMode == true
          ? ThemeData(
          brightness: Brightness.dark,
//          scaffoldBackgroundColor: SwapThemeDataService.getDarkBGColor(),
          fontFamily: 'RB'
      )
          : ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          fontFamily: 'RB'
      ),
      supportedLocales: S.delegate.supportedLocales,
      title: 'c4d',
      routes: fullRoutesList,
      initialRoute: AuthorizationRoutes.AUTHORIZATION_SCREEN,
    );
  }
}
