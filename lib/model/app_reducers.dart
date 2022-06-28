import 'package:redux/redux.dart';
import 'package:wuerthshop_part_1/model/app_actions.dart';

import 'app_state.dart';
import 'dairy_factory.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, AddToSaved>(_addReducer),
  TypedReducer<AppState, RemoveFromSaved>(_removeReducer),
  TypedReducer<AppState, NameSearchAction>(_nameSearchReducer),
  TypedReducer<AppState, IdSearchAction>(_idSearchReducer),
]);

AppState _addReducer(AppState state, AddToSaved action) {
  final savedFactories = Set<DairyFactory>.from(state.savedFactories);
  savedFactories.add(action.factory);
  return state.copyWith(savedFactories: savedFactories);
}

AppState _removeReducer(AppState state, RemoveFromSaved action) {
  final saved = Set<DairyFactory>.from(state.savedFactories);
  saved.remove(action.factory);
  return state.copyWith(savedFactories: saved);
}

AppState _nameSearchReducer(AppState state, NameSearchAction action) {
  return state.copyWith(nameSearch: action.search);
}

AppState _idSearchReducer(AppState state, IdSearchAction action) {
  return state.copyWith(idSearch: action.search);
}
