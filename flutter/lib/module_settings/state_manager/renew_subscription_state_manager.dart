import 'package:c4d/module_init/service/init_account/init_account.service.dart';
import 'package:c4d/module_settings/ui/settings_page/renew_subscription/screen/renew_subscription.dart';
import 'package:c4d/module_settings/ui/settings_page/renew_subscription/state/renew_subscription_state.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class RenewSubscriptionStateManager {
  final InitAccountService _initAccountService;

  final PublishSubject<RenewPcakageSubscriptionState> _stateSubject =
      PublishSubject<RenewPcakageSubscriptionState>();

  Stream<RenewPcakageSubscriptionState> get stateStream => _stateSubject.stream;

  RenewSubscriptionStateManager(
    this._initAccountService,
  );

  void subscribePackage(RenewSubscriptionScreenState screen, int packageId) {
    _stateSubject.add(
      RenewPcakageSubscriptionStateLoading(screen),
    );
    _initAccountService.renewPackage(packageId).then((value) {
      if (value) {
        screen.moveToNext(value);
      } else {
        screen.moveToNext(value);
      }
    });
  }

  void getPackages(RenewSubscriptionScreenState screen) {
    _stateSubject.add(RenewPcakageSubscriptionStateLoading(screen));

    _initAccountService.getPackages().then((value) {
      if (value == null) {
        _stateSubject.add(RenewPcakageSubscriptionStateError(
            'Error Fetching Packages', screen));
      } else {
        _stateSubject.add(RenewPcakageSubscriptionStateLoaded(value, screen));
      }
    });
  }
}
