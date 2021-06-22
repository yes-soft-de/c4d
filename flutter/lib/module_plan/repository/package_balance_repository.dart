import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_plan/response/captain_balance_details_response.dart';
import 'package:c4d/module_plan/response/captain_balance_report.dart';
import 'package:c4d/module_plan/response/package_balance_response.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:inject/inject.dart';

@provide
class PackageBalanceRepository {
  final AuthService _authService;
  PackageBalanceRepository(this._authService);

  Future<PackageBalanceResponse> getCaptainPackage() async {
    ApiClient client = new ApiClient(new Logger());
    var response =
        await client.get('http://c4d.yes-cloud.de/html/public/packagebalance/');

    if (response == null) return null;
    return PackageBalanceResponse.fromJson(response);
  }

  Future<PackageBalanceResponse> getOwnerPackage() async {
    ApiClient client = new ApiClient(new Logger());
    await _authService.refreshToken();
    var token = await _authService.getToken();
    var response = await client
        .get('http://c4d.yes-cloud.de/html/public/packagebalance/', headers: {
      'Authorization': 'Bearer ' + token,
    });

    if (response == null) return null;
    return PackageBalanceResponse.fromJson(response);
  }

  Future<PaymentListReponse> getOwnerPayments() async {
    ApiClient client = new ApiClient(new Logger());
    await _authService.refreshToken();
    var token = await _authService.getToken();

    try {
      var response = await client.get(
        'http://c4d.yes-cloud.de/html/public/payments/',
        headers: {
          'Authorization': 'Bearer ' + token,
        },
      );

      if (response == null) return null;
      return PaymentListReponse.fromJson(response);
    } catch (e) {
      return PaymentListReponse(
        data: PaymentObject(
          payments: [],
        ),
      );
    }
  }

  Future<PaymentListReponse> getCaptainBalance() async {
    ApiClient client = new ApiClient(new Logger());
    await _authService.refreshToken();
    var token = await _authService.getToken();
    var response = await client
        .get('http://c4d.yes-cloud.de/html/public/captainmybalance', headers: {
      'Authorization': 'Bearer ' + token,
    });

    if (response == null) return null;

    return PaymentListReponse.fromJson(response);
  }
    Future<BalanceDetailsResponse> getCaptainBalanceDetails() async {
    ApiClient client = new ApiClient(new Logger());
    await _authService.refreshToken();
    var token = await _authService.getToken();
    var response = await client
        .get(Urls.GET_CAPTAIN_BALANCE_DETAILS, headers: {
      'Authorization': 'Bearer ' + token,
    });

    if (response == null) return null;

    return BalanceDetailsResponse.fromJson(response);
  }
}
