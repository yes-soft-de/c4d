import 'package:latlong/latlong.dart';

class UpdateBranchesRequest {
  LatLng location;
  String city;
  String userName;
  String branchName;
  int id;
  UpdateBranchesRequest(
      {this.id, this.userName, this.location, this.city, this.branchName});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'userName': this.userName,
      'location': {'lat':this.location.latitude,'lon':this.location.longitude},
      'city': this.city,
      'brancheName': this.branchName,
    };
  }
}
