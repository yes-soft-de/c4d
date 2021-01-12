import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:inject/inject.dart';

@provide
class ProfileService {
  final ProfileManager _manager;

  ProfileService(
    this._manager,
  );

  Future<bool> createProfile(String city, int branch) async {
    ProfileRequest profileRequest = new ProfileRequest(
      city: city,
      branch: branch,
    );

    return await _manager.createProfile(profileRequest);
  }

  Future<bool> saveBranch(String lat, String lon, String name) {
    var request = CreateBranchRequest(
      name,
      {
        'lat': lat,
        'lon': lon,
      },
    );

    return _manager.createBranch(request);
  }
}
