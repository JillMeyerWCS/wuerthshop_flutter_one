import 'package:wuerthshop_part_1/model/dairy_factory.dart';

class AppState {
  final List<DairyFactory> allFactories;
  final Set<DairyFactory> savedFactories;

  AppState({required this.allFactories, required this.savedFactories});
}
