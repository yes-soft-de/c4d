import 'package:analyzer_plugin/protocol/protocol.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'dart:io';

class ProfileFormWidget extends StatefulWidget {
  final Function(ProfileModel) onProfileSaved;
  final Function(ProfileModel, String, String) onImageUpload;
  final isCaptain;
  final ProfileRequest profileRequest;

  @override
  _ProfileFormWidgetState createState() => _ProfileFormWidgetState();
  ProfileFormWidget({
    @required this.onProfileSaved,
    @required this.onImageUpload,
    @required this.isCaptain,
    this.profileRequest,
  });
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _stcPayController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String countryCode = '+966';
  ProfileRequest profileRequest;
  @override
  void initState() {
    super.initState();
    profileRequest = widget.profileRequest;
    if (profileRequest == null) {
    } else {
      _nameController.text = profileRequest.name;
      if (profileRequest.phone != null) {
        countryCode = profileRequest.phone.contains('+')
            ? profileRequest.phone.substring(0, 4)
            : '+966';
        _phoneController.text =
            profileRequest.phone.replaceFirst(countryCode, '0');
      }

      _stcPayController.text = profileRequest.stcPay;
      _bankAccountNumberController.text = profileRequest.bankAccountNumber;
      _bankNameController.text = profileRequest.bankName;
      _cityController.text = profileRequest.city;
    }
  }

  ProfileModel profile;
  @override
  Widget build(BuildContext context) {
    var request = profileRequest ?? ProfileRequest.empty();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                ImagePicker()
                    .getImage(source: ImageSource.gallery, imageQuality: 70)
                    .then((value) {
                  if (value != null) {
                    profile = ProfileModel(
                      image: value.path,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      stcPay: _stcPayController.text,
                      bankNumber: _stcPayController.text,
                      bankName: _bankAccountNumberController.text,
                    );
                    widget.onImageUpload(profile, null, null);
                  }
                });
              },
              child: Container(
                height: 96,
                width: 96,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        height: 96,
                        width: 96,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/logo.jpg',
                          image: '${request.image}'.contains('http')
                              ? '${request.image}'
                              : '${Urls.IMAGES_ROOT}${request.image}',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (e, s, h) {
                            return Image.asset('assets/images/logo.jpg');
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: S.of(context).name,
                labelText: S.of(context).name,
              ),
              validator: (name) {
                if (name == null) {
                  return S.of(context).nameIsRequired;
                }
                if (name.isEmpty) {
                  return S.of(context).nameIsRequired;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: S.of(context).phoneNumber,
                labelText: S.of(context).phoneNumber,
                // suffix: Container(
                //   height: 30,
                //   child: DropdownButton(
                //     underline: Container(),
                //     onChanged: (v) {
                //       countryCode = v;
                //       if (mounted) setState(() {});
                //     },
                //     value: countryCode,
                //     items: [
                //       DropdownMenuItem(
                //         value: '+966',
                //         child: Text(S.of(context).saudiArabia),
                //       ),
                //       DropdownMenuItem(
                //         value: '+961',
                //         child: Text(S.of(context).lebanon),
                //       ),
                //       DropdownMenuItem(
                //         value: '+963',
                //         child: Text(S.of(context).syria),
                //       ),
                //     ],
                //   ),
                // ),
              ),
              validator: (name) {
                if (name == null) {
                  return S.of(context).pleaseInputPhoneNumber;
                }
                if (name.isEmpty) {
                  return S.of(context).pleaseInputPhoneNumber;
                }
                if (name.length < 9) {
                  return S.of(context).phoneNumbertooShort;
                }
                return null;
              },
            ),
            widget.isCaptain
                ? _getCaptainMoreData(context, request)
                : Container(),
            widget.isCaptain == true
                ? _getPaymentExtension(context)
                : Container(),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(S.of(context).save),
                onPressed: () {
                  String phone = _phoneController.text;
                  if (phone[0] == '0') {
                    phone = phone.substring(1);
                  }
                  if (_formKey.currentState.validate()) {
                    var profile = ProfileModel(
                      image: profileRequest.image,
                      name: _nameController.text,
                      phone: countryCode + phone,
                      stcPay: _stcPayController.text,
                      bankName: _bankNameController.text,
                      bankNumber: _bankAccountNumberController.text,
                      city: _cityController.text,
                    );
                    widget.onProfileSaved(profile);
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(S.of(context).pleaseCompleteTheForm)));
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _getPaymentExtension(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        TextFormField(
          controller: _bankNameController,
          decoration: InputDecoration(
            hintText: S.of(context).bankName,
            labelText: S.of(context).bankName,
          ),
        ),
        TextFormField(
          controller: _bankAccountNumberController,
          decoration: InputDecoration(
            hintText: S.of(context).bankAccountNumber,
            labelText: S.of(context).bankAccountNumber,
          ),
        ),
        TextFormField(
          controller: _stcPayController,
          decoration: InputDecoration(
            hintText: S.of(context).stcPayCode,
            labelText: S.of(context).stcPayCode,
          ),
        ),
      ],
    );
  }

  Widget _getCaptainMoreData(BuildContext context, ProfileRequest request) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(
              hintText: S.of(context).chooseYourCity,
              labelText: S.of(context).city,
            ),
            validator: (name) {
              if (name == null) {
                return S.of(context).pleaseCompleteTheForm;
              }
              if (name.isEmpty) {
                return S.of(context).pleaseCompleteTheForm;
              }

              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Container(
                width: double.maxFinite,
                height: 45,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Text(
                  S.of(context).identity,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))),
          ),
          GestureDetector(
            onTap: () {
              ImagePicker()
                  .getImage(source: ImageSource.gallery, imageQuality: 70)
                  .then((value) {
                if (value != null) {
                  profile = ProfileModel(
                    image: request.image,
                    drivingLicence: request.drivingLicence,
                    mechanicLicense: request.mechanicLicense,
                    identity: value.path,
                    city: _cityController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    stcPay: _stcPayController.text,
                    bankNumber: _stcPayController.text,
                    bankName: _bankAccountNumberController.text,
                  );
                  widget.onImageUpload(profile, 'identity', value.path);
                }
              });
            },
            child: Container(
              height: 150,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/logo.jpg',
                        image: '${request.identity}'.contains('http')
                            ? '${request.identity}'
                            : '${Urls.IMAGES_ROOT}${request.identity}',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (e, s, h) {
                          return Image.asset('assets/images/logo.jpg');
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Container(
                width: double.maxFinite,
                height: 45,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Text(
                  S.of(context).mechanichLicence,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))),
          ),
          GestureDetector(
            onTap: () {
              ImagePicker()
                  .getImage(source: ImageSource.gallery, imageQuality: 70)
                  .then((value) {
                if (value != null) {
                  profile = ProfileModel(
                    image: request.image,
                    drivingLicence: request.drivingLicence,
                    mechanicLicense: value.path,
                    identity: request.identity,
                    city: _cityController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    stcPay: _stcPayController.text,
                    bankNumber: _stcPayController.text,
                    bankName: _bankAccountNumberController.text,
                  );
                  widget.onImageUpload(profile, 'mechanic', value.path);
                }
              });
            },
            child: Container(
              height: 150,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/logo.jpg',
                        image: '${request.mechanicLicense}'.contains('http')
                            ? '${request.mechanicLicense}'
                            : '${Urls.IMAGES_ROOT}${request.mechanicLicense}',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (e, s, h) {
                          return Image.asset('assets/images/logo.jpg');
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Container(
                width: double.maxFinite,
                height: 45,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Text(
                  S.of(context).driverLicence,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))),
          ),
          GestureDetector(
            onTap: () {
              ImagePicker()
                  .getImage(source: ImageSource.gallery, imageQuality: 70)
                  .then((value) {
                if (value != null) {
                  profile = ProfileModel(
                    image: request.image,
                    drivingLicence: value.path,
                    mechanicLicense: request.mechanicLicense,
                    identity: request.identity,
                    city: _cityController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    stcPay: _stcPayController.text,
                    bankNumber: _stcPayController.text,
                    bankName: _bankAccountNumberController.text,
                  );
                  widget.onImageUpload(profile, 'driving', value.path);
                }
              });
            },
            child: Container(
              height: 150,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/logo.jpg',
                        image: '${request.drivingLicence}'.contains('http')
                            ? '${request.drivingLicence}'
                            : '${Urls.IMAGES_ROOT}${request.drivingLicence}',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (e, s, h) {
                          return Image.asset('assets/images/logo.jpg');
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
