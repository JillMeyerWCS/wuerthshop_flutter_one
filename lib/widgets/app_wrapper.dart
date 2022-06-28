import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/model/dairy_factory.dart';

import '../model/app_state.dart';

class AppWrapper extends StatefulWidget {
  final AppState initialState;
  final Widget Function(BuildContext) builder;
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
    return InheritedAppState(
        state: _state,
        addFactory: addFactory,
        removeFactory: removeFactory,
        child: widget.builder(context));
  }
}

class InheritedAppState extends InheritedWidget {
  final AppState state;
  final Function(DairyFactory) addFactory;
  final Function(DairyFactory) removeFactory;
  const InheritedAppState(
      {Key? key,
      required Widget child,
      required this.state,
      required this.removeFactory,
      required this.addFactory})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedAppState oldWidget) {
    return true;
  }

  static InheritedAppState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedAppState>();
}
