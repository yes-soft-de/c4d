import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_booking_success.dart';
import 'package:c4d/module_about/ui/states/about/about_state_loading.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_captain.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_init.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_owner.dart';
import 'package:c4d/module_about/ui/states/about/about_state_request_appointment.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_init/service/init_account/init_account.service.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AboutScreenStateManager {
  final LocalizationService _localizationService;
  final AboutService _aboutService;
  final InitAccountService _initAccountService;

  final stateStack = <AboutState>[];
  final _stateSubject = PublishSubject<AboutState>();

  AboutScreen _screen;

  Stream<AboutState> get stateStream => _stateSubject.stream;

  AboutState initialState(AboutScreen screen) {
    _screen = screen;
    return AboutStatePageInit(this);
  }

  AboutScreenStateManager(
    this._localizationService,
    this._aboutService,
    this._initAccountService,
  );

  void init(AboutScreen screen) => _screen;

  void setLanguage(String lang) {
    _localizationService.setLanguage(lang);
  }

  void requestBooking() {
    _stateSubject.add(AboutStateRequestBooking(this));
  }

  void moveNext(UserRole role) {
    if (role == UserRole.ROLE_OWNER) {
      _stateSubject.add(AboutStateLoading(this));
      _initAccountService.getPackages().then((packages) {
        _stateSubject.add(AboutStatePageOwner(this, packages));
      });
    } else {
      _stateSubject.add(AboutStatePageCaptain(this));
    }
  }

  void showSnackBar(String msg) => _screen.showSnackBar(msg);

  void createAppointment(String name, String phone) {
    _aboutService.createAppointment(name, phone).then((value) {
      _stateSubject.add(AboutStatePageOwnerBookingSuccess(this));
    });
  }

  void refresh(AboutState state) {
    _stateSubject.add(state);
  }
}
