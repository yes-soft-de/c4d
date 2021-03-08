import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';

class ProfileFormWidget extends StatelessWidget {
  final Function(ProfileModel) onProfileSaved;
  final Function(ProfileModel) onImageUpload;
  final isCaptain;
  final ProfileRequest profileRequest;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stcPayController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ProfileFormWidget({
    @required this.onProfileSaved,
    @required this.onImageUpload,
    @required this.isCaptain,
    this.profileRequest,
  }) {
    if (profileRequest == null) {
      return;
    }
    _nameController.text = profileRequest.name;
    _phoneController.text = profileRequest.phone;
    _stcPayController.text = profileRequest.stcPay;
    _bankAccountNumberController.text = profileRequest.bankAccountNumber;
    _bankNameController.text = profileRequest.bankName;
  }


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
                    .getImage(source: ImageSource.gallery)
                    .then((value) {
                  var profile = ProfileModel(
                    image: value.path,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    stcPay: _stcPayController.text,
                    bankNumber: _stcPayController.text,
                    bankName: _bankAccountNumberController.text,
                  );
                  onImageUpload(profile);
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
                            print('Error: ' + s.toString());
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
              ),
              validator: (name) {
                if (name == null) {
                  return S.of(context).pleaseInputPhoneNumber;
                }
                if (name.isEmpty) {
                  return S.of(context).pleaseInputPhoneNumber;
                }
                return null;
              },
            ),
            isCaptain == true ? _getPaymentExtension(context) : Container(),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(S.of(context).save),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var profile = ProfileModel(
                      image: profileRequest.image,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      stcPay: _stcPayController.text,
                      bankName: _bankNameController.text,
                      bankNumber: _bankNameController.text,
                    );
                    onProfileSaved(profile);
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
}

