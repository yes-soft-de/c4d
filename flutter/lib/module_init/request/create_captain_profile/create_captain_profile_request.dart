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
    };
  }
}
