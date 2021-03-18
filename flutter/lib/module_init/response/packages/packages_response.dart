class PackagesResponse {
  List<Data> data;

  PackagesResponse({this.data});

  PackagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String cost;
  String note;
  String carCount;
  String city;
  String orderCount;
  String status;
  String branch;

  Data(
      {this.id,
        this.name,
        this.cost,
        this.note,
        this.carCount,
        this.city,
        this.orderCount,
        this.status,
        this.branch});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cost = json['cost'];
    note = json['note'];
    carCount = json['carCount'];
    city = json['city'];
    orderCount = json['orderCount'];
    status = json['status'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['cost'] = this.cost;
    data['note'] = this.note;
    data['carCount'] = this.carCount;
    data['city'] = this.city;
    data['orderCount'] = this.orderCount;
    data['status'] = this.status;
    data['branch'] = this.branch;
    return data;
  }
}
