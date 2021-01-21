import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'captain_orders_list_state.dart';

class CaptainOrdersListStateOrdersLoaded extends CaptainOrdersListState {
  final List<OrderModel> myOrders;
  final List<OrderModel> orders;

  CaptainOrdersListStateOrdersLoaded(
      CaptainOrdersScreenState screenState, this.myOrders, this.orders)
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
              future: getMyOrdersList(context),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Widget>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data,
                    ),
                  );
                }
                return Column(
                  children: [
                    Center(
                      child: Text('Empty Stuff'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<List<Widget>> getMyOrdersList(BuildContext context) async {
    var availableOrders = await sortLocations();
    var uiList = <Widget>[];

    uiList.add(Text('My Orders'));
    availableOrders.forEach((element) {
      uiList.add(Container(
        margin: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              OrdersRoutes.ORDER_STATUS_SCREEN,
              arguments: element.id,
            );
          },
          child: OrderCard(
            title: 'Order #${element.id}',
            subTitle: ' ',
            time: timeago.format(element.creationTime,
                locale: Localizations.localeOf(context).languageCode),
          ),
        ),
      ));
    });

    uiList.add(Text('Available Orders'));
    myOrders.forEach((element) {
      try {
        uiList.add(Container(
          margin: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                OrdersRoutes.ORDER_STATUS_SCREEN,
                arguments: element.id,
              );
            },
            child: OrderCard(
              title: 'Order #${element.id}',
              subTitle: ' ',
              time:
                  '${timeago.format(element.creationTime, locale: Localizations.localeOf(context).languageCode)}',
            ),
          ),
        ));
      } catch (e, s) {
        print(e.toString() + s.toString());
      }
    });

    return uiList;
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
      } catch (e) {
        return 1;
      }
    });
    return orders.toList();
  }
}
