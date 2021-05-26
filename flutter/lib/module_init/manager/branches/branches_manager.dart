import 'package:c4d/module_init/repository/branches/branches_repository.dart';
import 'package:c4d/module_init/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_init/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_init/response/branches/branches_response.dart';
import 'package:inject/inject.dart';

@provide
class BranchesManager{
  final BranchesRepository _repository;

  BranchesManager(
      this._repository
      );

  Future<BranchListResponse> getBranches() async => await _repository.getBranches();

  Future<bool> updateBranch(UpdateBranchesRequest request) async => await _repository.updateBranch(request);
  Future<bool> createBrannch(CreateBrancheRequest request) async => await _repository.createBranch(request);
  }