import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wuerthshop_part_1/model/app_reducers.dart';
import 'package:redux/redux.dart';

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
        store: Store<AppState>(appReducer, initialState: initialState),
        child: builder(context));
  }
}
