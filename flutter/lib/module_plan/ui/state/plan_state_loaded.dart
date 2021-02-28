import 'dart:convert';

import 'package:c4d/module_plan/model/active_plan_model.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlanScreenStateLoaded extends PlanScreenState {
  final ActivePlanModel activePlanModel;

  PlanScreenStateLoaded(PlanScreen screen, this.activePlanModel)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Active Plan'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.car),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('${activePlanModel.cars} Active Cars'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.sync),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('${activePlanModel.orders} Orders / Month'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.compare_arrows),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: activePlanModel.orders,
                        child: Container(
                          height: 8,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: (activePlanModel.orders -
                                activePlanModel.activeOrders)
                            .abs(),
                        child: Container(
                          height: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text('${activePlanModel.activeOrders} / '),
              Text(
                '${activePlanModel.orders}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.car_rental),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: activePlanModel.cars,
                        child: Container(
                          height: 8,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex:
                            (activePlanModel.cars - activePlanModel.activeCars)
                                .abs(),
                        child: Container(
                          height: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text('${activePlanModel.activeCars} / '),
              Text(
                '${activePlanModel.cars}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
