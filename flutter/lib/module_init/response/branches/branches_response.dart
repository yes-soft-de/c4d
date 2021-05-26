import 'package:c4d/module_orders/response/orders/orders_response.dart';

class BranchListResponse {
  List<Data> data;

  BranchListResponse({this.data});

  BranchListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int id;
  GeoJson location;
  String city;
  String brancheName;
  String userName;

  Data({this.id, this.location, this.brancheName, this.userName, this.city});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location =
        json['location'] != null ? GeoJson.fromJson(json['location']) : null;
    city = json['city'];
    brancheName = json['brancheName'];
    userName = json['userName'];
  }
}
