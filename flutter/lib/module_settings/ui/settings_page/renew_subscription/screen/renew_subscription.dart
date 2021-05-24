import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_settings/state_manager/renew_subscription_state_manager.dart';
import 'package:c4d/module_settings/ui/settings_page/renew_subscription/state/renew_subscription_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class RenewSubscriptionScreen extends StatefulWidget {
  final RenewSubscriptionStateManager _stateManager;

  const RenewSubscriptionScreen(this._stateManager);
  @override
  RenewSubscriptionScreenState createState() => RenewSubscriptionScreenState();
}

class RenewSubscriptionScreenState extends State<RenewSubscriptionScreen> {
  StreamSubscription _stateSubscription;
  RenewPcakageSubscriptionState currentState;

  void moveToNext(bool success) {
    if (success) {
      Navigator.of(context).pop();
      Flushbar(
        title: S.of(context).renewSubscription,
        message: S.of(context).successRenew,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
        title: S.of(context).renewSubscription,
        message: S.of(context).failureRenew,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void refresh() {
    setState(() {});
  }

  void renewSubscription(int packageId) {
    widget._stateManager.subscribePackage(this, packageId);
  }

  @override
  void initState() {
    super.initState();
    currentState = RenewPcakageSubscriptionStateLoading(this);
    widget._stateManager.getPackages(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).renewSubscription),
      ),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
    }
    super.dispose();
  }
}
