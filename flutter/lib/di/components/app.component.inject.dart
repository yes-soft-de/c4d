import 'app.component.dart' as _i1;
import '../../module_localization/service/localization_service/localization_service.dart'
    as _i2;
import '../../utils/logger/logger.dart' as _i3;
import '../../module_orders/orders_module.dart' as _i4;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;
import '../../module_theme/service/theme_service/theme_service.dart' as _i7;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i8;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../../module_orders/ui/screens/new_order/new_order_screen.dart' as _i10;
import '../../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i11;
import '../../module_orders/service/orders/orders.service.dart' as _i12;
import '../../module_orders/manager/orders_manager/orders_manager.dart' as _i13;
import '../../module_orders/repository/order_repository/order_repository.dart'
    as _i14;
import '../../module_network/http_client/http_client.dart' as _i15;
import '../../module_auth/service/auth_service/auth_service.dart' as _i16;
import '../../module_auth/presistance/auth_prefs_helper.dart' as _i17;
import '../../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../../module_about/service/about_service/about_service.dart' as _i20;
import '../../module_about/manager/about_manager.dart' as _i21;
import '../../module_about/repository/about_repository.dart' as _i22;
import '../../module_profile/service/profile/profile.service.dart' as _i23;
import '../../module_profile/manager/profile/profile.manager.dart' as _i24;
import '../../module_profile/repository/profile/profile.repository.dart'
    as _i25;
import '../../module_profile/prefs_helper/profile_prefs_helper.dart' as _i26;
import '../../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i27;
import '../../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i28;
import '../../module_report/service/report_service.dart' as _i29;
import '../../module_report/manager/report_manager.dart' as _i30;
import '../../module_report/repository/report_repository.dart' as _i31;
import '../../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i32;
import '../../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i33;
import '../../module_plan/service/plan_service.dart' as _i34;
import '../../module_plan/manager/package_balance_manager.dart' as _i35;
import '../../module_plan/repository/package_balance_repository.dart' as _i36;
import '../../module_orders/ui/screens/captain_orders/captain_orders.dart'
    as _i37;
import '../../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i38;
import '../../module_chat/chat_module.dart' as _i39;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i40;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i41;
import '../../module_chat/service/chat/char_service.dart' as _i42;
import '../../module_chat/manager/chat/chat_manager.dart' as _i43;
import '../../module_chat/repository/chat/chat_repository.dart' as _i44;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i45;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i46;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i47;
import '../../module_about/about_module.dart' as _i48;
import '../../module_about/state_manager/about_screen_state_manager.dart'
    as _i49;
import '../../module_init/service/init_account/init_account.service.dart'
    as _i50;
import '../../module_init/manager/init_account/init_account.manager.dart'
    as _i51;
import '../../module_init/repository/init_account/init_account.repository.dart'
    as _i52;
import '../../module_splash/splash_module.dart' as _i53;
import '../../module_splash/ui/screen/splash_screen.dart' as _i54;
import '../../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i55;
import '../../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i56;
import '../../module_notifications/repository/notification_repo.dart' as _i57;
import '../../module_init/init_account_module.dart' as _i58;
import '../../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i59;
import '../../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i60;
import '../../module_settings/settings_module.dart' as _i61;
import '../../module_settings/ui/settings_page/settings_page.dart' as _i62;
import '../../module_auth/authoriazation_module.dart' as _i63;
import '../../module_auth/ui/screen/login_screen/login_screen.dart' as _i64;
import '../../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i65;
import '../../module_auth/ui/screen/register_screen/register_screen.dart'
    as _i66;
import '../../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i67;
import '../../module_profile/module_profile.dart' as _i68;
import '../../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i69;
import '../../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i70;
import '../../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i71;
import '../../module_profile/state_manager/edit_profile/edit_profile.dart'
    as _i72;
import '../../module_plan/plan_module.dart' as _i73;
import '../../module_plan/ui/screen/plan_screen.dart' as _i74;
import '../../module_plan/state_manager/plan_screen_state_manager.dart' as _i75;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.LocalizationService _singletonLocalizationService;

  _i3.Logger _singletonLogger;

  _i4.OrdersModule _singletonOrdersModule;

  static _i5.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i6.MyApp _createMyApp() => _i6.MyApp(
      _createAppThemeDataService(),
      _createLocalizationService(),
      _createOrdersModule(),
      _createChatModule(),
      _createAboutModule(),
      _createSplashModule(),
      _createFireNotificationService(),
      _createInitAccountModule(),
      _createSettingsModule(),
      _createAuthorizationModule(),
      _createProfileModule(),
      _createPlanModule());
  _i7.AppThemeDataService _createAppThemeDataService() =>
      _i7.AppThemeDataService(_createThemePreferencesHelper());
  _i8.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i8.ThemePreferencesHelper();
  _i2.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i2.LocalizationService(_createLocalizationPreferencesHelper());
  _i9.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i9.LocalizationPreferencesHelper();
  _i4.OrdersModule _createOrdersModule() =>
      _singletonOrdersModule ??= _i4.OrdersModule(
          _createNewOrderScreen(),
          _createOrderStatusScreen(),
          _createOwnerOrdersScreen(),
          _createCaptainOrdersScreen());
  _i10.NewOrderScreen _createNewOrderScreen() =>
      _i10.NewOrderScreen(_createNewOrderStateManager());
  _i11.NewOrderStateManager _createNewOrderStateManager() =>
      _i11.NewOrderStateManager(
          _createOrdersService(), _createProfileService());
  _i12.OrdersService _createOrdersService() =>
      _i12.OrdersService(_createOrdersManager(), _createProfileService());
  _i13.OrdersManager _createOrdersManager() =>
      _i13.OrdersManager(_createOrderRepository());
  _i14.OrderRepository _createOrderRepository() =>
      _i14.OrderRepository(_createApiClient(), _createAuthService());
  _i15.ApiClient _createApiClient() => _i15.ApiClient(_createLogger());
  _i3.Logger _createLogger() => _singletonLogger ??= _i3.Logger();
  _i16.AuthService _createAuthService() => _i16.AuthService(
      _createAuthPrefsHelper(), _createAuthManager(), _createAboutService());
  _i17.AuthPrefsHelper _createAuthPrefsHelper() => _i17.AuthPrefsHelper();
  _i18.AuthManager _createAuthManager() =>
      _i18.AuthManager(_createAuthRepository());
  _i19.AuthRepository _createAuthRepository() =>
      _i19.AuthRepository(_createApiClient());
  _i20.AboutService _createAboutService() =>
      _i20.AboutService(_createAboutManager());
  _i21.AboutManager _createAboutManager() =>
      _i21.AboutManager(_createAboutRepository());
  _i22.AboutRepository _createAboutRepository() =>
      _i22.AboutRepository(_createApiClient());
  _i23.ProfileService _createProfileService() => _i23.ProfileService(
      _createProfileManager(),
      _createProfilePreferencesHelper(),
      _createAuthService());
  _i24.ProfileManager _createProfileManager() =>
      _i24.ProfileManager(_createProfileRepository());
  _i25.ProfileRepository _createProfileRepository() =>
      _i25.ProfileRepository(_createApiClient(), _createAuthService());
  _i26.ProfilePreferencesHelper _createProfilePreferencesHelper() =>
      _i26.ProfilePreferencesHelper();
  _i27.OrderStatusScreen _createOrderStatusScreen() =>
      _i27.OrderStatusScreen(_createOrderStatusStateManager());
  _i28.OrderStatusStateManager _createOrderStatusStateManager() =>
      _i28.OrderStatusStateManager(
          _createOrdersService(), _createAuthService(), _createReportService());
  _i29.ReportService _createReportService() =>
      _i29.ReportService(_createReportManager());
  _i30.ReportManager _createReportManager() =>
      _i30.ReportManager(_createReportRepository());
  _i31.ReportRepository _createReportRepository() =>
      _i31.ReportRepository(_createApiClient(), _createAuthService());
  _i32.OwnerOrdersScreen _createOwnerOrdersScreen() =>
      _i32.OwnerOrdersScreen(_createOwnerOrdersStateManager());
  _i33.OwnerOrdersStateManager _createOwnerOrdersStateManager() =>
      _i33.OwnerOrdersStateManager(_createOrdersService(), _createAuthService(),
          _createProfileService(), _createPlanService());
  _i34.PlanService _createPlanService() => _i34.PlanService(
      _createOrdersService(),
      _createProfileService(),
      _createPackageBalanceManager());
  _i35.PackageBalanceManager _createPackageBalanceManager() =>
      _i35.PackageBalanceManager(_createPackageBalanceRepository());
  _i36.PackageBalanceRepository _createPackageBalanceRepository() =>
      _i36.PackageBalanceRepository(_createAuthService());
  _i37.CaptainOrdersScreen _createCaptainOrdersScreen() =>
      _i37.CaptainOrdersScreen(_createCaptainOrdersListStateManager());
  _i38.CaptainOrdersListStateManager _createCaptainOrdersListStateManager() =>
      _i38.CaptainOrdersListStateManager(
          _createOrdersService(), _createProfileService());
  _i39.ChatModule _createChatModule() =>
      _i39.ChatModule(_createChatPage(), _createAuthService());
  _i40.ChatPage _createChatPage() =>
      _i40.ChatPage(_createChatPageBloc(), _createImageUploadService());
  _i41.ChatPageBloc _createChatPageBloc() =>
      _i41.ChatPageBloc(_createChatService());
  _i42.ChatService _createChatService() =>
      _i42.ChatService(_createChatManager());
  _i43.ChatManager _createChatManager() =>
      _i43.ChatManager(_createChatRepository());
  _i44.ChatRepository _createChatRepository() => _i44.ChatRepository();
  _i45.ImageUploadService _createImageUploadService() =>
      _i45.ImageUploadService(_createUploadManager());
  _i46.UploadManager _createUploadManager() =>
      _i46.UploadManager(_createUploadRepository());
  _i47.UploadRepository _createUploadRepository() => _i47.UploadRepository();
  _i48.AboutModule _createAboutModule() =>
      _i48.AboutModule(_createAboutScreenStateManager());
  _i49.AboutScreenStateManager _createAboutScreenStateManager() =>
      _i49.AboutScreenStateManager(_createLocalizationService(),
          _createAboutService(), _createInitAccountService());
  _i50.InitAccountService _createInitAccountService() =>
      _i50.InitAccountService(_createInitAccountManager());
  _i51.InitAccountManager _createInitAccountManager() =>
      _i51.InitAccountManager(_createInitAccountRepository());
  _i52.InitAccountRepository _createInitAccountRepository() =>
      _i52.InitAccountRepository(_createApiClient(), _createAuthService());
  _i53.SplashModule _createSplashModule() =>
      _i53.SplashModule(_createSplashScreen());
  _i54.SplashScreen _createSplashScreen() => _i54.SplashScreen(
      _createAuthService(), _createAboutService(), _createProfileService());
  _i55.FireNotificationService _createFireNotificationService() =>
      _i55.FireNotificationService(_createNotificationsPrefsHelper(),
          _createProfileService(), _createNotificationRepo());
  _i56.NotificationsPrefsHelper _createNotificationsPrefsHelper() =>
      _i56.NotificationsPrefsHelper();
  _i57.NotificationRepo _createNotificationRepo() =>
      _i57.NotificationRepo(_createApiClient(), _createAuthService());
  _i58.InitAccountModule _createInitAccountModule() =>
      _i58.InitAccountModule(_createInitAccountScreen());
  _i59.InitAccountScreen _createInitAccountScreen() =>
      _i59.InitAccountScreen(_createInitAccountStateManager());
  _i60.InitAccountStateManager _createInitAccountStateManager() =>
      _i60.InitAccountStateManager(
          _createInitAccountService(),
          _createProfileService(),
          _createAuthService(),
          _createImageUploadService());
  _i61.SettingsModule _createSettingsModule() =>
      _i61.SettingsModule(_createSettingsScreen());
  _i62.SettingsScreen _createSettingsScreen() => _i62.SettingsScreen(
      _createAuthService(),
      _createLocalizationService(),
      _createAppThemeDataService(),
      _createProfileService(),
      _createFireNotificationService());
  _i63.AuthorizationModule _createAuthorizationModule() =>
      _i63.AuthorizationModule(_createLoginScreen(), _createRegisterScreen());
  _i64.LoginScreen _createLoginScreen() =>
      _i64.LoginScreen(_createLoginStateManager());
  _i65.LoginStateManager _createLoginStateManager() =>
      _i65.LoginStateManager(_createAuthService(), _createProfileService());
  _i66.RegisterScreen _createRegisterScreen() =>
      _i66.RegisterScreen(_createRegisterStateManager());
  _i67.RegisterStateManager _createRegisterStateManager() =>
      _i67.RegisterStateManager(_createAuthService(), _createAboutService());
  _i68.ProfileModule _createProfileModule() =>
      _i68.ProfileModule(_createActivityScreen(), _createEditProfileScreen());
  _i69.ActivityScreen _createActivityScreen() =>
      _i69.ActivityScreen(_createActivityStateManager());
  _i70.ActivityStateManager _createActivityStateManager() =>
      _i70.ActivityStateManager(_createProfileService(), _createAuthService());
  _i71.EditProfileScreen _createEditProfileScreen() =>
      _i71.EditProfileScreen(_createEditProfileStateManager());
  _i72.EditProfileStateManager _createEditProfileStateManager() =>
      _i72.EditProfileStateManager(_createImageUploadService(),
          _createProfileService(), _createAuthService());
  _i73.PlanModule _createPlanModule() => _i73.PlanModule(_createPlanScreen());
  _i74.PlanScreen _createPlanScreen() =>
      _i74.PlanScreen(_createPlanScreenStateManager());
  _i75.PlanScreenStateManager _createPlanScreenStateManager() =>
      _i75.PlanScreenStateManager(_createPlanService(), _createAuthService());
  @override
  _i6.MyApp get app => _createMyApp();
}
