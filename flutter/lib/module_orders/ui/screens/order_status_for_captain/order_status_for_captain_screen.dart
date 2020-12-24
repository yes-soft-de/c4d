
import 'package:c4d/module_orders/ui/screens/map/map_screen.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';

class OrderStatusForCaptainScreen extends StatefulWidget {
  @override
  _OrderStatusForCaptainScreenState createState() => _OrderStatusForCaptainScreenState();
}

class _OrderStatusForCaptainScreenState extends State<OrderStatusForCaptainScreen> {
  String paymentMethod = 'Online';
  String time = '00 : 17';

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
          child: Column(
            children: [
               Image(
                image: AssetImage(
                  'assets/images/track.png'
                ),
                 height: 150,
                 width: 150,
              ),
              Text(
                'Payment : $paymentMethod'
              ),
              Image(
                image: AssetImage(
                    'assets/images/Group 152.png'
                ),
                height: 100,
                width: MediaQuery.of(context).size.width*0.8,
              ),
              Text(
                  '$time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50
                ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){},
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffBE1E2D),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'I Got the Product',
                      style: TextStyle(
                        color: Colors.white,

                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              CommunicationCard(
                text: 'Whatsapp with Store Owner',
                image: 'assets/images/whatsapp.png',
              ),
              CommunicationCard(
                text: 'Whatsapp with User',
                image: 'assets/images/whatsapp.png',
              ),
              CommunicationCard(
                text: 'Chat with Store Owner',
                image: 'assets/images/bi_chat-dots.png',
              ),

               GestureDetector(
                 onTap: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (
                             (context)=> MapScreen()
                         )
                       )
                   );
                 },
                 child: Container(
                   padding: EdgeInsets.all(10),
                   width: MediaQuery.of(context).size.width*0.9,
                   height: 50,
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/images/map.png'
                        ),
                      ),
                      SizedBox(width: 20,),
                      Center(
                        child: Text(
                          'Get Directions',
                          style: TextStyle(
                              fontSize: 10
                          ),
                        ),
                      )
                    ],
              ),
                 ),
               ),
            ],
          ),
        ),
      )

    );
  }
}
