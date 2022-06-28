import 'package:async_redux/async_redux.dart';

import 'app_state.dart';
import 'dairy_factory.dart';

class AddToSaved extends ReduxAction<AppState> {
  final DairyFactory factory;
  AddToSaved(this.factory);

  @override
  AppState reduce() {
    final savedFactories = Set<DairyFactory>.from(state.savedFactories);
    savedFactories.add(factory);
    return state.copyWith(savedFactories: savedFactories);
  }
}

class RemoveFromSaved extends ReduxAction<AppState> {
  final DairyFactory factory;
  RemoveFromSaved(this.factory);

  @override
  AppState reduce() {
    final saved = Set<DairyFactory>.from(state.savedFactories);
    saved.remove(factory);
    return state.copyWith(savedFactories: saved);
  }
}

class NameSearchAction extends ReduxAction<AppState> {
  final String search;
  NameSearchAction(this.search);

  @override
  AppState reduce() {
    return state.copyWith(nameSearch: search);
  }
}

class IdSearchAction extends ReduxAction<AppState> {
  final String search;
  IdSearchAction(this.search);

  @override
  AppState reduce() {
    return state.copyWith(idSearch: search);
  }
}
