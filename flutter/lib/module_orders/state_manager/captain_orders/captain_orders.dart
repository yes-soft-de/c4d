import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_error.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_loading.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_unauthorized.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_orders_loaded.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class CaptainOrdersListStateManager {
  final OrdersService _ordersService;
  final ProfileService _profileService;

  final PublishSubject<CaptainOrdersListState> _stateSubject = PublishSubject();
  final PublishSubject<ProfileResponseModel> _profileSubject = PublishSubject();
  final PublishSubject<CompanyInfoResponse> _companySubject = PublishSubject();
  Stream<ProfileResponseModel> get profileStream => _profileSubject.stream;
  Stream<CaptainOrdersListState> get stateStream => _stateSubject.stream;
  Stream<CompanyInfoResponse> get companyStream => _companySubject.stream;

  CaptainOrdersListStateManager(this._ordersService, this._profileService);

  void getProfile() {
    _profileService
        .getProfile()
        .then((profile) => _profileSubject.add(profile));
  }

  void getMyOrders(CaptainOrdersScreenState screenState) {
    CaptainOrdersListStateLoading(screenState);
    Future.wait([
      _ordersService.getNearbyOrders(),
      _ordersService.getCaptainOrders(),
      _ordersService.getCaptainStatus()
    ]).then((value) {
      _stateSubject.add(CaptainOrdersListStateOrdersLoaded(
          screenState, value[0], value[1], value[2]));
    }).catchError((e) {
      if (e is UnauthorizedException) {
        _stateSubject.add(CaptainOrdersListStateUnauthorized(screenState));
      } else {
        _stateSubject
            .add(CaptainOrdersListStateError(e.toString(), screenState));
      }
    });
  }

  void companyInfo() {
    _ordersService.getCompanyInfo().then((info) => _companySubject.add(info));
  }
}
