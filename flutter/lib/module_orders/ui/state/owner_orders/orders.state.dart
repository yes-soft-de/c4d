import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

import 'package:timeago/timeago.dart' as timeago;

abstract class OwnerOrdersListState {
  final OwnerOrdersScreenState screenState;

  OwnerOrdersListState(this.screenState);

  Widget getUI(BuildContext context);
}

class OrdersListStateInit extends OwnerOrdersListState {
  OrdersListStateInit(OwnerOrdersScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('Welcome to Orders Screen'),
    );
  }
}

class OrdersListStateLoading extends OwnerOrdersListState {
  OrdersListStateLoading(OwnerOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrdersListStateUnauthorized extends OwnerOrdersListState {
  OrdersListStateUnauthorized(OwnerOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      Navigator.of(context).pushNamedAndRemoveUntil(AuthorizationRoutes.LOGIN_SCREEN, (r) => false);
    });
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrdersListStateOrdersLoaded extends OwnerOrdersListState {
  final List<OrderModel> orders;

  OrdersListStateOrdersLoaded(this.orders, OwnerOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        screenState.getMyOrders();
        return Future.delayed(Duration(seconds: 3));
      },
      child: Column(
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
                            OrdersRoutes.ORDER_STATUS_SCREEN,
                            arguments: orders[index].id,
                          );
                        },
                        child: OrderCard(
                          subTitle: timeago.format(orders[index].creationTime),
                          title: 'Default Branch',
                          time: timeago.format(orders[index].creationTime),
                          active: orders[index].status != OrderStatus.INIT,
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
      ),
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

class OrdersListStateError extends OwnerOrdersListState {
  final String errorMsg;

  OrdersListStateError(this.errorMsg, OwnerOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}
