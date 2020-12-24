
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status_for_owner/order_status_for_owner.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';

class OwnerOrdersScreen extends StatefulWidget {
  @override
  _OwnerOrdersScreenState createState() => _OwnerOrdersScreenState();
}

class _OwnerOrdersScreenState extends State<OwnerOrdersScreen> {
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
      body:
      ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context , int index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderStatusForOwnerScreen()
                  )
                );
              },
              child: OwnerOrderCard(
                to: '365 East Ave.',
                from: '4.1 mi via Washinton BivdArrival',
                time: '9:56 AM',
                index : index
              ),
            ),
          );
        }),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewOrderScreen()),
          );
        },
          child: Container(
            height: 45,
            color: ProjectColors.SECONDARY_COLOR,
            child: Center(
              child: Text(
                'Request New Delivery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ),
    );
  }
}
