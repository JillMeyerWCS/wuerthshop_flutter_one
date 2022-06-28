import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/model/dairy_factory.dart';

import '../model/app_state.dart';
import '../util/persistence.dart';

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
  late AppState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  addFactory(DairyFactory factory) {
    setState(() {
      final savedFactories = Set<DairyFactory>.from(_state.savedFactories);
      savedFactories.add(factory);
      _state = _state.copyWith(savedFactories: savedFactories);
    });
  }

  removeFactory(DairyFactory factory) {
    setState(() {
      final savedFactories = Set<DairyFactory>.from(_state.savedFactories);
      savedFactories.remove(factory);
      _state = _state.copyWith(savedFactories: savedFactories);
    });
  }

  saveNameSearch(String text) {
    setState(() {
      _state = _state.copyWith(nameSearch: text);
    });
  }

  saveIdSearch(String text) {
    setState(() {
      _state = _state.copyWith(idSearch: text);
    });
  }

  @override
  Widget build(BuildContext context) {
    saveAppState(_state);
    return InheritedAppState(
        state: _state,
        addFactory: addFactory,
        removeFactory: removeFactory,
        saveNameSearch: saveNameSearch,
        saveIdSearch: saveIdSearch,
        child: widget.builder(context));
  }
}

class InheritedAppState extends InheritedWidget {
  final AppState state;
  final Function(DairyFactory) addFactory;
  final Function(DairyFactory) removeFactory;
  final Function(String) saveNameSearch;
  final Function(String) saveIdSearch;
  const InheritedAppState(
      {Key? key,
      required Widget child,
      required this.state,
      required this.saveNameSearch,
      required this.saveIdSearch,
      required this.removeFactory,
      required this.addFactory})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedAppState oldWidget) {
    return oldWidget.state != state;
  }

  static InheritedAppState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedAppState>();
}
