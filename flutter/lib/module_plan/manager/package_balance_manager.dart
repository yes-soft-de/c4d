import 'package:c4d/module_plan/repository/package_balance_repository.dart';
import 'package:c4d/module_plan/response/captain_balance_report.dart';
import 'package:c4d/module_plan/response/package_balance_response.dart';
import 'package:inject/inject.dart';

@provide
class PackageBalanceManager {
  final PackageBalanceRepository _repository;
  PackageBalanceManager(this._repository);

  Future<PackageBalanceResponse> getOwnerPackage() => _repository.getOwnerPackage();

  Future<PackageBalanceResponse> getCaptainPackage() => _repository.getCaptainPackage();

  Future<PaymentListReponse> getCaptainBalance() => _repository.getCaptainBalance();

  Future<PaymentListReponse> getOwnerPayments() => _repository.getOwnerPayments();
}