import 'package:latlong/latlong.dart';

class BranchesModel {
  LatLng location;
  String city;
  String userName;
  String branchName;
  int id;
  BranchesModel({
    this.location,
    this.branchName,
    this.id,
    this.city,
    this.userName,
  });
}
