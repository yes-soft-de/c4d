import 'package:c4d/utils/logger/logger.dart';

class OrdersResponse {
  String statusCode;
  String msg;
  List<Order> data;

  OrdersResponse({this.statusCode, this.msg, this.data});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <Order>[];
      try {
        json['Data'].forEach((v) {
          data.add(new Order.fromJson(v));
        });
      } catch (e, stack) {
        Logger().error('Network Error', '${e.toString()}:\n${stack.toString()}', StackTrace.current);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int id;
  String ownerID;
  String userName;
  dynamic source;
  OwnerResponse owner;
  Destination destination;
  Date date;
  Date updateDate;
  String note;
  String payment;
  String recipientName;
  String recipientPhone;
  String state;
  FromBranch fromBranch;
  GeoJson location;
  String brancheName;
  String branchCity;
  dynamic acceptedOrder;
  dynamic record;
  String uuid;

  Order(
      {this.id,
        this.ownerID,
        this.userName,
        this.source,
        this.destination,
        this.date,
        this.updateDate,
        this.note,
        this.owner,
        this.payment,
        this.recipientName,
        this.recipientPhone,
        this.state,
        this.fromBranch,
        this.location,
        this.brancheName,
        this.branchCity,
        this.acceptedOrder,
        this.record,
        this.uuid});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerID = json['ownerID'];
    userName = json['userName'];
    if (json['source'] != null) {
      source = <String>[];
      json['source'].forEach((v) {
        source.add(v);
      });
    }

    if (json['owner'] != null) {
      this.owner = OwnerResponse.fromJson(json['owner']);
    }

    // destination = json['destination'] != null
    //     ? new Destination.fromJson(json['destination'])
    //     : null;
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    updateDate = json['updateDate'] != null
        ? new Date.fromJson(json['updateDate'])
        : null;
    note = json['note'];
    payment = json['payment'];
    recipientName = json['recipientName'];
    recipientPhone = json['recipientPhone'];
    state = json['state'];
    fromBranch = json['fromBranch'] != null
        ? new FromBranch.fromJson(json['fromBranch'])
        : null;
    location = json['location'];
    brancheName = json['brancheName'];
    branchCity = json['branchCity'];
    acceptedOrder = json['acceptedOrder'];
    record = json['record'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['ownerID'] = this.ownerID;
    data['userName'] = this.userName;
    if (this.source != null) {
      data['source'] = this.source.map((v) => v.toJson()).toList();
    }
    if (this.destination != null) {
      data['destination'] = this.destination.toJson();
    }
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    if (this.updateDate != null) {
      data['updateDate'] = this.updateDate.toJson();
    }
    data['note'] = this.note;
    data['payment'] = this.payment;
    data['recipientName'] = this.recipientName;
    data['recipientPhone'] = this.recipientPhone;
    data['state'] = this.state;
    if (this.fromBranch != null) {
      data['fromBranch'] = this.fromBranch.toJson();
    }
    data['location'] = this.location;
    data['brancheName'] = this.brancheName;
    data['branchCity'] = this.branchCity;
    data['acceptedOrder'] = this.acceptedOrder;
    data['record'] = this.record;
    data['uuid'] = this.uuid;
    return data;
  }
}

class Destination {
  Null lat;
  Null lon;

  Destination({this.lat, this.lon});

  Destination.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Date {
  int timestamp;

  Date({this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class FromBranch {
  int id;
  String ownerID;
  GeoJson location;
  String city;
  String brancheName;

  FromBranch(
      {this.id, this.ownerID, this.location, this.city, this.brancheName});

  FromBranch.fromJson(data) {
    if (!(data is Map)) {
      return;
    }
    Map<String, dynamic> json = data;
    id = json['id'];
    ownerID = json['ownerID'];
    location = json['location'] != null
        ? GeoJson.fromJson(json['location'])
        : null;
    city = json['city'];
    brancheName = json['brancheName'];
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
    return data;
  }
}

class GeoJson {
  double lat;
  double lon;

  GeoJson({this.lat, this.lon});

  GeoJson.fromJson(dynamic data) {
    var json = <String, dynamic>{};
    if (data == null) {
      return;
    }
    if (data is List) {
      if (data.last is Map) {
        json = data.last;
      }
    }
    if (data != null) {
      if (data is Map) {
        lat = double.tryParse(json['lat'].toString());
        lon = double.tryParse(json['lon'].toString());
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class OwnerResponse {
  int id;
  String userName;
  String userID;
  String image;
  String branch;
  bool free;
  String city;
  String phone;
  String imageURL;
  String baseURL;

  OwnerResponse(
      {this.id,
        this.userName,
        this.userID,
        this.image,
        this.branch,
        this.free,
        this.city,
        this.phone,
        this.imageURL,
        this.baseURL});

  OwnerResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userID = json['userID'];
    image = json['image'];
    branch = json['branch'];
    free = json['free'];
    city = json['city'];
    phone = json['phone'];
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['userID'] = this.userID;
    data['image'] = this.image;
    data['branch'] = this.branch;
    data['free'] = this.free;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['imageURL'] = this.imageURL;
    data['baseURL'] = this.baseURL;
    return data;
  }
}


