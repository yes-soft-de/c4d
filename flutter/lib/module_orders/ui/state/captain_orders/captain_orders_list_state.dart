import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';

import 'package:flutter/material.dart';


abstract class CaptainOrdersListState {
  CaptainOrdersScreenState screenState;

  CaptainOrdersListState(this.screenState);

  Widget getUI(BuildContext context);
}
