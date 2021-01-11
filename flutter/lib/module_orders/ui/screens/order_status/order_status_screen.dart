import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/state_manager/order_status_for_captain/order_status_for_captain.state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

@provide
class OrderStatusScreen extends StatefulWidget {
  final OrderStatusForCaptainStateManager _stateManager;

  OrderStatusScreen(
    this._stateManager,
  );

  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  OrderModel order;

  OrderStatusState currentState = OrderStatusInitState();
  bool loading = true;
  bool error = false;
  String orderId;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is OrderStatusFetchingDataSuccessState) {
      OrderStatusFetchingDataSuccessState state = currentState;
      order = state.data;
      loading = false;
      error = false;
    }
    if (currentState is OrderStatusFetchingDataErrorState) {
      loading = false;
      error = true;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    orderId = ModalRoute.of(context).settings.arguments;

    if (currentState is OrderStatusInitState ||
        currentState is OrderStatusFetchingDataState) {
      widget._stateManager.getOrderDetails(orderId);
      if (this.mounted) {
        setState(() {});
      }
      return loadingUi();
    }

    if (currentState is OrderStatusFetchingDataSuccessState) {
      return screenUi();
    }

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Error',
              textAlign: TextAlign.center,
            ),
            RaisedButton(
                child: Text('Retry'),
                onPressed: () {
                  widget._stateManager.getOrderDetails(orderId);
                }),
          ],
        ));
  }

  Widget errorUi() {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Error'),
          RaisedButton(
            child: Text('Retry'),
            onPressed: () {
              widget._stateManager.getOrderDetails(orderId);
            },
          )
        ],
      ),
    ));
  }

  Widget loadingUi() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget screenUi() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Order Status',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Icon(
              Icons.flag,
              color: AppThemeDataService.PrimaryColor,
            ),
            Icon(
              Icons.notifications,
              color: AppThemeDataService.PrimaryColor,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(
                    'assets/images/searching.svg',
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Searching for a captain',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StepProgressIndicator(
                    totalSteps: 5,
                    currentStep: 0,
                  ),
                ),
                Text(
                  timeago.format(DateTime.parse(order.creationTime)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
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
                CommunicationCard(
                  text: 'Get Direction',
                  image: 'assets/images/map.png',
                ),
              ],
            ),
          ),
        ));
  }

  Widget getPendingCaptainUi() {
    return Scaffold(
      appBar: AppBar(),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: SvgPicture.asset(
              'assets/images/searching.svg',
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
