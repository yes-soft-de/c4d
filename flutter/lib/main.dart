import 'dart:async';

import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_about/about_module.dart';
import 'package:c4d/module_chat/chat_module.dart';
import 'package:c4d/module_init/init_account_module.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:c4d/module_profile/module_profile.dart';
import 'package:c4d/module_splash/splash_module.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/logger/logger.dart';
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
import 'module_auth/authoriazation_module.dart';
import 'module_settings/settings_module.dart';
import 'module_splash/splash_routes.dart';

import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await timeago.setLocaleMessages('ar', timeago.ArMessages());
  await timeago.setLocaleMessages('en', timeago.EnMessages());
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    FlutterError.onError = (FlutterErrorDetails details) async {
      new Logger().error('Main', details.toString());
    };
    await runZoned<Future<void>>(() async {
      // Your App Here
      runApp(container.app);
    }, onError: (error, stackTrace) {
      new Logger().error('Main', error.toString() + stackTrace.toString());
    });
  });
}

@provide
class MyApp extends StatefulWidget {
  final AppThemeDataService _themeDataService;
  final LocalizationService _localizationService;
  final OrdersModule _ordersModule;
  final ChatModule _chatModule;
  final InitAccountModule _initAccountModule;
  final SettingsModule _settingsModule;
  final AuthorizationModule _authorizationModule;
  final SplashModule _splashModule;
  final ProfileModule _profileModule;
  final AboutModule _aboutModule;

  MyApp(
    this._themeDataService,
    this._localizationService,
    this._ordersModule,
    this._chatModule,
    this._aboutModule,
    this._splashModule,
    this._initAccountModule,
    this._settingsModule,
    this._authorizationModule,
    this._profileModule,
  );

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  String lang;
  ThemeData activeTheme;
  bool authorized = false;

  @override
  void initState() {
    super.initState();
    widget._localizationService.localizationStream.listen((event) {
      timeago.setDefaultLocale(event);
      setState(() {});
    });

    widget._themeDataService.darkModeStream.listen((event) {
      activeTheme = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: ThemeData.light(),
      future: widget._themeDataService.getActiveTheme(),
      builder: (BuildContext context, AsyncSnapshot<ThemeData> themeSnapshot) {
        return FutureBuilder(
            initialData: 'en',
            future: widget._localizationService.getLanguage(),
            builder:
                (BuildContext context, AsyncSnapshot<String> langSnapshot) {
              return getConfiguratedApp(
                YesModule.RoutesMap,
                themeSnapshot.data,
                langSnapshot.data,
              );
            });
      },
    );
  }

  Widget getConfiguratedApp(
    Map<String, WidgetBuilder> fullRoutesList,
    ThemeData theme,
    String activeLanguage,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      locale: Locale.fromSubtags(
        languageCode: activeLanguage,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: theme,
      supportedLocales: S.delegate.supportedLocales,
      title: 'C4D',
      routes: fullRoutesList,
      initialRoute: SplashRoutes.SPLASH_SCREEN,
    );
  }
}
