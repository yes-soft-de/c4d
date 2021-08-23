import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';
import 'package:c4d/utils/helper/order_average_helper.dart';
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
      child: Text(S.of(context).welcomeToOrdersScreen),
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
      Navigator.of(context).pushNamedAndRemoveUntil(
          AuthorizationRoutes.LOGIN_SCREEN, (r) => false);
    });
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrdersListStateOrdersLoaded extends OwnerOrdersListState {
  final List<OrderModel> orders;
  final bool canMakeOrders;
  final String canMakeOrderState;
  final bool alert;
  final String average;
  OrdersListStateOrdersLoaded(
      this.orders,
      this.canMakeOrders,
      this.canMakeOrderState,
      this.alert,
      this.average,
      OwnerOrdersScreenState screenState)
      : super(screenState) {
    if (this.alert == true) {
      showDialog(
          context: screenState.context,
          builder: (context) {
            return AlertDialog(
              title: Text(S.current.warnning),
              content: Container(
                height: 125,
                child: SingleChildScrollView(
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${S.of(context).dear} ${screenState.currentProfile.name}',
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 4,
                      ),
                      Text(
                        OrderAverageHelper.getOrderAlertAverage(average),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(S.of(context).confirm)),
              ],
            );
          });
    }
  }
  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //you may have error if you add to this widget icon and use the hot reloade use restart instead
        !canMakeOrders
            ? RefreshIndicator(
                onRefresh: () {},
                child: Flushbar(
                  title: S.of(context).warnning,
                  message: getTranslate(context, canMakeOrderState),
                  backgroundColor: Colors.red,
                  icon: Icon(
                    Icons.info,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  mainButton: orders.isNotEmpty
                      ? null
                      : IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            screenState.getMyOrders();
                          }),
                ),
              )
            : Container(),

        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              screenState.getMyOrders();
              return Future.delayed(Duration(seconds: 3));
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
                        title: '${orders[index].from ?? ''}',
                        subTitle:
                            '${S.of(context).order} #${orders[index].id}:',
                        time: timeago.format(orders[index].creationTime,
                            locale:
                                Localizations.localeOf(context).languageCode),
                        active: orders[index].status != OrderStatus.FINISHED,
                      ),
                    ),
                  );
                }),
          ),
        ),
        canMakeOrders == false
            ? Container()
            : GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(OrdersRoutes.NEW_ORDER_SCREEN);
                },
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).createNewOrder,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
      ],
    );
  }

  String getTranslate(BuildContext context, String state) {
    if (state == 'inactive') {
      return S.of(context).inactive;
    } else if (state == 'orders finished') {
      return S.of(context).outOforders;
    } else if (state == 'date finished') {
      return S.of(context).finishedDate;
    } else if (state == 'unaccept') {
      return S.of(context).unaccept;
    } else if (state == 'cars finished') {
      return S.of(context).outOfCars;
    } else {
      return state;
    }
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
      child: Text(
          '${errorMsg == 'not verified' ? S.of(context).notSubscription : errorMsg}'),
    );
  }
}
