import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';

class OwnerOrderCard extends StatelessWidget {
  final String from;
  final String to;
  final String time;
  final int index;

  OwnerOrderCard({
    this.time,
    this.from,
    this.to,
    this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      elevation: 0,
      color: index == 0 ? AppThemeDataService.PrimaryColor : Colors.white,
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
                  'to $to',
                  style: TextStyle(
                      color: index == 0
                          ? Colors.white
                          : AppThemeDataService.PrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                Text(
                  '$from',
                  style: TextStyle(
                      color: index == 0
                          ? Colors.white
                          : AppThemeDataService.PrimaryColor,
                      fontSize: 10),
                ),
                Text(
                  'time: $time',
                  style: TextStyle(
                      color: index == 0
                          ? Colors.white
                          : AppThemeDataService.PrimaryColor,
                      fontSize: 10),
                ),
              ],
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: index == 0
                    ? Colors.white
                    : AppThemeDataService.PrimaryColor,
                child: Icon(
                  Icons.arrow_forward,
                  color: index == 0
                      ? AppThemeDataService.PrimaryColor
                      : Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
