import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wuerthshop_part_1/model/dairy_factory.dart';

part "app_state.freezed.dart";

@freezed
class AppState with _$AppState {
  const factory AppState({
    required List<DairyFactory> allFactories,
    required Set<DairyFactory> savedFactories,
    required String nameSearch,
    required String idSearch,
  }) = _AppState;
}
