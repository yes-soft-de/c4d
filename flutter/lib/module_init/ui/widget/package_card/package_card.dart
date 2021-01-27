import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/model/package/packages.model.dart';
import 'package:flutter/material.dart';

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
        height: 250,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: active ? Theme.of(context).primaryColor : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              S.of(context).package + ' ' + package.id.toString(),
              style: TextStyle(color: active ? Colors.white : Colors.black),
            ),
            Text(
              '${package.orderCount}' + S.of(context).ordermonth,
              style: TextStyle(color: active ? Colors.white : Colors.black),
            ),
            Text(
              '${package.carCount} ' + S.of(context).car,
              style: TextStyle(color: active ? Colors.white : Colors.black),
            ),
            Text(
              '${package.cost}',
              style: TextStyle(color: active ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
