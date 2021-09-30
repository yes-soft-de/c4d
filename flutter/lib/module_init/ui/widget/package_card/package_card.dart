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
    print(package.note);
    return Card(
      child: Container(
          height: 240,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: active ? Theme.of(context).primaryColor : Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    package.name ??
                        S.of(context).package + ' ' + package.id.toString(),
                    style:
                        TextStyle(color: active ? Colors.white : Colors.black),
                  ),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Text(
                            S.current.packageInfo,
                            style: TextStyle(
                                color: active ? Colors.white : Colors.black),
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
                                      color: active
                                          ? Colors.white
                                          : Colors.black)),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  '${package.orderCount} ' +
                                      S.of(context).ordermonth,
                                  style: TextStyle(
                                      color:
                                          active ? Colors.white : Colors.black),
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
                                      color:
                                          active ? Colors.white : Colors.black,
                                    ),
                                  )),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: int.parse(package.carCount) != 0
                                    ? Text(
                                        '${package.carCount} ' +
                                            S.of(context).car,
                                        style: TextStyle(
                                          color: active
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )
                                    : Text(
                                        '∞ ' + S.of(context).car,
                                        style: TextStyle(
                                          color: active
                                              ? Colors.white
                                              : Colors.black,
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
                                      color:
                                          active ? Colors.white : Colors.black),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Text(
                                  '${package.cost} SAR',
                                  style: TextStyle(
                                      color:
                                          active ? Colors.white : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 4),
                          child: Text(
                            S.current.packageNote,
                            style: TextStyle(
                                color: active ? Colors.white : Colors.black),
                          ),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap:package.note != null && package.note != '' ? () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text(S.current.packageNote),
                                    content: Container(
                                      child: Text(package.note,textAlign: TextAlign.start,),
                                    ),
                                  );
                                });
                          } : null,
                          child: SizedBox(
                              height: 100,
                              child: package.note != null && package.note != ''
                                  ? Text(
                                      package.note,
                                      textAlign: TextAlign.start,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Icon(FontAwesomeIcons.info)),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
