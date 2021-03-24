import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/update/update_model.dart';
import 'package:c4d/module_orders/ui/screens/update/update.dart';
import 'package:flutter/material.dart';

abstract class UpdateListState {
  final UpdateScreenState screenState;

  UpdateListState(this.screenState);

  Widget getUI(BuildContext context);
}

class UpdateListStateInit extends UpdateListState {
  final List<UpdateModel> updates;
  UpdateListStateInit(this.updates, UpdateScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).latestUpdates,
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
          itemCount: updates.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              color: Theme.of(context).primaryColor,
              child: ListTile(
                title: Text(
                  '${updates[index].title}',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${updates[index].content}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UpdateListStateLoading extends UpdateListState {
  UpdateListStateLoading(UpdateScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
