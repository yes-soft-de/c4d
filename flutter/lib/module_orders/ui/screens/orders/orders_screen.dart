import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/orders/orders.state_manager.dart';
import 'package:c4d/module_orders/ui/state/orders/orders.state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';

@provide
class OrdersScreen extends StatefulWidget {
  final OrdersStateManager _stateManager;

  OrdersScreen(
    this._stateManager,
  );

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  OrdersListState _currentState;

  void getMyOrders() {
    widget._stateManager.getMyOrders(this);
  }

  void addOrderViaDeepLink(LatLng location) {
    _currentState = OrdersListStateInit(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamed(OrdersRoutes.NEW_ORDER_SCREEN, arguments: location);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentState = OrdersListStateInit(this);

    widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    DeepLinksService.checkForGeoLink().then((value) {
      if (value != null) {
        Navigator.of(context).pushNamed(
          OrdersRoutes.NEW_ORDER_SCREEN,
          arguments: value,
        );
      }
    });

    widget._stateManager.getMyOrders(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders'),),
      body: _currentState.getUI(context),
    );
  }
}
