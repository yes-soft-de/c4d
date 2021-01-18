import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/get_records_response.dart';
import 'package:inject/inject.dart';

@provide
class ProfileManager {
  final ProfileRepository _repository;

  ProfileManager(
    this._repository,
  );

  Future<bool> createProfile(ProfileRequest profileRequest) async =>
      await _repository.createProfile(profileRequest);

  Future<Branch> createBranch(CreateBranchRequest request) =>
      _repository.createBranch(request);

  Future<Branch> getMyBranches() => _repository.getMyBranches();

  Future<List<ActivityRecord>> getMyLog() => _repository.getUserActivityLog();
}
