import 'dart:io';

import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFormWidget extends StatefulWidget {
  final Function(String, String, String) onProfileSaved;
  final Function(String, String, String) onImageUpload;
  final String name;
  final String phoneNumber;
  final String image;

  ProfileFormWidget({
    @required this.onProfileSaved,
    @required this.onImageUpload,
    this.name,
    this.phoneNumber,
    this.image,
  });

  @override
  State<StatefulWidget> createState() =>
      _ProfileFormWidgetState(name, phoneNumber);
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String localImage;

  final _formKey = GlobalKey<FormState>();

  _ProfileFormWidgetState(String name, String phone) {
    _nameController.text = name;
    _phoneController.text = phone;
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
                  widget.onImageUpload(
                    _nameController.text,
                    _phoneController.text,
                    localImage,
                  );
                  setState(() {});
                });
              },
              child: Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    widget.image == null
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.image.contains('http')
                                          ? widget.image
                                          : Urls.IMAGES_ROOT + widget.image),
                                  fit: BoxFit.cover,
                                )),
                          ),
                    localImage == null
                        ? Container()
                        : Container(
                            height: 96,
                            width: 96,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(File(localImage)),
                                  fit: BoxFit.cover,
                                )),
                            child: IconButton(
                              onPressed: () {
                                widget.onImageUpload(
                                  _nameController.text,
                                  _phoneController.text,
                                  localImage,
                                );

                                localImage = null;
                              },
                              icon: Icon(Icons.upload_file),
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
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(S.of(context).save),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.onProfileSaved(
                      _nameController.text,
                      _phoneController.text,
                      widget.image,
                    );
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
}
