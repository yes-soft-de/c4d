
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return screenUi();
  }

  Widget screenUi(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
          },
          icon: Icon(
            Icons.arrow_back,
            color: ProjectColors.THEME_COLOR,
          ),

        ),


      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/content.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: null /* add child content here */,
      ),

      bottomNavigationBar:  Container(
          height: 80,
          color: ProjectColors.THEME_COLOR,
          child: Column(
             children: [
               Text(
                 'You will arrive at 9:15',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 12,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               Text(
                 '12 min - 6 miles',
                 style: TextStyle(
                   color: Colors.white70,
                   fontSize: 10,
                   fontWeight: FontWeight.bold,
                 ),
               ),
             ],
          ),

      ),
    );
  }
}
