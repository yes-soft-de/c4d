import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/module_orders/ui/state/new_order/new_order.state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';

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

  void addNewOrder(
      String fromBranch,
      String destination,
      String note,
      String paymentMethod,
      String recipientName,
      String recipientPhone,
      String date) {
    widget._stateManager.addNewOrder(fromBranch, destination, note,
        paymentMethod, recipientName, recipientPhone, date, this);
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

  @override
  Widget build(BuildContext context) {
    if (currentState == null) {
      LatLng linkFromWhatsApp = ModalRoute.of(context).settings.arguments;
      currentState = NewOrderStateInit(linkFromWhatsApp, this);
    }
    return SafeArea(
      child: Scaffold(
        body: currentState.getUI(context),
      ),
    );
  }
}
