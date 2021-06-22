import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:c4d/module_orders/ui/widgets/communication_card/communication_card.dart';
import 'package:c4d/module_orders/util/whatsapp_link_helper.dart';
import 'package:c4d/module_orders/utils/icon_helper/order_progression_helper.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../../orders_routes.dart';

class OrderDetailsStateOwnerOrderLoaded extends OrderDetailsState {
  OrderModel currentOrder;

  OrderDetailsStateOwnerOrderLoaded(
    this.currentOrder,
    OrderStatusScreenState screenState,
  ) : super(screenState) {
    if (this.currentOrder.showConfirm &&
        this.currentOrder.status == OrderStatus.IN_STORE) {
      showOwnerAlertConfirm(screenState.context);
    }
  }
  bool redo = false;
  void showFlush(context, answar) {
    Flushbar flushbar;
    flushbar = Flushbar(
      duration: Duration(seconds: 15),
      backgroundColor: Theme.of(context).primaryColor,
      title: S.of(context).warnning,
      message: S.of(context).sendingReport,
      icon: Icon(
        Icons.warning,
        size: 28.0,
        color: Colors.white,
      ),
      mainButton: FlatButton(
          onPressed: () {
            redo = true;
            screenState.refresh();
            flushbar.dismiss();
            screenState.changeStateToLoaded(currentOrder);
          },
          textColor: Colors.white,
          child: Text(S.of(context).redo)),
    );
    flushbar
      ..onStatusChanged = (FlushbarStatus status) {
        if (FlushbarStatus.DISMISSED == status && !redo) {
          screenState.sendOrderReportState(currentOrder.id, answar);
        }
      }
      ..show(context);
  }

  void showOwnerAlertConfirm(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(S.current.warnning),
            content: Container(
              child: Text(S.of(context).confirmingCaptainLocation),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showFlush(context, true);
                  },
                  child: Text(S.of(context).yes)),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showFlush(context, false);
                  },
                  child: Text(S.of(context).no))
            ],
          );
        });
  }

  @override
  Widget getUI(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
        return;
      },
      child: Scaffold(
        floatingActionButton:
            currentOrder.canRemove && currentOrder.status == OrderStatus.INIT
                ? FloatingActionButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(S.of(context).confirm),
                              content: Container(
                                height: 50,
                                child: Text(S.of(context).sureForDelete),
                              ),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(S.of(context).cancel)),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      screenState.deleteOrder(currentOrder);
                                    },
                                    child: Text(S.of(context).confirm)),
                              ],
                            );
                          });
                    },
                    backgroundColor: Colors.red,
                    child: Icon(Icons.delete),
                  )
                : null,
        body: Column(
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
                  timeago.format(currentOrder.creationTime,
                      locale: Localizations.localeOf(context).languageCode),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            currentOrder.status == OrderStatus.INIT
                ? Container()
                : Flex(
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
                          image: Icon(
                            Icons.chat_rounded,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          currentOrder.captainPhone == null
                              ? Container()
                              : Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      var url =
                                          WhatsAppLinkHelper.getWhatsAppLink(
                                              currentOrder.captainPhone);
                                      launch(url);
                                    },
                                    child: CommunicationCard(
                                      text: S.of(context).whatsappWithCaptain,
                                      image: FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                          currentOrder.clientPhone == null
                              ? Container()
                              : Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      var url =
                                          WhatsAppLinkHelper.getWhatsAppLink(
                                              currentOrder.clientPhone);
                                      launch(url);
                                    },
                                    child: CommunicationCard(
                                      text: S.of(context).whatsappWithClient,
                                      image: FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        height: 48,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
