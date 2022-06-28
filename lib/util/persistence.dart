import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../model/app_state.dart';
import '../model/dairy_factory.dart';

const keyNameSearch = "name_search";
const keyIdSearch = "id_search";
const keySavedFactories = "saved_factories";

Future<AppState> loadAppState() async {
  final codes = await rootBundle.loadString('assets/codes.xml');
  final allFactories = XmlDocument.parse(codes)
      .findAllElements("bvl:betrieb")
      .map(DairyFactory.parseFromXmlNode);
  final prefs = await SharedPreferences.getInstance();
  final savedIds = prefs.getStringList(keySavedFactories) ?? [];
  final savedFactories = allFactories
      .where((element) => savedIds.contains(element.approvalNumber));

  final nameSearch = prefs.getString(keyNameSearch) ?? '';
  final idSearch = prefs.getString(keyIdSearch) ?? '';
  return AppState(
      allFactories: allFactories.toList(),
      savedFactories: savedFactories.toSet(),
      nameSearch: nameSearch,
      idSearch: idSearch);
}

Future<void> saveAppState(AppState state) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(keySavedFactories,
      state.savedFactories.map((e) => e.approvalNumber).toList());
  prefs.setString(keyNameSearch, state.nameSearch);
  prefs.setString(keyIdSearch, state.idSearch);
}
