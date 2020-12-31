
import 'package:c4d/module_init/repository/init_account/init_account.repository.dart';
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
}