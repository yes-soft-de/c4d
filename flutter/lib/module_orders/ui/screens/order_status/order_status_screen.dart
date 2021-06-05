import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_state_captain_order_loaded.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_state_owner_order_loaded.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_report/presistance/report_prefs_helper.dart';
import 'package:c4d/module_report/ui/widget/report_dialog/report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrderStatusScreen extends StatefulWidget {
  final OrderStatusStateManager _stateManager;
  final ReportPrefsHelper _reportPrefsHelper;
  OrderStatusScreen(this._stateManager, this._reportPrefsHelper);

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  int orderId;
  OrderDetailsState currentState;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String msg, [Color color]) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
    ));
  }

  Future uuid(String orderId) async {
    return await widget._reportPrefsHelper.getUUId(orderId);
  }

  void deleteOrder(model) {
    widget._stateManager.deleteOrder(model, this);
    var context = _scaffoldKey.currentContext;
    showSnackBar(S.of(context).deleteSuccess, Colors.green);
  }

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void requestOrderProgress(OrderModel currentOrder, [String distance]) {
    OrderStatus newStatus;
    switch (currentOrder.status) {
      case OrderStatus.INIT:
        newStatus = OrderStatus.GOT_CAPTAIN;
        break;
      case OrderStatus.GOT_CAPTAIN:
        newStatus = OrderStatus.IN_STORE;
        break;
      case OrderStatus.IN_STORE:
        newStatus = OrderStatus.DELIVERING;
        break;
      case OrderStatus.DELIVERING:
        newStatus = currentOrder.paymentMethod == 'CASH'
            ? OrderStatus.GOT_CAPTAIN
            : OrderStatus.FINISHED;
        break;
      case OrderStatus.GOT_CASH:
        newStatus = OrderStatus.FINISHED;
        break;
      case OrderStatus.FINISHED:
        break;
    }
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(S.of(context).confirm),
            content: Container(
              child: Text(S.of(context).confirmUpdateOrderStatus),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).cancel)),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    currentOrder.distance = distance;
                    currentOrder.status = newStatus;
                    widget._stateManager.updateOrder(currentOrder, this);
                  },
                  child: Text(S.of(context).confirm)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (currentState == null) {
      orderId = ModalRoute.of(context).settings.arguments;
      widget._stateManager.getOrderDetails(orderId, this);
      currentState = OrderDetailsStateInit(this);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        key: _scaffoldKey,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            if (currentState is OrderDetailsStateOwnerOrderLoaded) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
            } else if (currentState is OrderDetailsStateCaptainOrderLoaded) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          S.of(context).orderDetails,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.flag),
              onPressed: () {
                showDialog(
                  context: context,
                  child: Dialog(
                    child: ReportDialogWidget(),
                  ),
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  if (value is String) {
                    if (value.isNotEmpty) {
                      widget._stateManager
                          .report(orderId, value)
                          .whenComplete(() => setState(() {}));
                      showSnackBar(S.of(context).reportSent);
                    }
                  }
                }).whenComplete(() => setState(() {}));
              }),
          FutureBuilder(
            future: uuid(orderId.toString()),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        ChatRoutes.chatRoute,
                        arguments: 'F#${snapshot.data}',
                      );
                    });
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: currentState.getUI(context),
    );
  }
}
