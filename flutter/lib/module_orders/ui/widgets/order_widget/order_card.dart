import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  final bool active;

  OrderCard({
    this.time,
    this.title,
    this.subTitle,
    this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      color: active == true ? Theme.of(context).primaryColor : Colors.white,
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
                  '$title',
                  style: TextStyle(
                    color: active == true
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '$time',
                  style: TextStyle(
                    color: active == true
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: active == true
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                child: Icon(
                  Icons.arrow_forward,
                  color: active == true
                      ? Theme.of(context).primaryColor
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
