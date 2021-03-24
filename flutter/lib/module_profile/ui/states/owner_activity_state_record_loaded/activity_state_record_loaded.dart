import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/model/activity_model/activity_model.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:c4d/module_profile/ui/states/activity_state/activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timeago/timeago.dart' as timeago;

class OwnerActivityStateRecordsLoaded extends ActivityState {
  List<ActivityModel> activity;

  OwnerActivityStateRecordsLoaded(ActivityScreenState screen, this.activity)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    var list = <Widget>[];
    List<String> orderId;
    list.addAll(activity.map(
      (e) => GestureDetector(
        onTap: () {
          orderId = e.activity.split('#');
          Navigator.of(context).pushNamed(ProfileRoutes.ORDER_INFO_SCREEN,
              arguments: int.parse(orderId[1].toString()));
        },
        child: Card(
          child: ListTile(
            leading: Icon(Icons.check),
            title: Text('${e.activity}'),
            subtitle: Text(
              S.of(context).took +
                  ' ' +
                  e.startDate.difference(e.endDate).inMinutes.abs().toString() +
                  ' ' +
                  S.of(context).minutes,
            ),
          ),
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
