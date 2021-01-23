class CreateBranchResponse {
  var statusCode;
  String msg;
  Branch data;

  CreateBranchResponse({this.statusCode, this.msg, this.data});

  CreateBranchResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new Branch.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Branch {
  int id;
  String ownerID;
  Location location;
  String city;
  String brancheName;
  String free;
  String userName;
  String status;

  Branch(
      {this.id,
        this.ownerID,
        this.location,
        this.city,
        this.brancheName,
        this.free,
        this.userName,
        this.status});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    city = json['city'];
    brancheName = json['brancheName'];
    free = json['free'];
    userName = json['userName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['ownerID'] = this.ownerID;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['city'] = this.city;
    data['brancheName'] = this.brancheName;
    data['free'] = this.free;
    data['userName'] = this.userName;
    data['status'] = this.status;
    return data;
  }
}

class Location {
  double lat;
  double lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {

    lat = double.tryParse(json['lat'].toString());
    lon = double.parse(json['lon'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
