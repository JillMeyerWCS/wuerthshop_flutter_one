import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import '../model/app_state.dart';

class AppWrapper extends StatelessWidget {
  final AppState initialState;
  final Widget Function(BuildContext) builder;
  const AppWrapper(
      {Key? key, required this.initialState, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: Store<AppState>(initialState: initialState),
        child: builder(context));
  }
}
