import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/model/dairy_factory.dart';

import '../model/app_state.dart';

class AppWrapper extends StatefulWidget {
  final AppState initialState;
  final Widget Function(BuildContext, AppState, Function(DairyFactory),
      Function(DairyFactory)) builder;
  const AppWrapper(
      {Key? key, required this.initialState, required this.builder})
      : super(key: key);

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  late final AppState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  addFactory(DairyFactory factory) {
    setState(() {
      _state.savedFactories.add(factory);
    });
  }

  removeFactory(DairyFactory factory) {
    setState(() {
      _state.savedFactories.remove(factory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state, addFactory, removeFactory);
  }
}
