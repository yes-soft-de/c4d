import 'dart:io';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/ui/screens/init_captain/init_account_captain_screen.dart';
import 'package:c4d/module_init/ui/state/init_account_captain/init_account_captain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class InitAccountCaptainInitProfile extends InitAccountCaptainState {
  Uri captainImage;
  Uri driverLicence;
  String name;
  String age;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  InitAccountCaptainInitProfile(InitAccountCaptainScreenState screenState)
      : super(screenState);

  InitAccountCaptainInitProfile.withData(InitAccountCaptainScreenState screenState, this.captainImage, this.driverLicence, this.name, this.age)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (this.name != null) {
      _nameController.text = this.name;
    }

    if (this.age != null) {
      _ageController.text = this.age;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  ImagePicker()
                      .getImage(source: ImageSource.camera)
                      .then((value) {
                    captainImage = Uri(path: value.path);
                    screenState.refresh();
                  });
                },
                child: Container(
                    height: 56,
                    width: 56,
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
              Flex(
                direction: Axis.vertical,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
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
            ],
          ),
        ),
        Expanded(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Text(S.of(context).driverLicence),
              _getDriverLicenceFG(),
            ],
          ),
        ),
        FlatButton(
            onPressed: captainImage == null || captainImage == null
                ? null
                : () {
                    screenState.showSnackBar(
                        S.of(context).thisMightTakeAWhilePleaseWait);

                  },
            child: Text(
              S.of(context).uploadAndSubmit,
            ))
      ],
    );
  }

  Widget _getDriverLicenceFG() {
    if (driverLicence != null) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            ImagePicker().getImage(source: ImageSource.camera).then((value) {
              captainImage = Uri(path: value.path);
              screenState.refresh();
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
          ImagePicker().getImage(source: ImageSource.camera).then((value) {
            captainImage = Uri(path: value.path);
            screenState.refresh();
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
