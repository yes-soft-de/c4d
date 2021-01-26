
import 'package:c4d/module_init/repository/init_account/init_account.repository.dart';
import 'package:c4d/module_init/request/create_bank_account/create_bank_account.dart';
import 'package:c4d/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:c4d/module_init/response/packages/packages_response.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountManager{
  final InitAccountRepository _repository;

  InitAccountManager(
      this._repository
      );

  Future<PackagesResponse> getPackages() async => await _repository.getPackages();

  Future<bool> subscribePackage(int packageId)async => await _repository.subscribePackage(packageId);

  Future<dynamic> createCaptainProfile(CreateCaptainProfileRequest request) => _repository.createCaptainProfile(request);

  Future<dynamic> createBankAccount(CreateBankAccountRequest createBankAccountRequest) {
    return _repository.createBankAccount(createBankAccountRequest);
  }
}