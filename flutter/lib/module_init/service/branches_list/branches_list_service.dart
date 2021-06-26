import 'package:c4d/module_init/manager/branches/branches_manager.dart';
import 'package:c4d/module_init/model/branches/branches_model.dart';
import 'package:c4d/module_init/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_init/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_init/response/branches/branches_response.dart';
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';

@provide
class BranchesListService {
  final BranchesManager _manager;
  final ProfilePreferencesHelper _preferencesHelper;
  BranchesListService(this._manager, this._preferencesHelper);

  Future<List<BranchesModel>> getBranches() async {
    BranchListResponse response = await _manager.getBranches();
    if (response == null) return null;

    List<BranchesModel> branches = [];
    List<Branch> cacheBranches = [];
    response.data.forEach((element) {
      branches.add(new BranchesModel(
          id: element.id,
          city: element.city,
          branchName: element.brancheName,
          location: LatLng(element.location.lat, element.location.lon),
          userName: element.userName));
      cacheBranches.add(Branch(
        id: element.id,
        city: element.city,
        brancheName: element.brancheName,
        location: Location(lat:element.location.lat,lon: element.location.lon),
        userName: element.userName,
      ));
    });
    await _preferencesHelper.cacheBranch(cacheBranches);

    return branches;
  }

  Future<bool> updateBranch(UpdateBranchesRequest request) async =>
      await _manager.updateBranch(request);
  Future<bool> addBranch(CreateBrancheRequest request) async =>
      await _manager.createBrannch(request);
}