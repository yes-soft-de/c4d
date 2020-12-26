
import 'package:c4d/module_orders/ui/screens/order_status_for_captain/order_status_for_captain_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
          'Orders',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body:
      ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context , int index){
          return Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderStatusForCaptainScreen()
                    )
                );
              },
              child: OrderCard(
                to: '365 East Ave.',
                from: '4.1 mi via Washinton BivdArrival',
                time: '9:56 AM',
                index: index,
              ),
            ),
          );
        })
    );
  }
}
