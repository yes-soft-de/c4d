import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/module_orders/utils/icon_helper/order_progression_helper.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:timeago/timeago.dart' as timeago;

class OrderDetailsStateCaptainOrderLoaded extends OrderDetailsState {
  OrderModel currentOrder;

  OrderDetailsStateCaptainOrderLoaded(
    this.currentOrder,
    OrderStatusScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    print(currentOrder.id.toString());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OrderProgressionHelper.getStatusIcon(
                currentOrder.status, context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StepProgressIndicator(
              totalSteps: 5,
              currentStep: currentOrder.status.index,
            ),
          ),
          Text(
            timeago.format(currentOrder.creationTime),
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
          currentOrder.status == OrderStatus.FINISHED ? Container() : GestureDetector(
            onTap: () {
              screenState.requestOrderProgress(currentOrder);
            },
            child: CommunicationCard(
              text: OrderProgressionHelper.getNextStageHelper(
                currentOrder.status,
                currentOrder.paymentMethod.toLowerCase().contains('ca'),
                context,
              ),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              image: Icon(Icons.navigate_next_sharp, color: Colors.white,),
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
              text: S.of(context).chatWithStoreOwner,
              image: Icon(Icons.chat_rounded),
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
              text: S.of(context).whatsappWithStoreOwner,
              image: FaIcon(FontAwesomeIcons.whatsapp),
            ),
          ),
          // To WhatsApp with client
          currentOrder.ownerPhone != null
              ? GestureDetector(
                  onTap: () async {
                    var url = 'https://wa.me/${currentOrder.ownerPhone}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: CommunicationCard(
                    text: S.of(context).whatsappWithClient,
                    image: FaIcon(FontAwesomeIcons.whatsapp),
                  ),
                )
              : Container(),
          // To Open Maps
          GestureDetector(
            onTap: () {
              var url =
                  'https://www.google.com/maps/dir/?api=1&destination=${currentOrder.to.lat},${currentOrder.to.lon}';
              canLaunch(url).then((value) {
                if (value) {
                  launch(url);
                }
              });
            },
            child: CommunicationCard(
              text: S.of(context).getDirection,
              image: FaIcon(FontAwesomeIcons.mapSigns),
            ),
          ),
        ],
      ),
    );
  }
}
