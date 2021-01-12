import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/widget/package_card/package_card.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class InitAccountState {
  final InitAccountScreenState screen;
  InitAccountState(this.screen);

  Widget getUI(BuildContext context);
}

class initAccountStateInit extends InitAccountState {
  initAccountStateInit(InitAccountScreenState screen) : super(screen) {
    screen.getPackages();
  }

  @override
  Widget getUI(BuildContext context) {
    return Text('Init Data');
  }
}

class InitAccountStateLoading extends InitAccountState {
  InitAccountStateLoading(screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Loading')),
    );
  }
}

class InitAccountStateError extends InitAccountState {
  final String errorMsg;

  InitAccountStateError(
    this.errorMsg,
    InitAccountScreenState screen,
  ) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMsg),
      ),
    );
  }
}

class InitAccountStateSubscribeSuccess extends InitAccountState {
  InitAccountStateSubscribeSuccess(InitAccountScreenState screen)
      : super(screen);
  @override
  Widget getUI(BuildContext context) {
    return Scaffold();
  }
}
