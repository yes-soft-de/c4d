import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderCard extends StatelessWidget {
  final String from;
  final String to;
  final String time;
  final int index;

  OrderCard({
    this.time,
    this.from,
    this.to,
    this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      color: index == 0 ? ProjectColors.THEME_COLOR : Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 115,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$from',
                  style: TextStyle(
                    color:
                        index == 0 ? Colors.white : ProjectColors.THEME_COLOR,
                    fontSize: 20,
                  ),
                ),
                Text(
                  timeago.format(DateTime.parse(time)),
                  style: TextStyle(
                    color:
                        index == 0 ? Colors.white : ProjectColors.THEME_COLOR,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Center(
              child: CircleAvatar(
                backgroundColor:
                    index == 0 ? Colors.white : ProjectColors.THEME_COLOR,
                child: Icon(
                  Icons.arrow_forward,
                  color: index == 0 ? ProjectColors.THEME_COLOR : Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
