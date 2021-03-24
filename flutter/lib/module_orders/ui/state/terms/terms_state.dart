import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/update/update_model.dart';
import 'package:c4d/module_orders/response/terms/terms_respons.dart';
import 'package:c4d/module_orders/ui/screens/terms/terms.dart';
import 'package:flutter/material.dart';

abstract class TermsListState {
  final TermsScreenState screenState;

  TermsListState(this.screenState);

  Widget getUI(BuildContext context);
}

class TermsListStateInit extends TermsListState {
  final List<Terms> terms;
  TermsListStateInit(this.terms, TermsScreenState screenState)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).termsOfService,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: terms.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$index - ${terms[index].content}'),
            );
          },
        ),
      ),
    );
  }
}

class TermsListStateLoading extends TermsListState {
  TermsListStateLoading(TermsScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
