
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state/owner_orders/owner_orders.state.dart';
import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/error_ui/error_ui.dart';
import 'package:c4d/utils/loading_indicator/loading_indicator.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OwnerOrdersScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;

  OwnerOrdersScreen(
      this._stateManager,
      );

  @override
  _OwnerOrdersScreenState createState() => _OwnerOrdersScreenState();
}

class _OwnerOrdersScreenState extends State<OwnerOrdersScreen> {
  List<OrderModel> myOrders =[];
  OwnerOrdersState currentState = OwnerOrdersInitState();
  bool loading = true;
  bool error = false;

   @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent(){
    if(currentState is OwnerOrdersFetchingDataSuccessState){
      OwnerOrdersFetchingDataSuccessState state = currentState;
      myOrders = state.data;
      loading = false;
      error = false;
    }
    if(currentState is OwnerOrdersFetchingDataErrorState){
      loading = false;
      error = true;
    }
    if (this.mounted) {
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    if (currentState is OwnerOrdersInitState) {
      widget._stateManager.getNearbyOrders();
      if (this.mounted) {
        setState(() {});
      }
    }

    return error
        ? ErrorUi(onRetry: () {
      widget._stateManager.getNearbyOrders();
      loading = true;
      error = false;
    })
        : loading
        ? LoadingIndicatorWidget()
        : screenUi() ;
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
        itemCount: myOrders.length,
        itemBuilder: (BuildContext context , int index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                  context,
                   OrdersRoutes.ORDER_STATUS_FOR_OWNER_SCREEN,
                  arguments: myOrders[index].id
                );
              },
              child: OwnerOrderCard(
                to: myOrders[index].to,
                from:  myOrders[index].from,
                time: myOrders[index].creationTime,
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
