import 'dart:convert';

import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
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

  Stream<OwnerOrdersListState> get stateStream => _stateSubject.stream;

  Stream<ProfileResponseModel> get profileStream => _profileSubject.stream;

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
      print('${value.cars} ${orders.length}');
      _stateSubject.add(OrdersListStateOrdersLoaded(
          orders, value.cars > orders.length, screenState));
    });
  }
}
