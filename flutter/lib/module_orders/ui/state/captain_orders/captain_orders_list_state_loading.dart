import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'captain_orders_list_state.dart';

class CaptainOrdersListStateLoading extends CaptainOrdersListState {
  CaptainOrdersListStateLoading(CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        screenState.getMyOrders();
        return Future.delayed(Duration(seconds: 3));
      },
      child: Center(
        child: GestureDetector(
            onTap: () {
              screenState.getMyOrders();
            },
            child: Lottie.network(
                'https://assets4.lottiefiles.com/datafiles/vhvOcuUkH41HdrL/data.json')),
      ),
    );
  }
}
