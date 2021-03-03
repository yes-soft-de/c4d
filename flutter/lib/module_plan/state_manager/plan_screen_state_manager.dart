import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:c4d/module_plan/ui/state/plan_state_loaded.dart';
import 'package:c4d/module_plan/ui/state/plan_state_loading.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class PlanScreenStateManager {
  final stateSubject = PublishSubject<PlanScreenState>();

  final PlanService _planService;

  PlanScreenStateManager(this._planService);

  void getActivePlan(PlanScreen screen) {
    stateSubject.add(PlanScreenStateLoading(screen));
    _planService.getOwnerCurrentPlan().then((value) {
      stateSubject.add(PlanScreenStateLoaded(screen, value));
    });
  }

  void refresh(PlanScreen screen, PlanScreenState state) {
    stateSubject.add(state);
  }
}
