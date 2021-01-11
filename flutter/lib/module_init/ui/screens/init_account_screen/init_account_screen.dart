import 'package:c4d/module_init/state_manager/init_account/init_account.state_manager.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountScreen extends StatelessWidget {
  final InitAccountStateManager _stateManager;

  InitAccountScreen(
    this._stateManager,
  );

  void subscribeToPackage(int packageId) {
    _stateManager.subscribePackage(packageId, this);
  }

  @override
  Widget build(BuildContext context) {
    _stateManager.getPackages(this);
    return StreamBuilder(
      initialData: null,
      stream: _stateManager.stateStream,
      builder: (context, snapshot) {
        return snapshot.data.getUI();
      },
    );
  }
}
