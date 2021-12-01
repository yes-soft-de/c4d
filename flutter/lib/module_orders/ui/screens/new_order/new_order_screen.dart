import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/module_orders/ui/state/new_order/new_order.state.dart';
import 'package:c4d/module_orders/util/whatsapp_link_helper.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';

import '../../../orders_routes.dart';

@provide
class NewOrderScreen extends StatefulWidget {
  final NewOrderStateManager _stateManager;

  NewOrderScreen(
    this._stateManager,
  );

  @override
  NewOrderScreenState createState() => NewOrderScreenState();
}

class NewOrderScreenState extends State<NewOrderScreen> {
  NewOrderState currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Branch fromBranch;
  String destination;
  String note;
  String paymentMethod;
  String recipientName;
  String recipientPhone;
  String date;
  LatLng destination2;

  void addNewOrder(
    String recipientName,
    String recipientPhone,
  ) {
    widget._stateManager.addNewOrder(fromBranch, destination, note,
        paymentMethod, recipientName, recipientPhone, date, destination2, this);
    widget._stateManager.deleteLoc();
  }

  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      OrdersRoutes.OWNER_ORDERS_SCREEN,
      (r) => false,
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void initNewOrder(Branch fromBranch, String destination, String note,
      String paymentMethod, String date, LatLng destination2) {
    this.fromBranch = fromBranch;
    this.destination = destination;
    this.note = note;
    this.paymentMethod = paymentMethod;
    this.date = date;
    this.destination2 = destination2;
    currentState = NewOrderStateSuccessState(this);
    refresh();
  }

  void showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<String> getInfo() async{
   return await widget._stateManager.getInfo();
  }
  void saveInfo(String info) {
    widget._stateManager.saveInfo(info);
  }

  @override
  Widget build(BuildContext context) {
    if (currentState == null) {
      LatLng linkFromWhatsApp = ModalRoute.of(context).settings.arguments;
      currentState = NewOrderStateInit(this);
      widget._stateManager.saveLoc(linkFromWhatsApp);
      widget._stateManager.loadBranches(this, linkFromWhatsApp);
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}
