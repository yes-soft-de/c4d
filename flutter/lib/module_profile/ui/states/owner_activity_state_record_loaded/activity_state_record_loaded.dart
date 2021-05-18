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
    list.addAll(activity.map((e) {
      return GestureDetector(
        onTap: () {
          orderId = e.activity.split('#');
          Navigator.of(context).pushNamed(ProfileRoutes.ORDER_INFO_SCREEN,
              arguments: int.parse(orderId[1].toString()));
        },
        child: Card(
          child: ListTile(
            leading: Icon(Icons.check),
            title: Text('${e.activity}'),
            subtitle: Text(S.of(context).took +
                ' ' +
                complationDate(context, e.startDate, e.endDate)),
          ),
        ),
      );
    }));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: list,
        ),
      ),
    );
  }

  String complationDate(context, DateTime startTime, DateTime endTime) {
    int days = 0;
    int hours = 0;
    int minutes = 0;
    int seconds = startTime.difference(endTime).inSeconds.abs();
    if (seconds >= 60) {
      minutes += (seconds / 60).floor();
      seconds = seconds - (minutes * 60);
    }
    if (minutes >= 60) {
      hours += (minutes / 60).floor();
      minutes = minutes - (hours * 60);
    }
    if (hours >= 24) {
      days += (hours / 24).floor();
      hours = hours - (days * 24);
    }

    String day = days > 0 ? '$days ${S.of(context).days}' : '';
    String hour = hours > 0 ? '$hours ${S.of(context).hours}' : '';
    String minute = minutes > 0 ? '$minutes ${S.of(context).minutes}' : '';
    String second = seconds > 0 ? '$seconds ${S.of(context).seconds}' : '';

    return '$day $hour $minute $second';
  }
}
