import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:timeago/timeago.dart' as timeago;


class OrderDetailsStateOwnerOrderLoaded extends OrderDetailsState {
  OrderModel currentOrder;

  OrderDetailsStateOwnerOrderLoaded(
      this.currentOrder, OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
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
          timeago.format(DateTime.parse(currentOrder.creationTime)),
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
    );
  }
}
