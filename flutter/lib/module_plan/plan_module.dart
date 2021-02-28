import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:inject/inject.dart';

@provide
class PlanModule extends YesModule {
  final PlanScreen _planScreen;
  PlanModule(this._planScreen) {
    YesModule.RoutesMap.addAll({
      PlanRoutes.PLAN_ROUTE: (context) => _planScreen,
    });
  }
}