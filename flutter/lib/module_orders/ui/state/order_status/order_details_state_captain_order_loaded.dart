import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/module_orders/util/whatsapp_link_helper.dart';
import 'package:c4d/module_orders/utils/icon_helper/order_progression_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:timeago/timeago.dart' as timeago;

class OrderDetailsStateCaptainOrderLoaded extends OrderDetailsState {
  OrderModel currentOrder;
  final _distanceCalculator = TextEditingController();

  OrderDetailsStateCaptainOrderLoaded(
    this.currentOrder,
    OrderStatusScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
        return;
      },
      child: SingleChildScrollView(
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
              timeago.format(currentOrder.creationTime,
                  locale: Localizations.localeOf(context).languageCode),
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
            _getNextStageCard(context),
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
                image: Icon(
                  Icons.chat_rounded,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            // To WhatsApp with store owner
           currentOrder.captainPhone != null ? GestureDetector(
              onTap: () {
                var url =
                    WhatsAppLinkHelper.getWhatsAppLink(currentOrder.ownerPhone);
                launch(url);
              },
              child: CommunicationCard(
                text: S.of(context).whatsappWithStoreOwner,
                image: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ):Container(),
            // To WhatsApp with client
            currentOrder.clientPhone != null
                ? GestureDetector(
                    onTap: () {
                      var url = WhatsAppLinkHelper.getWhatsAppLink(
                          currentOrder.clientPhone);
                      launch(url);
                    },
                    child: CommunicationCard(
                      text: S.of(context).whatsappWithClient,
                      image: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                : Container(),
            // To Open Maps
            GestureDetector(
              onTap: () {
                var url = WhatsAppLinkHelper.getMapsLink(
                    currentOrder.branchLocation.lat,
                    currentOrder.branchLocation.lon);
                launch(url);
              },
              child: CommunicationCard(
                text: S.of(context).getDirection,
                image: FaIcon(
                  FontAwesomeIcons.mapSigns,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),

           currentOrder.to.contains('maps') ? GestureDetector(
              onTap: () {
                var url = currentOrder.to;
                launch(url);
              },
              child: CommunicationCard(
                text: S.of(context).locationOfCustomer,
                image: FaIcon(
                  FontAwesomeIcons.locationArrow,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ):Container(),
            Container(
              height: 36,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNextStageCard(BuildContext context) {
    if (currentOrder.status == OrderStatus.FINISHED) {
      return Container();
    }
    if (currentOrder.status == OrderStatus.GOT_CASH) {
      return Card(
        elevation: 4,
        child: Container(
          height: 72,
          width: MediaQuery.of(context).size.width,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              IconButton(
                  icon: Icon(Icons.add_road_outlined),
                  onPressed: () {
                    if (_distanceCalculator.text.isNotEmpty) {
                      screenState.requestOrderProgress(
                          currentOrder, _distanceCalculator.text);
                    } else {
                      screenState
                          .showSnackBar(S.of(context).pleaseProvideTheDistance);
                    }
                  }),
              Expanded(
                child: TextFormField(
                  controller: _distanceCalculator,
                  decoration: InputDecoration(
                    hintText: '45',
                    labelText: S.of(context).finishOrderProvideDistanceInKm,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    if (_distanceCalculator.text.isNotEmpty) {
                      screenState.requestOrderProgress(
                          currentOrder, _distanceCalculator.text);
                    } else {
                      screenState
                          .showSnackBar(S.of(context).pleaseProvideTheDistance);
                    }
                  }),
            ],
          ),
        ),
      );
    } else if (currentOrder.status == OrderStatus.DELIVERING) {
      return Card(
        elevation: 4,
        child: Container(
          height: 72,
          width: MediaQuery.of(context).size.width,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              IconButton(
                  icon: Icon(Icons.add_road_outlined),
                  onPressed: () {
                    if (_distanceCalculator.text.isNotEmpty) {
                      screenState.requestOrderProgress(
                          currentOrder, _distanceCalculator.text);
                    } else {
                      screenState
                          .showSnackBar(S.of(context).pleaseProvideTheDistance);
                    }
                  }),
              Expanded(
                child: TextFormField(
                  controller: _distanceCalculator,
                  decoration: InputDecoration(
                    hintText: '56',
                    labelText: S.of(context).finishOrderProvideDistanceInKm,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    if (_distanceCalculator.text.isNotEmpty) {
                      screenState.requestOrderProgress(
                          currentOrder, _distanceCalculator.text);
                    } else {
                      screenState
                          .showSnackBar(S.of(context).pleaseProvideTheDistance);
                    }
                  }),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
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
          image: Icon(
            Icons.navigate_next_sharp,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      );
    }
  }
}
