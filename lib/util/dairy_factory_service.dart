import 'package:xml/xml.dart';

import '../model/dairy_factory.dart';

class DairyFactoryService {
  static final DairyFactoryService _instance = DairyFactoryService._internal();

  DairyFactoryService._internal();

  final Set<DairyFactory> _factories = {};

  factory DairyFactoryService() {
    return _instance;
  }

  void parseFromXmlDoc(XmlDocument codes) {
    _factories.addAll(codes
        .findAllElements("bvl:betrieb")
        .map(DairyFactory.parseFromXmlNode));
  }

  List<DairyFactory> get all => _factories.toList()..sort();
}
