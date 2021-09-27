// import 'dart:async';

// import 'package:c4d/module_init/model/branch/branch_model.dart';
// import 'package:c4d/module_init/state_manager/init_account/init_account.state_manager.dart';
// import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
// import 'package:c4d/module_orders/orders_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:inject/inject.dart';
// import 'package:latlong/latlong.dart';

// @provide
// class RenewPackageScreen extends StatefulWidget {
//   final InitAccountStateManager _stateManager;

//   RenewPackageScreen(
//     this._stateManager,
//   );

//   @override
//   State<StatefulWidget> createState() => RenewPackageScreenState();
// }

// class RenewPackageScreenState extends State<RenewPackageScreen> {
//   StreamSubscription _streamSubscription;
//   InitAccountState currentState;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   void refresh() {
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void showSnackBar(String msg) {
//     scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
//   }
//   void moveToOrders() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Navigator.of(context).pushNamedAndRemoveUntil(
//           OrdersRoutes.OWNER_ORDERS_SCREEN, (r) => false);
//     });
//   }

//   @override
//   void initState() {
//     widget._stateManager.stateStream.listen((event) {
//       currentState = event;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//     super.initState();
//   }

//   void subscribeToPackage(
//       int packageId, String name, String phone, String city,bool renew) {
//     widget._stateManager.subscribePackage(this, packageId, name, phone, city,renew);
//   }

//   void getPackage() {
//     widget._stateManager.getPackages(this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       body: currentState == null ? SizedBox() : currentState.getUI(context),
//     );
//   }

//   @override
//   void dispose() {
//     _streamSubscription?.cancel();
//     super.dispose();
//   }
// }
