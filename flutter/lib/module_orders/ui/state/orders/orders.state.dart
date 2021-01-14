import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders/orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

abstract class OrdersListState {
  final OrdersScreenState screenState;

  OrdersListState(this.screenState);

  Widget getUI(BuildContext context);
}

class OrdersListStateInit extends OrdersListState {
  OrdersListStateInit(State<StatefulWidget> screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('Welcome to Orders Screen'),
    );
  }
}

class OrdersListStateLoading extends OrdersListState {
  OrdersListStateLoading(State<StatefulWidget> screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrdersListStateOrdersLoaded extends OrdersListState {
  final List<OrderModel> orders;

  OrdersListStateOrdersLoaded(this.orders, State<StatefulWidget> screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              screenState.getMyOrders();
              return null;
            },
            child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          OrdersRoutes.ORDER_STATUS,
                          arguments: orders[index].id,
                        );
                      },
                      child: OrderCard(
                        to: orders[index].to,
                        from: orders[index].from,
                        time: orders[index].creationTime,
                        index: index,
                      ),
                    ),
                  );
                }),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(OrdersRoutes.NEW_ORDER_SCREEN);
          },
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Create new order',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<List<OrderModel>> sortLocations() async {
    Location location = new Location();

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return orders;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      return orders;
    }

    final Distance distance = Distance();

    var myLocation = await Location.instance.getLocation();
    LatLng myPos = LatLng(myLocation.latitude, myLocation.longitude);
    orders.sort((a, b) {
      return distance.as(LengthUnit.Kilometer, a.toOnMap, myPos) -
          distance.as(LengthUnit.Kilometer, b.toOnMap, myPos);
    });
    return orders;
  }
}

class OrdersListStateError extends OrdersListState {
  final String errorMsg;

  OrdersListStateError(this.errorMsg, State<StatefulWidget> screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}
