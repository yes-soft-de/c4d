import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/module_orders/utils/icon_helper/order_progression_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsStateCaptainOrderLoaded extends OrderDetailsState {
  OrderModel currentOrder;

  OrderDetailsStateCaptainOrderLoaded(
      this.currentOrder, OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: OrderProgressionHelper.getStatusIcon(currentOrder.status),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StepProgressIndicator(
            totalSteps: 5,
            currentStep: currentOrder.status.index,
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
          height: 56,
        ),
        // To Progress the Order
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ChatRoutes.chatRoute,
              arguments: currentOrder.chatRoomId,
            );
          },
          child: CommunicationCard(
            text: OrderProgressionHelper.getNextStageHelper(
              currentOrder.status,
              context,
            ),
            color: Theme.of(context).accentColor,
            image: 'assets/images/whatsapp.png',
          ),
        ),
        // To Chat with Store owner in app
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ChatRoutes.chatRoute,
              arguments: currentOrder.chatRoomId,
            );
          },
          child: CommunicationCard(
            text: 'Chat with Store Owner',
            image: 'assets/images/WhatsApp.png',
          ),
        ),
        // To WhatsApp with store owner
        GestureDetector(
          onTap: () async {
            var url = 'https://wa.me/${currentOrder.ownerPhone}';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: CommunicationCard(
            text: 'WhatsApp with Store Owner',
            image: 'assets/images/whatsapp.png',
          ),
        ),
        // To WhatsApp with client
        GestureDetector(
          onTap: () async {
            var url = 'https://wa.me/${currentOrder.ownerPhone}';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: CommunicationCard(
            text: 'WhatsApp with Client',
            image: 'assets/images/whatsapp.png',
          ),
        ),
        // To Open Maps
        GestureDetector(
          onTap: () {
            var url =
                'https://www.google.com/maps/dir/?api=1&destination=${currentOrder.toOnMap.latitude},${currentOrder.toOnMap.longitude}';
            canLaunch(url).then((value) {
              if (value) {
                launch(url);
              }
            });
          },
          child: CommunicationCard(
            text: 'Get Direction',
            image: 'assets/images/map.png',
          ),
        ),
      ],
    );
  }
}
