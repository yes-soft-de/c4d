import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/model/activity_model/activity_model.dart';
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:inject/inject.dart';

@provide
class ProfileService {
  final ProfileManager _manager;
  final ProfilePreferencesHelper _preferencesHelper;

  ProfileService(
    this._manager,
    this._preferencesHelper,
  );

  Future<bool> createProfile(String city, int branch) async {
    ProfileRequest profileRequest = new ProfileRequest(
      city: city,
      branch: branch,
    );

    return await _manager.createProfile(profileRequest);
  }

  Future<bool> saveBranch(String lat, String lon, String name) async {
    var request = CreateBranchRequest(
      name,
      {
        'lat': lat,
        'lon': lon,
      },
    );

    var branch = await _manager.createBranch(request);

    if (branch == null) {
      return false;
    }

    await _preferencesHelper.cacheBranch(branch);
    return branch != null;
  }

  Future<int> getMyBranches() async {
    Branch branch = await _preferencesHelper.getSavedBranch();

    if (branch == null) {
      // Get the Branches from the backend
      branch = await _manager.getMyBranches();
      await _preferencesHelper.cacheBranch(branch);
    }

    return branch.id;
  }

  Future<dynamic> createCaptainProfile(String name, String age, String image, String licence) {
    // TODO: Implement This
  }

  Future<List<ActivityModel>> getActivity() async {
    var records = await _manager.getMyLog();
    var activity = <ActivityModel>[];
    records.forEach((e) {
      activity.add(ActivityModel(
        e.date != null ? DateTime.fromMillisecondsSinceEpoch(e.date.timestamp * 1000) : DateTime.now(),
        'Order #${e.id} is ${e.state}',
        e.state.contains('pending'),
      ));
    });

    return activity;
  }
}
