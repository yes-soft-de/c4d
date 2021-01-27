import 'package:c4d/generated/l10n.dart';
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
    var activity = <ActivityModel>[];
    if (records == null) {
      return [];
    }
    if (records.isEmpty) {
      return [];
    }
    records.forEach((e) {
      activity.add(ActivityModel(
        e.date != null ? DateTime.fromMillisecondsSinceEpoch(e.date.timestamp * 1000) : DateTime.now(),
        '${S.current.order} #${e.id}: ${getLocalizedState(e.state)}',
        e.state.contains('pending'),
      ));
    });
    return activity;
  }
  
  String getLocalizedState(String status) {
    if (status == 'pending') {
      return S.current.orderIsCreated;
    } else if (status == 'on way to pick order') {
      return S.current.captainAcceptedOrder;
    } else if (status == 'in store') {
      return S.current.captainInStore;
    } else if (status == 'ongoing') {
      return S.current.captainStartedDelivery;
    } else if (status == 'cash') {
      return S.current.captainGotCash;
    } else if (status == 'delivered') {
      return S.current.orderIsFinished;
    }
    return S.current.unknown;
  }
}
