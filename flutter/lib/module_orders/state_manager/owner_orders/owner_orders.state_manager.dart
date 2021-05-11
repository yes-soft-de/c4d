import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/screens/terms/terms.dart';
import 'package:c4d/module_orders/ui/screens/update/update.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_orders/ui/state/terms/terms_state.dart';
import 'package:c4d/module_orders/ui/state/update/update_state.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';

@provide
class OwnerOrdersStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;
  final ProfileService _profileService;
  final PlanService _planService;

  final PublishSubject<OwnerOrdersListState> _stateSubject = PublishSubject();
  final PublishSubject<ProfileResponseModel> _profileSubject = PublishSubject();
  final PublishSubject<CompanyInfoResponse> _companySubject = PublishSubject();
  final PublishSubject<UpdateListState> _updateStateSubject = PublishSubject();
  final PublishSubject<TermsListState> _termsStateSubject = PublishSubject();

  Stream<OwnerOrdersListState> get stateStream => _stateSubject.stream;

  Stream<ProfileResponseModel> get profileStream => _profileSubject.stream;

  Stream<CompanyInfoResponse> get companyStream => _companySubject.stream;

  Stream<UpdateListState> get updateStram => _updateStateSubject.stream;
  Stream<TermsListState> get termsStream => _termsStateSubject.stream;

  OwnerOrdersStateManager(
    this._ordersService,
    this._authService,
    this._profileService,
    this._planService,
  );

  void getProfile() {
    _profileService
        .getProfile()
        .then((profile) => _profileSubject.add(profile));
  }

  void getMyOrders(OwnerOrdersScreenState screenState) {
    _authService.isLoggedIn.then((value) {
      if (value) {
        _stateSubject.add(OrdersListStateLoading(screenState));
        _ordersService.getMyOrders().then((value) {
          if (value == null) {
            _stateSubject
                .add(OrdersListStateError('Error Finding Data', screenState));
          } else {
            isNewOrderAvailable(value, screenState);
          }
        });
      } else {
        _stateSubject.add(OrdersListStateUnauthorized(screenState));
      }
    });
  }

  void isNewOrderAvailable(
      List<OrderModel> orders, OwnerOrdersScreenState screenState) {
    _planService.getOwnerCurrentPlan().then((value) {
      if (value != null) {
        bool can = false;
        if (value.cars == 0) {
          can = true;
        } else {
          can = value.cars > orders.length;
        }
        _stateSubject
            .add(OrdersListStateOrdersLoaded(orders, can, screenState));
      } else {
        _stateSubject
            .add(OrdersListStateError('not verified', screenState));
      }
    });
  }

  void companyInfo() {
    _ordersService.getCompanyInfo().then((info) => _companySubject.add(info));
  }

  void getUpdates(UpdateScreenState screenState) {
    _updateStateSubject.add(UpdateListStateLoading(screenState));
    _ordersService.getUpdates().then((value) {
      _updateStateSubject.add(UpdateListStateInit(value, screenState));
    });
  }

  void getTerms(TermsScreenState screenState) {
    _termsStateSubject.add(TermsListStateLoading(screenState));
    _profileService.getTerms().then((value) {
      _termsStateSubject.add(TermsListStateInit(value, screenState));
    });
  }
}
