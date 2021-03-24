import 'dart:io';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class InitAccountCaptainInitProfile extends InitAccountState {
  Uri captainImage;
  Uri driverLicence;
  String name;
  String age;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  InitAccountCaptainInitProfile(InitAccountScreenState screenState)
      : super(screenState);

  InitAccountCaptainInitProfile.withData(InitAccountScreenState screenState,
      this.captainImage, this.driverLicence, this.name, this.age)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (this.name != null) {
      _nameController.text = this.name;
    }

    if (this.age != null) {
      _ageController.text = this.age;
    }

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Card(
                    child: GestureDetector(
                      onTap: () {
                        ImagePicker()
                            .getImage(source: ImageSource.gallery)
                            .then((value) {
                          if (value != null) {
                            captainImage = Uri(path: value.path);
                            screen.refresh();
                          }
                        });
                      },
                      child: Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              )),
                              _getCaptainImageFG(),
                            ],
                          )),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 156,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: S.of(context).name,
                            labelText: S.of(context).name,
                          ),
                        ),
                        Container(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            hintText: S.of(context).age,
                            labelText: S.of(context).age,
                          ),
                          keyboardType: TextInputType.number,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Text(
                  S.of(context).driverLicence,
                  textAlign: TextAlign.start,
                ),
                _getDriverLicenceFG(),
              ],
            ),
          ),
          FlatButton(
              onPressed: captainImage == null || captainImage == null
                  ? null
                  : () {
                      screen.submitProfile(captainImage, driverLicence, _nameController.text, _ageController.text);
                    },
              child: Text(
                S.of(context).uploadAndSubmit,
              ))
        ],
      ),
    );
  }

  Widget _getDriverLicenceFG() {
    if (driverLicence != null) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            ImagePicker().getImage(source: ImageSource.gallery).then((value) {
              if (value != null) {
                captainImage = Uri(path: value.path);
                screen.refresh();
              }
            });
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(driverLicence.path)),
                          fit: BoxFit.cover)),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          ImagePicker().getImage(source: ImageSource.gallery).then((value) {
            if (value != null) {
              driverLicence = Uri(path: value.path);
              screen.refresh();
            }
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black12,
                child: Icon(Icons.camera),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getCaptainImageFG() {
    if (captainImage != null) {
      return Container(
          decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(File.fromUri(captainImage)),
          fit: BoxFit.cover,
        ),
      ));
    } else {
      return Container();
    }
  }
}
