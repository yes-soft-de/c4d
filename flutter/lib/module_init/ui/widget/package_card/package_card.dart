import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PackageCard extends StatelessWidget {
  final PackageModel package;
  final bool active;

  PackageCard({
    @required this.package,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 240,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: active ? Theme.of(context).primaryColor : Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                package.name ?? S.of(context).package + ' ' + package.id.toString(),
                style: TextStyle(color: active ? Colors.white : Colors.black),
              ),
            ),
            Divider(),
            Container(
              height: 24,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Icon(Icons.sync_alt_rounded,
                          color: active ? Colors.white : Colors.black)),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      '${package.orderCount} ' + S.of(context).ordermonth,
                      style:
                          TextStyle(color: active ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 24,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.car,
                          color: active ? Colors.white : Colors.black,
                        ),
                      )),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      '${package.carCount} ' + S.of(context).car,
                      style: TextStyle(
                        color: active ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 24,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.moneyBill,
                          color: active ? Colors.white : Colors.black),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      '${package.cost} SAR',
                      style:
                          TextStyle(color: active ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
