import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/project_colors/project_colors.dart';
import 'package:flutter/material.dart';

typedef RetryCallBack = void Function();

class ErrorUi extends StatelessWidget {
  final RetryCallBack onRetry;

  ErrorUi({
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        color: ProjectColors.THEME_COLOR,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).errorHappened,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.white,
              onPressed: onRetry,
              child: Column(
                children: [
//                  Text(
//                    S.of(context).retry,
//                    style: TextStyle(
//                      color: ProjectColors.THEME_COLOR,
//                    ),
//                  ),
                  Icon(
                    Icons.refresh,
                    size: 50,
                    color: ProjectColors.THEME_COLOR,
                  )
                ],
              ),
            )
          ],
        ) ,
      ) ,
    );
  }
}
