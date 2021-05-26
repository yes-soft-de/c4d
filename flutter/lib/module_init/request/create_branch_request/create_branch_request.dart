import 'package:latlong/latlong.dart';

class CreateBrancheRequest {
  LatLng location;
  String city;
  String userName;
  String branchName;
  int id;
  CreateBrancheRequest(
      {this.id, this.userName, this.location, this.city, this.branchName});

  Map<String, dynamic> toJson() {
    return {
      'location': {'lat':this.location.latitude,'lon':this.location.longitude},
      'brancheName': this.branchName,
    };
  }
}
