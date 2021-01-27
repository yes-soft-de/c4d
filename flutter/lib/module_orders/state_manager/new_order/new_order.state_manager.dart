import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/state/new_order/new_order.state.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

@provide
class NewOrderStateManager {
  final OrdersService _service;
  final ProfileService _profileService;
  final PublishSubject<NewOrderState> _stateSubject = new PublishSubject();

  Stream<NewOrderState> get stateStream => _stateSubject.stream;

  NewOrderStateManager(this._service, this._profileService);

  void loadBranches(NewOrderScreenState screenState, LatLng location) {
    _profileService.getMyBranches().then((value) {
      _stateSubject.add(NewOrderStateBranchesLoaded(value, location, screenState));
    });
  }

  void addNewOrder(
      Branch fromBranch,
      GeoJson destination,
      String note,
      String paymentMethod,
      String recipientName,
      String recipientPhone,
      String date,
      NewOrderScreenState screenState) {
    _service
        .addNewOrder(fromBranch, destination, note, paymentMethod,
            recipientName, recipientPhone, date)
        .then((newOrder) {
      if (newOrder) {
        _stateSubject.add(NewOrderStateSuccessState(screenState));
      } else {
        _stateSubject
            .add(NewOrderStateErrorState('Error Creating Order', screenState));
      }
    });
  }
}
