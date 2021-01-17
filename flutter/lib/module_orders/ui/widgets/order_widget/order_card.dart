import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';

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
                  '$from',
                  style: TextStyle(
                    color: index == 0
                        ? Colors.white
                        : AppThemeDataService.PrimaryColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: index == 0
                        ? Colors.white
                        : AppThemeDataService.PrimaryColor,
                    fontSize: 12,
                  ),
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
