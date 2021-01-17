import 'dart:async';

import 'package:c4d/module_init/state_manager/init_account/init_account.state_manager.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
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

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getPackages();
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  void subscribeToPackage(int packageId) {
    widget._stateManager.subscribePackage(packageId, this);
  }

  void getPackages() {
    widget._stateManager.getPackages(this);
  }

  void saveBranch(LatLng location) {
    widget._stateManager.saveBranch(location, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState == null ? Container() : currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
