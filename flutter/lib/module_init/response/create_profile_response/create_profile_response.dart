class CreateCaptainProfileRequest {
  String statusCode;
  String msg;
  Data data;

  CreateCaptainProfileRequest({this.statusCode, this.msg, this.data});

  CreateCaptainProfileRequest.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String captainID;
  String name;
  String image;
  String location;
  int age;
  String car;
  String drivingLicence;
  String salary;
  String status;
  List<CountOrdersDeliverd> countOrdersDeliverd;
  Rating rating;
  String state;
  Bounce bounce;
  int totalBounce;
  String uuid;
  String imageURL;
  String baseURL;

  Data(
      {this.id,
        this.captainID,
        this.name,
        this.image,
        this.location,
        this.age,
        this.car,
        this.drivingLicence,
        this.salary,
        this.status,
        this.countOrdersDeliverd,
        this.rating,
        this.state,
        this.bounce,
        this.totalBounce,
        this.uuid,
        this.imageURL,
        this.baseURL});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainID = json['captainID'];
    name = json['name'];
    image = json['image'];
    location = json['location'];
    age = json['age'];
    car = json['car'];
    drivingLicence = json['drivingLicence'];
    salary = json['salary'];
    status = json['status'];
    if (json['countOrdersDeliverd'] != null) {
      countOrdersDeliverd = new List<CountOrdersDeliverd>();
      json['countOrdersDeliverd'].forEach((v) {
        countOrdersDeliverd.add(new CountOrdersDeliverd.fromJson(v));
      });
    }
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    state = json['state'];
    bounce =
    json['bounce'] != null ? new Bounce.fromJson(json['bounce']) : null;
    totalBounce = json['totalBounce'];
    uuid = json['uuid'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['captainID'] = this.captainID;
    data['name'] = this.name;
    data['image'] = this.image;
    data['location'] = this.location;
    data['age'] = this.age;
    data['car'] = this.car;
    data['drivingLicence'] = this.drivingLicence;
    data['salary'] = this.salary;
    data['status'] = this.status;
    if (this.countOrdersDeliverd != null) {
      data['countOrdersDeliverd'] =
          this.countOrdersDeliverd.map((v) => v.toJson()).toList();
    }
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['state'] = this.state;
    if (this.bounce != null) {
      data['bounce'] = this.bounce.toJson();
    }
    data['totalBounce'] = this.totalBounce;
    data['uuid'] = this.uuid;
    data['imageURL'] = this.imageURL;
    data['baseURL'] = this.baseURL;
    return data;
  }
}

class CountOrdersDeliverd {
  int countOrdersDeliverd;

  CountOrdersDeliverd({this.countOrdersDeliverd});

  CountOrdersDeliverd.fromJson(Map<String, dynamic> json) {
    countOrdersDeliverd = json['countOrdersDeliverd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countOrdersDeliverd'] = this.countOrdersDeliverd;
    return data;
  }
}

class Rating {
  double rate;

  Rating({this.rate});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    return data;
  }
}

class Bounce {
  int bounce;

  Bounce({this.bounce});

  Bounce.fromJson(Map<String, dynamic> json) {
    bounce = json['bounce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bounce'] = this.bounce;
    return data;
  }
}
