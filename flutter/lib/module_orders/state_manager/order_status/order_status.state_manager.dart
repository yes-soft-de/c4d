import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_state_captain_order_loaded.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_state_owner_order_loaded.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class OrderStatusStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<OrderDetailsState> _stateSubject = new PublishSubject();

  Stream<OrderDetailsState> get stateStream => _stateSubject.stream;

  OrderStatusStateManager(this._ordersService,
      this._authService);

  Future<void> getOrderDetails(int orderId,
      OrderStatusScreenState screenState) async {
    _stateSubject.add(OrderDetailsStateLoading(screenState));

    var order = await _ordersService.getOrderDetails(orderId);
    if (order == null) {
      _stateSubject.add(OrderDetailsStateError(
          'Error Loading Data from the Server', screenState));
      return;
    } else {
      var role = await _authService.userRole;
      if (role == USER_TYPE.ROLE_CAPTAIN) {
        _stateSubject.add(OrderDetailsStateCaptainOrderLoaded(order, screenState));
      } else if (role == USER_TYPE.ROLE_OWNER) {
        _stateSubject.add(OrderDetailsStateOwnerOrderLoaded(order, screenState));
      } else {
        _stateSubject.add(OrderDetailsStateError('Error Defining Login Type', screenState));
      }
    }
  }

  Future<void> updateOrder(OrderModel model) {
    _ordersService.updateOrder(model.id, model);
  }
}
