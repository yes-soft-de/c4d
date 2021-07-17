import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ComunityScreen extends StatelessWidget {
  final tiles;
  ComunityScreen(this.tiles);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).social),
      ),
      body: ListView(
        children: getTiles(tiles, context),
      ),
    );
  }
}

List<Widget> getTiles(Map tiles, BuildContext context) {
  List<Widget> widgets = [];
  tiles.forEach((key, value) {
    if (key.toString() != 'uuid' &&
        key.toString() != 'id' &&
        key.toString() != 'fax') {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: key.toString() == 'phone'
              ? () {
                  launch('tel:$value');
                }
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          leading: Icon(
            getIcon(key),
            color: Colors.white,
          ),
          tileColor: Theme.of(context).primaryColor,
          title: Text(
            getMessage(key.toString()),
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(value.toString()),
        ),
      ));
    }
  });
  return widgets;
}

IconData getIcon(String key) {
  if (key == 'phone') return FontAwesomeIcons.phone;
  if (key == 'phone2') return FontAwesomeIcons.phone;
  if (key == 'whatsapp') return FontAwesomeIcons.whatsapp;
  if (key == 'bank') return FontAwesomeIcons.store;
  if (key == 'fax') return FontAwesomeIcons.fax;
  if (key == 'email') return FontAwesomeIcons.mailBulk;
  if (key == 'stc') return FontAwesomeIcons.creditCard;
  if (key == 'kilometers') return FontAwesomeIcons.road;
  if (key == 'maxKilometerBonus') return FontAwesomeIcons.moneyBillAlt;
  if (key == 'minKilometerBonus') return FontAwesomeIcons.coins;
}

String getMessage(String key) {
  if (key == 'phone') return S.current.phoneNumber;
  if (key == 'phone2') return '${S.current.phoneNumber} 2';
  if (key == 'whatsapp') return S.current.whatsapp;
  if (key == 'bank') return S.current.bankName;
  if (key == 'fax') return 'fax';
  if (key == 'email') return S.current.email;
  if (key == 'stc') return S.current.stcPayCode;
  if (key == 'kilometers') return S.current.kilometerLimt;
  if (key == 'maxKilometerBonus') return S.current.kilometerLimtMax;
  if (key == 'minKilometerBonus') return S.current.kilometerLimtMin;
}
