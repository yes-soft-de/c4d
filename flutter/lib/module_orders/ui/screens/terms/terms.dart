import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_orders/ui/state/terms/terms_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class TermsScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;

  TermsScreen(
    this._stateManager,
  );

  @override
  TermsScreenState createState() => TermsScreenState();
}

class TermsScreenState extends State<TermsScreen> {
  TermsListState currentState;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget._stateManager.termsStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getTerms(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentState.getUI(context),
      ),
    );
  }
}
