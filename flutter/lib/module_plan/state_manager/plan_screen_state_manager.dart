import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/state/captain_plan_loaded.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:c4d/module_plan/ui/state/plan_state_loaded.dart';
import 'package:c4d/module_plan/ui/state/plan_state_loading.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_init/service/init_account/init_account.service.dart';

@provide
class PlanScreenStateManager {
  final stateSubject = PublishSubject<PlanState>();
  final AuthService _authService;
  final PlanService _planService;
  final InitAccountService _initAccountService;
  PlanScreenStateManager(
      this._planService, this._authService, this._initAccountService);

  void getActivePlan(
    PlanScreenState screen,
  ) {
    stateSubject.add(PlanScreenStateLoading(screen));
    _authService.userRole.then((value) {
      if (value == UserRole.ROLE_OWNER) {
        _planService.getOwnerCurrentPlan().then((value) {
          if (value == null) {
            stateSubject.add(PlanScreenStateError(screen));
          } else {
            stateSubject.add(PlanScreenStateLoaded(screen, value));
          }
        });
      } else {
        _planService.getCaptainBalance().then((value) {
          stateSubject.add(CaptainPlanScreenStateLoaded(screen, value));
        });
      }
    });
  }

  // void refresh(PlanScreen screen, PlanScreenState state) {
  //   stateSubject.add(state);
  // }
  void renewPackage(int packageId, PlanScreenState screen) {
    stateSubject.add(PlanScreenStateLoading(screen));
    _initAccountService.renewPackage(packageId).then((value) {
      if (value) {
        stateSubject.add(PlanScreenStateSuccess(screen));
      } else {
        stateSubject.add(PlanScreenStateError(screen));
      }
    });
  }
}
