import 'dart:async';

import 'package:c4d/module_init/model/branch/branch_model.dart';
import 'package:c4d/module_init/state_manager/init_account/init_account.state_manager.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';

@provide
class InitAccountScreen extends StatefulWidget {
  final InitAccountStateManager _stateManager;

  InitAccountScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => InitAccountScreenState();
}

class InitAccountScreenState extends State<InitAccountScreen> {
  StreamSubscription _streamSubscription;
  InitAccountState currentState;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void showSnackBar(String msg) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void submitProfile(Uri captainImage, Uri licence, String name, String age) {
    widget._stateManager.submitProfile(captainImage, licence, name, age, this);
  }

  void submitBankDetails(String bankName, String bankAccountNumber) {
    widget._stateManager.submitAccountNumber(bankName, bankAccountNumber, this);
  }

  void moveToOrders() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          OrdersRoutes.OWNER_ORDERS_SCREEN, (r) => false);
    });
  }

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getRoleInitState();
    super.initState();
  }

  void subscribeToPackage(
      int packageId, String name, String phone, String city,bool renew) {
    widget._stateManager.subscribePackage(this, packageId, name, phone, city,renew);
  }

  void getPackages() {
    widget._stateManager.getPackages(this);
  }

  void getRoleInitState() {
    widget._stateManager.getRoleInit(this);
  }

  void saveBranch(List<BranchModel> locations) {
    widget._stateManager.saveBranch(locations, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: currentState == null ? Container() : currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
