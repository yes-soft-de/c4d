import 'package:c4d/module_profile/model/activity_model/activity_model.dart';
import 'package:c4d/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:c4d/module_profile/ui/states/activity_state/activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ActivityStateRecordsLoaded extends ActivityState {
  List<ActivityModel> activity;

  ActivityStateRecordsLoaded(ActivityScreenState screen, this.activity)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    var list = <Widget>[];

    list.addAll(activity.map(
      (e) => Card(
        child: ListTile(
          leading: Icon(Icons.check),
          title: Text('${e.activity}'),
          subtitle: Text('Took ${e.startDate.difference(e.endDate).inMinutes.abs().toString()} Minutes'),
        ),
      ),
    ));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: list,
        ),
      ),
    );
  }

}
