import 'dart:convert';

import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class ProfilePreferencesHelper {

  Future<void> cacheBranch(List<Branch> branch) async {
    if (branch == null) {
      return null;
    }
    if (branch.isEmpty) {
      return null;
    }
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('Branch', jsonEncode(branch));
  }

  Future<List<Branch>> getSavedBranch() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var branchJson = _prefs.getString('Branch');
    if (branchJson == null) return null;
    if (branchJson.length < 5) return null;

    var branches = <Branch>[];

    var cached = jsonDecode(branchJson);
    if (cached is List) {
      cached.forEach((element) {
        branches.add(Branch.fromJson(element));
      });
    }

    return branches;
  }
}