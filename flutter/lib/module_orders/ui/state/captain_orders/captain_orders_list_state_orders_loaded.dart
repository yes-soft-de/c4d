import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
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
  final String status;
  int currentPage;
  PageController ordersPageController;
  CaptainOrdersListStateOrdersLoaded(CaptainOrdersScreenState screenState,
      this.myOrders, this.orders, this.status)
      : super(screenState) {
    currentPage = screenState.currentPage;
    ordersPageController = PageController(initialPage: screenState.currentPage);
  }

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
            child: PageView(
              controller: ordersPageController,
              onPageChanged: (pos) {
                currentPage = pos;
                screenState.currentPage = pos;
                screenState.refresh();
              },
              children: [
                FutureBuilder(
                  future: getNearbyOrdersList(context),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Widget>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        onRefresh: () {
                          screenState.getMyOrders();
                          return Future.delayed(Duration(seconds: 3));
                        },
                        child: ListView(
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
                FutureBuilder(
                  future: getMyOrdersList(context),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Widget>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        onRefresh: () {
                          screenState.getMyOrders();
                          return Future.delayed(Duration(seconds: 3));
                        },
                        child: ListView(
                          children: snapshot.data,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text(S.of(context).emptyStaff)),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        _Footer(context)
      ],
    );
  }

  Widget _Footer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)]),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              height: 72,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  IconButton(
                    color: currentPage == 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    icon: Icon(Icons.directions_car),
                    onPressed: () {
                      ordersPageController.animateToPage(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                      );
                      currentPage = 0;
                       screenState.currentPage = 0;
                      screenState.refresh();
                    },
                  ),
                  Text(
                    S.of(context).currentOrders,
                    style: TextStyle(
                      fontSize: 12,
                      color: currentPage == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              height: 72,
              child: Column(
                children: [
                  IconButton(
                    color: currentPage == 1
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    icon: Icon(Icons.map_outlined),
                    onPressed: () {
                      ordersPageController.animateToPage(
                        1,
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                      );
                      currentPage = 1;
                       screenState.currentPage = 1;
                      screenState.refresh();
                    },
                  ),
                  Text(
                    S.of(context).nearbyOrders,
                    style: TextStyle(
                      fontSize: 12,
                      color: currentPage == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> getMyOrdersList(BuildContext context) async {
    var uiList = <Widget>[];
    if (status != 'active') {
      uiList.add(
        Flushbar(
          title: S.of(context).warnning,
          message: S.of(context).captainNotActive,
          backgroundColor: Colors.red,
          icon: Icon(
            Icons.info,
            size: 28.0,
            color: Colors.white,
          ),
        ),
      );
    }
    List<OrderModel> orders = await sortLocations(myOrders);
    var currentPos = await DeepLinksService.defaultLocation();
    final Distance distance = Distance();

    orders ??= [];

    orders.forEach((element) {
      bool flag = false;
      double totalDestance;
      var creationDate = element.creationTime;
      if (currentPos != null && element.branchLocation != null) {
        var branchLoc = element.branchLocation;
        totalDestance = distance.as(LengthUnit.Kilometer, currentPos,
            LatLng(branchLoc.lat ?? 0, branchLoc.lon ?? 0));
      }
      if (totalDestance <= 5.0 &&
          creationDate.difference(DateTime.now()).inMinutes <= 35) {
        flag = true;
      } else if (totalDestance <= 8.0 &&
          creationDate.difference(DateTime.now()).inMinutes <= 32) {
        flag = true;
      } else if (totalDestance <= 12.0 &&
          creationDate.difference(DateTime.now()).inMinutes <= 29) {
        flag = true;
      } else if (totalDestance <= 16.0 &&
          creationDate.difference(DateTime.now()).inMinutes <= 26) {
        flag = true;
      } else if (totalDestance <= 20.0 &&
          creationDate.difference(DateTime.now()).inMinutes <= 23) {
        flag = true;
      } else if (totalDestance <= 24.0 &&
          creationDate.difference(DateTime.now()).inMinutes <= 20) {
        flag = true;
      } else if (creationDate.difference(DateTime.now()).inMinutes <= 10) {
        flag = true;
      } else {
        flag = false;
      }
      if (flag) {
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
              title: '${element.storeName}',
              subTitle: S.of(context).order + '#${element.id}',
              time: timeago.format(element.creationTime,
                  locale: Localizations.localeOf(context).languageCode),
            ),
          ),
        ));
      }
    });

    return uiList;
  }

  Future<List<Widget>> getNearbyOrdersList(BuildContext context) async {
    //var availableOrders = await sortLocations();
    var uiList = <Widget>[];
    if (status != 'active') {
      uiList.add(
        Flushbar(
          title: S.of(context).warnning,
          message: S.of(context).captainNotActive,
          backgroundColor: Colors.red,
          icon: Icon(
            Icons.info,
            size: 28.0,
            color: Colors.white,
          ),
        ),
      );
    }
    orders.forEach((element) {
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
            title: '${element.storeName}',
            subTitle: S.of(context).order + '#${element.id}',
            time: timeago.format(element.creationTime,
                locale: Localizations.localeOf(context).languageCode),
          ),
        ),
      ));
    });
    return uiList;
  }

  Future<List<OrderModel>> sortLocations(List<OrderModel> order) async {
    Location location = new Location();

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    var _permissionGranted = await location.requestPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      return order;
    }
    if (order == null) {
      return [];
    }

    final Distance distance = Distance();

    var myLocation = await Location.instance.getLocation();
    LatLng myPos = LatLng(myLocation.latitude, myLocation.longitude);
    order.sort((a, b) {
      try {
        var pos1 = LatLng(a.branchLocation.lat, a.branchLocation.lon);
        var pos2 = LatLng(b.branchLocation.lat, b.branchLocation.lon);
        var straightDistance1 = distance.as(LengthUnit.Kilometer, pos1, myPos);
        var straightDistance2 = distance.as(LengthUnit.Kilometer, pos2, myPos);
        // var straightDistance = distance.as(LengthUnit.Kilometer, pos1, myPos) -
        //     distance.as(LengthUnit.Kilometer, pos2, myPos);
        return straightDistance1.compareTo(straightDistance2);
      } catch (e) {
        print(e.toString());
        return 1;
      }
    });
    return order.toList();
  }
}
