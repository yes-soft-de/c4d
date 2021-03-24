import 'package:flutter/material.dart';

class CommunicationCard extends StatelessWidget {
  final String text;
  final Widget image;
  final Color textColor;
  final Color color;

  CommunicationCard({
    this.text,
    this.image,
    this.textColor,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: getBGColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(text, style: TextStyle(color: getTextColor(context)),),
          leading: image,
        )
      ),
    );
  }

  Color getBGColor(BuildContext context) {
    if (color != null) {
      return color;
    }
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
  }

  Color getTextColor(BuildContext context) {
    if (textColor != null) {
      return textColor;
    }
    return Theme.of(context).brightness != Brightness.light
        ? Colors.white
        : Colors.black;
  }
}
