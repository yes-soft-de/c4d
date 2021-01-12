import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:inject/inject.dart';

@provide
class ProfileManager {
  final ProfileRepository _repository;

  ProfileManager(
    this._repository,
  );

  Future<bool> createProfile(ProfileRequest profileRequest) async =>
      await _repository.createProfile(profileRequest);

  Future<bool> createBranch(CreateBranchRequest request) =>
      _repository.createBranch(request);
}
