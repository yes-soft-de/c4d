import 'package:c4d/consts/urls.dart';

class ProfileRequest {
  String name;
  String phone;
  String image;

  ProfileRequest({
    this.name,
    this.phone,
    this.image
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userName'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image.contains('http') ? this.image.substring(Urls.IMAGES_ROOT.length) : this.image;

    return data;
  }
}
