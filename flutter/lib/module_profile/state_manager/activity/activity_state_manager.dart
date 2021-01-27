import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:c4d/module_profile/ui/states/activity_state/activity_state.dart';
import 'package:c4d/module_profile/ui/states/activity_state_loading/activity_state_loading.dart';
import 'package:c4d/module_profile/ui/states/activity_state_record_loaded/activity_state_record_loaded.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class ActivityStateManager {
  final ProfileService _profileService;
  ActivityStateManager(this._profileService);

  final _stateSubject = PublishSubject<ActivityState>();

  Stream<ActivityState> get stateStream => _stateSubject.stream;

  void getMyProfile(ActivityScreenState state) {
    _stateSubject.add(ActivityStateLoading(state));
    _profileService.getActivity().then((value) {
      _stateSubject.add(ActivityStateRecordsLoaded(state, value));
    });
  }
}