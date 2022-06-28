import 'package:flutter/services.dart';
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
  return AppState(allFactories: allFactories.toList(), savedFactories: {});
}
