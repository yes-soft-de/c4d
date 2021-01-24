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

import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsStateOwnerOrderLoaded extends OrderDetailsState {
  OrderModel currentOrder;

  OrderDetailsStateOwnerOrderLoaded(
    this.currentOrder,
    OrderStatusScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OrderProgressionHelper.getStatusIcon(
                  currentOrder.status, context),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                OrderProgressionHelper.getCurrentStageHelper(
                    currentOrder.status, context),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StepProgressIndicator(
                totalSteps: 5,
                currentStep: currentOrder.status.index,
              ),
            ),
            Text(
              timeago.format(currentOrder.creationTime, locale: Localizations.localeOf(context).languageCode),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ],
        ),
        Flex(
          direction: Axis.vertical,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ChatRoutes.chatRoute,
                  arguments: currentOrder.chatRoomId,
                );
              },
              child: CommunicationCard(
                text: S.of(context).openChatRoom,
                image: Icon(Icons.chat_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ChatRoutes.chatRoute,
                  arguments: currentOrder.chatRoomId,
                );
              },
              child: CommunicationCard(
                text: S.of(context).whatsappWithCaptain,
                image: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                ),
              ),
            ),
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
                text: S.of(context).whatsappWithClient,
                image: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
