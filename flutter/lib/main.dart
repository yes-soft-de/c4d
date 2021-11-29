import 'dart:async';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_about/about_module.dart';
import 'package:c4d/module_chat/chat_module.dart';
import 'package:c4d/module_init/init_account_module.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_notifications/model/notification_ios_model.dart';
import 'package:c4d/module_notifications/model/notification_model.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:c4d/module_plan/plan_module.dart';
import 'package:c4d/module_profile/module_profile.dart';
import 'package:c4d/module_splash/splash_module.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/helper/global_key.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:soundpool/soundpool.dart';
import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_auth/authoriazation_module.dart';
import 'module_notifications/service/local_notification_service/local_notification_service.dart';
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
      new Logger().error('Main', details.toString(), StackTrace.current);
    };
    await runZoned<Future<void>>(() async {
      // Your App Here
      runApp(container.app);
    }, onError: (error, stackTrace) {
      new Logger().error(
          'Main', error.toString() + stackTrace.toString(), StackTrace.current);
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
  final FireNotificationService _fireNotificationService;
  final PlanModule _planModule;
  final LocalNotificationService _localNotificationService;
  MyApp(
      this._themeDataService,
      this._localizationService,
      this._ordersModule,
      this._chatModule,
      this._aboutModule,
      this._splashModule,
      this._fireNotificationService,
      this._initAccountModule,
      this._settingsModule,
      this._authorizationModule,
      this._profileModule,
      this._planModule,
      this._localNotificationService);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  Soundpool pool = Soundpool(streamType: StreamType.notification);

  //Initialisation of local notification

  //end
  String lang;
  ThemeData activeTheme;
  bool authorized = false;
  int soundId;
  @override
  void initState() {
    super.initState();
    widget._fireNotificationService.init();
    widget._localNotificationService.init();
    if (Platform.isIOS) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        soundId = await rootBundle
            .load('assets/rington.mp3')
            .then((ByteData soundData) {
          return pool.load(soundData);
        });
      });
    }
    widget._localizationService.localizationStream.listen((event) {
      timeago.setDefaultLocale(event);
      setState(() {});
    });
    widget._fireNotificationService.onNotificationStream.listen((event) async {
      NotificationModel model;
      if (Platform.isAndroid) {
        model = NotificationModel.fromJson(event);
      }
      if (Platform.isIOS) {
        Logger().error('event', event.toString() , StackTrace.current);
        NotificationIosModel iosModel = NotificationIosModel.fromJson(event);
        model = NotificationModel(
            body: iosModel?.aps?.alert?.body,
            title: iosModel?.aps?.alert?.title);
      }
      widget._localNotificationService.showNotification(model);
      if (Platform.isIOS) {
        if (soundId != null) {
          await pool.play(soundId);
        }
        await Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: model.title,
          message: model.body ?? S.current.newMessageCommingOut,
          shouldIconPulse: false,
          icon: Image.asset('assets/images/icon.jpg'),
        ).show(GlobalVariable.navState.currentContext);
      }
    });
    widget._localNotificationService.onLocalNotificationStream.listen((event) {
      Navigator.pushNamed(
          GlobalVariable.navState.currentContext, event.clickAction.toString(),
          arguments: event?.argument);
    });
    widget._themeDataService.darkModeStream.listen((event) {
      activeTheme = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: Scaffold(),
      future: getConfiguratedApp(YesModule.RoutesMap),
      builder: (BuildContext context, AsyncSnapshot<Widget> scaffoldSnapshot) {
        return scaffoldSnapshot.data;
      },
    );
  }

  Future<Widget> getConfiguratedApp(
    Map<String, WidgetBuilder> fullRoutesList,
  ) async {
    var activeLanguage = await widget._localizationService.getLanguage();
    var theme = await widget._themeDataService.getActiveTheme();
    return MaterialApp(
      navigatorKey: GlobalVariable.navState,
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
