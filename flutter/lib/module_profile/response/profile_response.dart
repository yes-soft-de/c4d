import 'package:c4d/consts/urls.dart';

class ProfileResponse {
  String statusCode;
  String msg;
  ProfileResponseModel data;

  ProfileResponse({this.statusCode, this.msg, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['Data'] != null
        ? new ProfileResponseModel.fromJson(json['Data'])
        : null;
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

class ProfileResponseModel {
  int id;
  String captainID;
  String name;
  String location;
  int age;
  String car;
  String drivingLicence;
  String drivingLicenceURL;
  Null salary;
  String status;
  List<CountOrdersDeliverd> countOrdersDeliverd;
  Rating rating;
  String state;
  Bounce bounce;
  Null totalBounce;
  Null uuid;
  String image;
  String imageURL;
  String baseURL;
  String phone;
  bool isOnline;
  String bankName;
  String accountID;
  String stcPay;

  ProfileResponseModel(
      {this.id,
      this.captainID,
      this.name,
      this.location,
      this.age,
      this.car,
      this.drivingLicence,
      this.drivingLicenceURL,
      this.salary,
      this.status,
      this.countOrdersDeliverd,
      this.rating,
      this.state,
      this.bounce,
      this.totalBounce,
      this.uuid,
      this.image,
      this.imageURL,
      this.baseURL,
      this.phone,
      this.isOnline,
      this.bankName,
      this.accountID,
      this.stcPay});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainID = json['captainID'];
    if (json['name'] != null) {
      name = json['name'];
    } else {
      name = json['userName'];
    }
    location = json['location'];
    age = json['age'];
    car = json['car'];
    drivingLicence = json['drivingLicence'];
    drivingLicenceURL = json['drivingLicenceURL'];
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
    image = json['image'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
    phone = json['phone'];
    isOnline = json['isOnline'] == 'active';
    if (json['bank'] != null) {
      bankName = json['bank']['bankName'];
      accountID = json['bank']['accountID'];
      stcPay = json['bank']['stcPay'];
    }

    print('Stc: $stcPay, $accountID $bankName');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['captainID'] = this.captainID;
    data['name'] = this.name;
    data['location'] = this.location;
    data['age'] = this.age;
    data['car'] = this.car;
    if (this.drivingLicence != null) {
      var licence = this.drivingLicence;
      if (licence.contains('http')) {
        licence = licence.substring(licence.lastIndexOf('http'));
        licence = licence.substring(Urls.IMAGES_ROOT.length);
      }
      data['drivingLicence'] = licence;
      print('Licence Url: ' + licence);
    }
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
    data['image'] = this.image;
    data['imageURL'] = this.imageURL;
    data['baseURL'] = this.baseURL;
    data['phone'] = this.phone;
    data['isOnline'] = this.isOnline ? 'active' : 'inactive';
    data['bankName'] = this.bankName;
    data['accountID'] = this.accountID;
    data['stcPay'] = this.stcPay;
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
  Null rate;

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
  String sumPayments;
  int netProfit;
  int total;
  int countOrdersDeliverd;
  List<Payments> payments;
  dynamic bank;

  Bounce(
      {this.bounce,
      this.sumPayments,
      this.netProfit,
      this.total,
      this.countOrdersDeliverd,
      this.payments,
      this.bank});

  Bounce.fromJson(Map<String, dynamic> json) {
    bounce = json['bounce'];
    sumPayments = json['sumPayments'];
    netProfit = json['NetProfit'];
    total = json['total'];
    countOrdersDeliverd = json['countOrdersDeliverd'];
    if (json['payments'] != null) {
      payments = new List<Payments>();
      json['payments'].forEach((v) {
        payments.add(new Payments.fromJson(v));
      });
    }
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bounce'] = this.bounce;
    data['sumPayments'] = this.sumPayments;
    data['NetProfit'] = this.netProfit;
    data['total'] = this.total;
    data['countOrdersDeliverd'] = this.countOrdersDeliverd;
    if (this.payments != null) {
      data['payments'] = this.payments.map((v) => v.toJson()).toList();
    }
    data['bank'] = this.bank;
    return data;
  }
}

class Payments {
  int id;
  String captainId;
  int amount;
  Date date;

  Payments({this.id, this.captainId, this.amount, this.date});

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainId = json['captainId'];
    amount = json['amount'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['captainId'] = this.captainId;
    data['amount'] = this.amount;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    return data;
  }
}

class Date {
  Timezone timezone;
  int offset;
  int timestamp;

  Date({this.timezone, this.offset, this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String name;
  List<Transitions> transitions;
  Location location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = new List<Transitions>();
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Transitions {
  int ts;
  String time;
  int offset;
  bool isdst;
  String abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String countryCode;
  int latitude;
  int longitude;
  String comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}
