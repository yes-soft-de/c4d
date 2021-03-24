import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/response/order_info_respons.dart';
import 'package:c4d/module_profile/ui/screen/order_info/order_info_screen.dart';
import 'package:flutter/material.dart';

abstract class OrderInfoState {
  OrderInfoScreenState screenState;
  OrderInfoState(this.screenState);
  Widget getUI(BuildContext context);
}

class OrderInfoStateInit extends OrderInfoState {
  OrderInfoRespons order;
  OrderInfoStateInit(OrderInfoScreenState screenState, this.order)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.store),
          title: Text('${S.of(context).storeOwner}  :  ${order.owner.ownerName}'),          
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('${S.of(context).storePhone}  :  ${order.owner.ownerPhone}'),          
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('${S.of(context).recipientName}  :  ${order.recipientName}'),          
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('${S.of(context).recipientPhoneNumber}  :  ${order.recipientPhone}'),          
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: Text('${S.of(context).date}  :  ${order.date}'),          
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('${S.of(context).paymentMethod}  :  ${order.payment}'),          
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('${S.of(context).branch}  :  ${order.fromBranch}'),          
        ),
      ],
    );
  }
}

class OrderInfoStateLoading extends OrderInfoState {
  OrderInfoStateLoading(OrderInfoScreenState screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
