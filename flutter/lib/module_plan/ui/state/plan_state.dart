import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:flutter/material.dart';

abstract class PlanScreenState {
  final PlanScreen screen;
  PlanScreenState(this.screen);

  Widget getUI(BuildContext context);
}