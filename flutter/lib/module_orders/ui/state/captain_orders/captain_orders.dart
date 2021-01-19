import 'dart:convert';

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

abstract class CaptainOrdersListState {
  CaptainOrdersScreenState screenState;

  CaptainOrdersListState(this.screenState);

  Widget getUI(BuildContext context);
}

class OrdersListStateInit extends CaptainOrdersListState {
  OrdersListStateInit(CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('Welcome to Orders Screen'),
    );
  }
}

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

class CaptainOrdersListStateUnauthorized extends CaptainOrdersListState {
  CaptainOrdersListStateUnauthorized(CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          AuthorizationRoutes.LOGIN_SCREEN, (r) => false);
    });
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class CaptainOrdersListStateOrdersLoaded extends CaptainOrdersListState {
  final List<OrderModel> orders;

  CaptainOrdersListStateOrdersLoaded(
      this.orders, CaptainOrdersScreenState screenState)
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
              return Future.delayed(Duration(seconds: 3));
            },
            child: FutureBuilder(
              future: sortLocations(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<OrderModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              OrdersRoutes.ORDER_STATUS_SCREEN,
                              arguments: snapshot.data[index].id,
                            );
                          },
                          child: OrderCard(
                            to: snapshot.data[index].to,
                            from: 'Order #${snapshot.data[index].id}',
                            time: timeago
                                .format(snapshot.data[index].creationTime),
                            index: index,
                          ),
                        ),
                      );
                    });
                }
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<List<OrderModel>> sortLocations() async {
    Location location = new Location();

    bool _serviceEnabled = await location.serviceEnabled();
    print('Service Enabled $_serviceEnabled');
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    var _permissionGranted = await location.requestPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      return orders;
    }

    final Distance distance = Distance();

    var myLocation = await Location.instance.getLocation();
    print('My Location: ' + myLocation.toString());
    LatLng myPos = LatLng(myLocation.latitude, myLocation.longitude);
    orders.sort((a, b) {
      try {
        var pos1 = LatLng(a.to.lat, a.to.lon);
        print(pos1);
        var pos2 = LatLng(b.to.lat, b.to.lon);
        print(pos2);

        var straightDistance = distance.as(LengthUnit.Kilometer, pos1, myPos) -
            distance.as(LengthUnit.Kilometer, pos2, myPos);
        print('Distance $straightDistance');
        return straightDistance;
      } catch(e) {
        return 1;
      }
    });
    return orders.toList();
  }
}

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
