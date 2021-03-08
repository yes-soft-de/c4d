class CreateCaptainProfileRequest {
  String image;
  String drivingLicence;
  int age;
  String name;

  CreateCaptainProfileRequest(
    this.image,
    this.drivingLicence,
    this.age,
    this.name,
  );

  Map<String, dynamic> toJSON() {
    return {
      'image': image,
      'drivingLicence': drivingLicence,
      'age': age,
      'name': name,
      'bankName': 'Bank Name',
      'stcPay': 'STC Pay',
      'accountID': '1234 4567 7896'
    };
  }
}
