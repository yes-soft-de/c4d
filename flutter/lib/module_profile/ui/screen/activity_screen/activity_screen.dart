import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/state_manager/activity/activity_state_manager.dart';
import 'package:c4d/module_profile/ui/states/activity_state/activity_state.dart';
import 'package:c4d/module_profile/ui/states/activity_state_loading/activity_state_loading.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ActivityScreen extends StatefulWidget {
  final ActivityStateManager _profileStateManager;

  ActivityScreen(this._profileStateManager);

  @override
  State<StatefulWidget> createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {
  ActivityState _currentState;

  @override
  void initState() {
    _currentState = ActivityStateLoading(this);
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
