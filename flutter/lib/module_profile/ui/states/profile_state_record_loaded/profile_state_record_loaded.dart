import 'package:c4d/module_profile/response/get_records_response.dart';
import 'package:c4d/module_profile/ui/screen/profile_screen/profile_screen..dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateRecordsLoaded extends ProfileState {
  List<String> activity;

  ProfileStateRecordsLoaded(ProfileScreenState screen, this.activity)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    var list = <Widget>[];
    list.add(
      Container(
        height: 200,
        child: SparkBar.withSampleData(),
      ),
    );

    list.add(
      Container(
        height: 56,
      ),
    );

    list.addAll(activity.map(
      (e) => Card(
        child: ListTile(
          leading: Icon(Icons.timelapse),
          title: Text('$e'),
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
