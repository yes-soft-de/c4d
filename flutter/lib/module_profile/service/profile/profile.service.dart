import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/model/activity_model/activity_model.dart';
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:inject/inject.dart';

@provide
class ProfileService {
  final ProfileManager _manager;
  final ProfilePreferencesHelper _preferencesHelper;
  final AuthService _authService;

  ProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
  );

  Future<ProfileResponseModel> getProfile() async {
    var role = await _authService.userRole;

    switch (role) {
      case UserRole.ROLE_CAPTAIN:
        return _manager.getCaptainProfile();
        break;
      case UserRole.ROLE_OWNER:
        return _manager.getOwnerProfile();
        break;
      default:
        return null;
    }
  }

  Future<bool> updateCaptainProfile(ProfileRequest profileRequest) async {
    return _manager.createCaptainProfile(profileRequest);
  }

  Future<bool> createProfile(ProfileRequest profileRequest) async {

    var role = await _authService.userRole;

    switch (role) {
      case UserRole.ROLE_CAPTAIN:
        return _manager.createCaptainProfile(profileRequest);
        break;
      case UserRole.ROLE_OWNER:
        return _manager.createOwnerProfile(profileRequest);
        break;
      default:
        return false;
    }
  }

  Future<bool> updateProfile(ProfileRequest profileRequest) async {

    var role = await _authService.userRole;

    switch (role) {
      case UserRole.ROLE_CAPTAIN:
        return _manager.createCaptainProfile(profileRequest);
        break;
      case UserRole.ROLE_OWNER:
        return _manager.createOwnerProfile(profileRequest);
        break;
      default:
        return false;
    }
  }

  Future<bool> saveBranch(List<Branch> branchList) async {
    var branchesToCache = <Branch>[];

    for (int i = 0; i < branchList.length; i++) {
      var request = CreateBranchRequest(
        branchList[i].brancheName,
        {
          'lat': branchList[i].location.lat,
          'lon': branchList[i].location.lon,
        },
      );

      var branch = await _manager.createBranch(request);

      if (branch != null) {
        branchesToCache.add(branch);
      }
    }

    await _preferencesHelper.cacheBranch(branchesToCache);
    return branchesToCache.isNotEmpty;
  }

  Future<List<Branch>> getMyBranches() async {
    List<Branch> branches = await _preferencesHelper.getSavedBranch();

    if (branches == null) {
      // Get the Branches from the backend
      branches = await _manager.getMyBranches();
      await _preferencesHelper.cacheBranch(branches);
    }

    return branches;
  }

  Future<List<ActivityModel>> getActivity() async {
    var records = await _manager.getMyLog();
    var activity = <int, ActivityModel>{};
    if (records == null) {
      return [];
    }
    if (records.isEmpty) {
      return [];
    }
    records.forEach((e) {
      if (e.state == 'delivered') {
        activity[e.id] = ActivityModel(
        startDate: DateTime.fromMillisecondsSinceEpoch(e.record.first.date.timestamp * 1000),
        endDate: DateTime.fromMillisecondsSinceEpoch(e.record.last.date.timestamp * 1000),
        activity: '${e.brancheName}, #${e.id.toString()}'
      );
      }
    });

    return activity.values.toList();
  }

  String getLocalizedState(String status) {
    if (status == 'pending') {
      return S.current.orderIsCreated;
    } else if (status == 'on way to pick order') {
      return S.current.captainAcceptedOrder;
    } else if (status == 'in store' ||status == 'in_store' ) {
      return S.current.captainInStore;
    } else if (status == 'ongoing' || status == 'piked') {
      return S.current.captainStartedDelivery;
    } else if (status == 'cash') {
      return S.current.captainGotCash;
    } else if (status == 'delivered') {
      return S.current.orderIsFinished;
    }
    return status;
  }
}
