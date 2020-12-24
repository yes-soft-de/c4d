
import 'package:flutter/material.dart';

class CommunicationCard extends StatelessWidget {
  final String text;
  final String image;
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
      color: color ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width*0.9,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image(
                image: AssetImage(
                    '$image'
                ),
              ),
           SizedBox(width: 20,),
            Center(
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 10,
                  color: textColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
