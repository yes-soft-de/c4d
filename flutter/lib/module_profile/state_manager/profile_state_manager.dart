import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/screen/profile_screen/profile_screen..dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/states/profile_state_loading/profile_state_loading.dart';
import 'package:c4d/module_profile/ui/states/profile_state_record_loaded/profile_state_record_loaded.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class ProfileStateManager {
  final ProfileService _profileService;
  ProfileStateManager(this._profileService);

  final _stateSubject = PublishSubject<ProfileState>();

  Stream<ProfileState> get stateStream => _stateSubject.stream;

  void getMyProfile(ProfileScreenState state) {
    _stateSubject.add(ProfileStateLoading(state));
    _profileService.getActivity().then((value) {
      _stateSubject.add(ProfileStateRecordsLoaded(state, value));
    });
  }
}