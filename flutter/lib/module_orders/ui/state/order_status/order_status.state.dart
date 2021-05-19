import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:flutter/material.dart';

abstract class OrderDetailsState {
  final OrderStatusScreenState screenState;

  OrderDetailsState(this.screenState);

  Widget getUI(BuildContext context);
}

class OrderDetailsStateLoading extends OrderDetailsState {
  OrderDetailsStateLoading(OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrderDetailsStateInit extends OrderDetailsState {
  OrderDetailsStateInit(OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrderDetailsStateError extends OrderDetailsState {
  String errorMsg;

  OrderDetailsStateError(
    this.errorMsg,
    OrderStatusScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}

class OrderDetailsStateDeleteSuccess extends OrderDetailsState {
  OrderDetailsStateDeleteSuccess(
    OrderStatusScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 125,
        )),
        SizedBox(height: 16),
        Center(child: Text(S.of(context).deleteSuccess)),
        SizedBox(height: 16),
        Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
                },
                child: Text(S.of(context).next))),
      ],
    );
  }
}
