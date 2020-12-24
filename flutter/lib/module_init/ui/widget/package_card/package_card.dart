import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';


class PackageCard extends StatelessWidget {
  final int index;
  final int packageNumber;
  final int ordersNumber;
  final int carsNumber;
  final int price;

  PackageCard({
    this.ordersNumber,
    this.index,
    this.carsNumber,
    this.price,
    this.packageNumber,
});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index == 0 ? ProjectColors.THEME_COLOR : Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Package #$packageNumber',
              style: TextStyle(
                  color: index == 0 ? Colors.white : Colors.black
              ),
            ),
            Text(
              '$ordersNumber Order/Month',
              style: TextStyle(
                  color: index == 0 ? Colors.white : Colors.black
              ),
            ),
            Text(
              '$carsNumber Car',
              style: TextStyle(
                  color: index == 0 ? Colors.white : Colors.black
              ),
            ),
            Text(
              '$price',
              style: TextStyle(
                  color: index == 0 ? Colors.white : Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
