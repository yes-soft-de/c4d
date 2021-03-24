import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:c4d/module_orders/response/terms/terms_respons.dart';
import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/get_records_response.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:inject/inject.dart';

@provide
class ProfileManager {
  final ProfileRepository _repository;

  ProfileManager(
    this._repository,
  );

  Future<bool> createOwnerProfile(ProfileRequest profileRequest) =>
      _repository.createOwnerProfile(profileRequest);

  Future<bool> createCaptainProfile(ProfileRequest profileRequest) =>
      _repository.createCaptainProfile(profileRequest);

  Future<ProfileResponseModel> getCaptainProfile() =>
      _repository.getCaptainProfile();

  Future<ProfileResponse> updateCaptainProfile(ProfileRequest profileRequest) =>
      _repository.updateCaptainProfile(profileRequest);

  Future<ProfileResponseModel> getOwnerProfile() =>
      _repository.getOwnerProfile();

  Future<Branch> createBranch(CreateBranchRequest request) =>
      _repository.createBranch(request);

  Future<List<Branch>> getMyBranches() => _repository.getMyBranches();

  Future<List<ActivityRecord>> getMyLog() => _repository.getUserActivityLog();
  Future <List<Terms>> getTerms(UserRole role) => _repository.getTerms(role);

}
