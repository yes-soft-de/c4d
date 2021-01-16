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
import '../../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i20;
import '../../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i21;
import '../../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i22;
import '../../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i23;
import '../../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i24;
import '../../module_orders/ui/screens/captain_orders/captain_orders.dart'
    as _i25;
import '../../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i26;
import '../../module_chat/chat_module.dart' as _i27;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i28;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i29;
import '../../module_chat/service/chat/char_service.dart' as _i30;
import '../../module_chat/manager/chat/chat_manager.dart' as _i31;
import '../../module_chat/repository/chat/chat_repository.dart' as _i32;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i33;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i34;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i35;
import '../../module_init/init_account_module.dart' as _i36;
import '../../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i37;
import '../../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i38;
import '../../module_init/service/init_account/init_account.service.dart'
    as _i39;
import '../../module_init/manager/init_account/init_account.manager.dart'
    as _i40;
import '../../module_init/repository/init_account/init_account.repository.dart'
    as _i41;
import '../../module_profile/service/profile/profile.service.dart' as _i42;
import '../../module_profile/manager/profile/profile.manager.dart' as _i43;
import '../../module_profile/repository/profile/profile.repository.dart'
    as _i44;
import '../../module_settings/settings_module.dart' as _i45;
import '../../module_settings/ui/settings_page/settings_page.dart' as _i46;
import '../../module_auth/authoriazation_module.dart' as _i47;
import '../../module_auth/ui/screen/login_screen/login_screen.dart' as _i48;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i49;
import '../../module_auth/ui/screen/register_screen/register_screen.dart'
    as _i50;

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
      _createInitAccountModule(),
      _createSettingsModule(),
      _createAuthorizationModule());
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
      _i11.NewOrderStateManager(_createOrdersService());
  _i12.OrdersService _createOrdersService() =>
      _i12.OrdersService(_createOrdersManager());
  _i13.OrdersManager _createOrdersManager() =>
      _i13.OrdersManager(_createOrderRepository());
  _i14.OrderRepository _createOrderRepository() =>
      _i14.OrderRepository(_createApiClient(), _createAuthService());
  _i15.ApiClient _createApiClient() => _i15.ApiClient(_createLogger());
  _i3.Logger _createLogger() => _singletonLogger ??= _i3.Logger();
  _i16.AuthService _createAuthService() => _i16.AuthService(
      _createAuthPrefsHelper(),
      _createAuthManager(),
      _createFireNotificationService());
  _i17.AuthPrefsHelper _createAuthPrefsHelper() => _i17.AuthPrefsHelper();
  _i18.AuthManager _createAuthManager() =>
      _i18.AuthManager(_createAuthRepository());
  _i19.AuthRepository _createAuthRepository() =>
      _i19.AuthRepository(_createApiClient());
  _i20.FireNotificationService _createFireNotificationService() =>
      _i20.FireNotificationService();
  _i21.OrderStatusScreen _createOrderStatusScreen() =>
      _i21.OrderStatusScreen(_createOrderStatusStateManager());
  _i22.OrderStatusStateManager _createOrderStatusStateManager() =>
      _i22.OrderStatusStateManager(
          _createOrdersService(), _createAuthService());
  _i23.OwnerOrdersScreen _createOwnerOrdersScreen() =>
      _i23.OwnerOrdersScreen(_createOwnerOrdersStateManager());
  _i24.OwnerOrdersStateManager _createOwnerOrdersStateManager() =>
      _i24.OwnerOrdersStateManager(
          _createOrdersService(), _createAuthService());
  _i25.CaptainOrdersScreen _createCaptainOrdersScreen() =>
      _i25.CaptainOrdersScreen(_createCaptainOrdersListStateManager());
  _i26.CaptainOrdersListStateManager _createCaptainOrdersListStateManager() =>
      _i26.CaptainOrdersListStateManager(
          _createOrdersService(), _createAuthService());
  _i27.ChatModule _createChatModule() =>
      _i27.ChatModule(_createChatPage(), _createAuthService());
  _i28.ChatPage _createChatPage() => _i28.ChatPage(
      _createChatPageBloc(), _createAuthService(), _createImageUploadService());
  _i29.ChatPageBloc _createChatPageBloc() =>
      _i29.ChatPageBloc(_createChatService());
  _i30.ChatService _createChatService() =>
      _i30.ChatService(_createChatManager());
  _i31.ChatManager _createChatManager() =>
      _i31.ChatManager(_createChatRepository());
  _i32.ChatRepository _createChatRepository() => _i32.ChatRepository();
  _i33.ImageUploadService _createImageUploadService() =>
      _i33.ImageUploadService(_createUploadManager());
  _i34.UploadManager _createUploadManager() =>
      _i34.UploadManager(_createUploadRepository());
  _i35.UploadRepository _createUploadRepository() => _i35.UploadRepository();
  _i36.InitAccountModule _createInitAccountModule() =>
      _i36.InitAccountModule(_createInitAccountScreen());
  _i37.InitAccountScreen _createInitAccountScreen() =>
      _i37.InitAccountScreen(_createInitAccountStateManager());
  _i38.InitAccountStateManager _createInitAccountStateManager() =>
      _i38.InitAccountStateManager(
          _createInitAccountService(), _createProfileService());
  _i39.InitAccountService _createInitAccountService() =>
      _i39.InitAccountService(_createInitAccountManager());
  _i40.InitAccountManager _createInitAccountManager() =>
      _i40.InitAccountManager(_createInitAccountRepository());
  _i41.InitAccountRepository _createInitAccountRepository() =>
      _i41.InitAccountRepository(_createApiClient(), _createAuthService());
  _i42.ProfileService _createProfileService() =>
      _i42.ProfileService(_createProfileManager());
  _i43.ProfileManager _createProfileManager() =>
      _i43.ProfileManager(_createProfileRepository());
  _i44.ProfileRepository _createProfileRepository() =>
      _i44.ProfileRepository(_createApiClient(), _createAuthService());
  _i45.SettingsModule _createSettingsModule() =>
      _i45.SettingsModule(_createSettingsScreen());
  _i46.SettingsScreen _createSettingsScreen() => _i46.SettingsScreen(
      _createAuthService(),
      _createLocalizationService(),
      _createAppThemeDataService());
  _i47.AuthorizationModule _createAuthorizationModule() =>
      _i47.AuthorizationModule(_createLoginScreen(), _createRegisterScreen());
  _i48.LoginScreen _createLoginScreen() =>
      _i48.LoginScreen(_createAuthStateManager());
  _i49.AuthStateManager _createAuthStateManager() =>
      _i49.AuthStateManager(_createAuthService());
  _i50.RegisterScreen _createRegisterScreen() =>
      _i50.RegisterScreen(_createAuthStateManager());
  @override
  _i6.MyApp get app => _createMyApp();
}
