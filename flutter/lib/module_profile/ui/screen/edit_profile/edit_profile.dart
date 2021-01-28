import 'package:c4d/module_profile/state_manager/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class EditProfileScreen extends StatefulWidget {
  final EditProfileStateManager _stateManager;

  EditProfileScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  List<ProfileState> states = [];

  void saveProfile(String name, String phone, String image) {
    widget._stateManager.submitProfile(this, name, phone, image);
  }

  void uploadImage(String name, String phone, String image) {
    widget._stateManager.uploadImage(this, image, name, phone);
  }

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      states.add(event);
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getProfile(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (states.isEmpty) {
      states.add(ProfileStateLoading(this));
    }
    return Scaffold(body: states.last.getUI(context));
  }
}
