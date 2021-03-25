class CompanyInfoResponse {
  int id;
  String phone;
  String phone2;
  String whatsapp;
  String fax;
  String bank;
  String stc;
  String email;
  String uuid;
  CompanyInfoResponse(
      {this.id,
      this.phone,
      this.phone2,
      this.whatsapp,
      this.bank,
      this.email,
      this.fax,
      this.stc,
      this.uuid});

  CompanyInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    phone2 = json['phone2'];
    whatsapp = json['whatsapp'];
    bank = json['bank'];
    email = json['email'];
    fax = json['fax'];
    stc = json['stc'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['whatsapp'] = this.whatsapp;
    data['bank'] = this.bank;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['stc'] = this.stc;
    data['uuid'] = this.uuid;
    return data;
  }
}
