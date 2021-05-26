import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_init/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountModule extends YesModule {
  final InitAccountScreen _initAccountScreen;
  final BranchesListScreen _branchesListScreen;
  final UpdateBranchScreen _updateBranchScreen;
  InitAccountModule(this._initAccountScreen, this._branchesListScreen,this._updateBranchScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      InitAccountRoutes.INIT_ACCOUNT_SCREEN: (context) => _initAccountScreen,
      InitAccountRoutes.BRANCHES_LIST_SCREEN: (context) => _branchesListScreen,
      InitAccountRoutes.UPDATE_BRANCH_SCREEN :(context)=> _updateBranchScreen
    };
  }
}
