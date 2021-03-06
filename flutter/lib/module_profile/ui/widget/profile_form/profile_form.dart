import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';

class ProfileFormWidget extends StatefulWidget {
  final Function(ProfileModel) onProfileSaved;
  final Function(ProfileModel) onImageUpload;
  final isCaptain;
  final ProfileRequest request;

  ProfileFormWidget({
    @required this.onProfileSaved,
    @required this.onImageUpload,
    @required this.isCaptain,
    this.request,
  });

  @override
  State<StatefulWidget> createState() => _ProfileFormWidgetState(
        request != null ? request.name : null,
        request != null ? request.phone : null,
        request != null ? request.stcPay : null,
        request != null ? request.bankAccountNumber : null,
        request != null ? request.bankName : null,
      );
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stcPayController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();

  var currentProfile = ProfileModel();

  final _formKey = GlobalKey<FormState>();

  _ProfileFormWidgetState(String name, String phone, String stcPay,
      String bankNumber, String bankName) {
    _nameController.text = name;
    _phoneController.text = phone;
    _stcPayController.text = stcPay;
    _bankAccountNumberController.text = bankNumber;
    _bankNameController.text = bankName;
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.onImageUpload(profile);
                  setState(() {});
                });
              },
              child: Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: widget.request == null
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/logo.jpg',
                          height: 80,
                          width: 80,
                          image: widget.request.image.contains('http')
                              ? widget.request.image
                              : Urls.IMAGES_ROOT + widget.request.image,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (e, s, h) {
                            return Image.asset('assets/images/logo.jpg');
                          },
                        ),
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
            widget.isCaptain == true ? _getPaymentExtension() : Container(),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(S.of(context).save),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var profile = ProfileModel(
                      image: widget.request.image,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      stcPay: _stcPayController.text,
                      bankName: _bankNameController.text,
                      bankNumber: _bankNameController.text,
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

  Widget _getPaymentExtension() {
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
