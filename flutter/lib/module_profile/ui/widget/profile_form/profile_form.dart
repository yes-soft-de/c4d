import 'dart:io';

import 'package:c4d/consts/urls.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFormWidget extends StatefulWidget {
  final Function(String, String, String) onProfileSaved;
  final Function(String) onImageUpload;
  final String name;
  final String phoneNumber;
  final String image;

  ProfileFormWidget(
    this.onProfileSaved,
    this.onImageUpload, {
    this.name,
    this.phoneNumber,
    this.image,
  });

  @override
  State<StatefulWidget> createState() =>
      _ProfileFormWidgetState(name, phoneNumber, image);
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String image;
  String newImage;

  _ProfileFormWidgetState(String name, String phone, String image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
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
                  newImage = value.path;
                });
              },
              child: Container(
                height: 96,
                width: 96,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(image.contains('http') ? image : Urls.IMAGES_ROOT + image),
                        fit: BoxFit.cover,
                      )),
                    ),
                    newImage == null
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: FileImage(File(image)),
                              fit: BoxFit.cover,
                            )),
                            child: IconButton(
                              onPressed: () {
                                widget.onImageUpload(image);
                              },
                              icon: Icon(Icons.upload_file),
                            ),
                          )
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
            RaisedButton(onPressed: () {
              widget.onProfileSaved(
                _nameController.text,
                _phoneController.text,
                image,
              );
            })
          ],
        ),
      ),
    );
  }
}
