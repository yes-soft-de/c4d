import 'package:c4d/module_profile/model/activity_model/activity_model.dart';
import 'package:c4d/module_profile/ui/screen/profile_screen/profile_screen..dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as common;

class ProfileStateRecordsLoaded extends ProfileState {
  List<ActivityModel> activity;

  ProfileStateRecordsLoaded(ProfileScreenState screen, this.activity)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    var list = <Widget>[];
    list.add(
      Container(
        height: 200,
        child: charts.BarChart(
          getChartableData(),
        ),
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
          title: Text('${e.activity}'),
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

  List<common.Series<dynamic, String>> getChartableData() {
    return [
      new charts.Series<ActivityModel, String>(
        id: 'Orders',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ActivityModel record, _) => record.date.toString().substring(0, 10),
        measureFn: (ActivityModel sales, _) => 1,
        data: activity,
      )
    ];
  }
}
