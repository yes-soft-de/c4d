import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'captain_orders_list_state.dart';

class CaptainOrdersListStateError extends CaptainOrdersListState {
  final String errorMsg;

  CaptainOrdersListStateError(
      this.errorMsg, CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('Error ${errorMsg}'),
    );
  }
}
