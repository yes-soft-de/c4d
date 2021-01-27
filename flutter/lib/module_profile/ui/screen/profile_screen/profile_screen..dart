import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/state_manager/profile_state_manager.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/states/profile_state_loading/profile_state_loading.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ProfileScreen extends StatefulWidget {
  final ProfileStateManager _profileStateManager;

  ProfileScreen(this._profileStateManager);

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileState _currentState;

  @override
  void initState() {
    _currentState = ProfileStateLoading(this);
    widget._profileStateManager.getMyProfile(this);
    widget._profileStateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).activityLog,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.white),
        ),
      ),
      body: _currentState.getUI(context),
    );
  }
}
