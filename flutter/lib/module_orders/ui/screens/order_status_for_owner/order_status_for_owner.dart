
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';

class OrderStatusForOwnerScreen extends StatefulWidget {
  @override
  _OrderStatusForOwnerScreenState createState() => _OrderStatusForOwnerScreenState();
}

class _OrderStatusForOwnerScreenState extends State<OrderStatusForOwnerScreen> {
  String paymentMethod = 'Online';
  String time = '12:30 AM';
  String id = '7CX6F';

  @override
  Widget build(BuildContext context) {
    return screenUi();
  }

  Widget screenUi(){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Order Status',
            style: TextStyle(
                color: Colors.black
            ),
          ),
          actions: [
            Icon(
              Icons.flag,
              color: ProjectColors.THEME_COLOR,
            ),
            Icon(
              Icons.notifications,
              color: ProjectColors.THEME_COLOR,
            )
          ],
        ),
        body:SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Column(
              children: [
                Text(
                    'Payment : $paymentMethod',
                  style: TextStyle(
                    fontSize: 10
                  ),
                ),
                Image(
                  image: AssetImage(
                      'assets/images/track.png'
                  ),
                  height: 150,
                  width: 150,
                ),

                Image(
                  image: AssetImage(
                      'assets/images/Group 181.png'
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width*0.8,
                ),
                 Container(
                   height: 100,
                   width: MediaQuery.of(context).size.width*0.9,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: ProjectColors.THEME_COLOR,
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         'Order Time : $time',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                       ),
                       Text(
                         'Order ID : $id',
                         style: TextStyle(
                           color: Colors.white,
                         ),
                       ),
                     ],
                   )
                 ),

                SizedBox(height: 40,),

                CommunicationCard(
                  text: 'Whatsapp with Captain',
                  image: 'assets/images/whatsapp2.png',
                  textColor: ProjectColors.THEME_COLOR,

                ),
                CommunicationCard(
                  text: 'Whatsapp with User',
                  image: 'assets/images/whatsapp2.png',
                  textColor: ProjectColors.THEME_COLOR,
                ),
                CommunicationCard(
                  text: 'Chat with Captain',
                  image: 'assets/images/bi_chat-dots.png',
                  textColor: Colors.white,
                  color: ProjectColors.THEME_COLOR,
                ),


              ],
            ),
          ),
        )

    );
  }
}
