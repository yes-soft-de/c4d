import 'package:flutter/material.dart';

class CommunicationCard extends StatelessWidget {
  final String text;
  final Widget image;
  final Color textColor;
  final Color color;

  CommunicationCard({
    this.text,
    this.image,
    this.textColor = Colors.black,
    this.color = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(text, style: TextStyle(color: textColor),),
          leading: image,
        )
      ),
    );
  }
}
