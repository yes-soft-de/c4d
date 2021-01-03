
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/utils/error_ui/error_ui.dart';
import 'package:c4d/utils/loading_indicator/loading_indicator.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrderStatusForOwnerScreen extends StatefulWidget {
  final OrderStatusStateManager _stateManager;

  OrderStatusForOwnerScreen(
      this._stateManager,
      );

  @override
  _OrderStatusForOwnerScreenState createState() => _OrderStatusForOwnerScreenState();
}

class _OrderStatusForOwnerScreenState extends State<OrderStatusForOwnerScreen> {
  OrderModel order  ;
  OrderStatusState currentState = OrderStatusInitState();
  bool loading = true;
  bool error = false;
  int oderId;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent(){
    if(currentState is OrderStatusFetchingDataSuccessState){
      OrderStatusFetchingDataSuccessState state = currentState;
      order = state.data;
      loading = false;
      error = false;
    }
    if(currentState is OrderStatusFetchingDataErrorState){
      loading = false;
      error = true;
    }
    if (this.mounted) {
      setState(() {});
    }

  }
  @override
  Widget build(BuildContext context) {
    oderId = ModalRoute.of(context).settings.arguments;

    if (currentState is  OrderStatusInitState) {
      widget._stateManager.getOrderDetails(oderId);
      if (this.mounted) {
        setState(() {});
      }
    }

    return error
        ? ErrorUi(onRetry: () {
      widget._stateManager.getOrderDetails(oderId);
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
                    'Payment : ${order.paymentMethod}',
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
                         'Order Time :  ${order.creationTime}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                       ),
                       Text(
                         'Order ID : ${order.id}',
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
