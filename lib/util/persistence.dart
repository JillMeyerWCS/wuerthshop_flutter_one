import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

import '../util/dairy_factory_service.dart';

const keyNameSearch = "name_search";
const keyIdSearch = "id_search";
const keySavedFactories = "saved_factories";

Future<void> loadAppState() async {
  final codes = await rootBundle.loadString('assets/codes.xml');
  DairyFactoryService().parseFromXmlDoc(XmlDocument.parse(codes));
}
