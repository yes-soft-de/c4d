import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:flutter/material.dart';

abstract class PlanState {
  final PlanScreenState screen;
  PlanState(this.screen);

  Widget getUI(BuildContext context);
}