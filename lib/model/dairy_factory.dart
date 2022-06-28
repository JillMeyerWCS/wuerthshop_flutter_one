import 'package:xml/xml.dart';

class DairyFactory implements Comparable<DairyFactory> {
  final String name;
  final String approvalNumber;

  DairyFactory({required this.name, required this.approvalNumber});

  DairyFactory.parseFromXmlNode(XmlNode node)
      : name = nameFromXmlNode(node),
        approvalNumber = approvalNumberFromXmlNode(node);

  static String nameFromXmlNode(XmlNode node) =>
      node.getElement("bvl:name")?.text ?? 'no name';

  static String approvalNumberFromXmlNode(XmlNode xml) {
    final newId = xml.getElement("bvl:zulassungsnummer");
    String? id;
    if (newId != null && newId.innerText.trim().isNotEmpty) {
      id =
          '${newId.getElement("bvl:bundesland")?.text} ${newId.getElement("bvl:nummer")?.text}';
    } else {
      id = xml
          .getElement("bvl:taetigkeit")
          ?.getElement("bvl:alteZulassungsnummer")
          ?.innerText;
    }
    return id ?? 'unknown';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other.approvalNumber == approvalNumber);
  }

  @override
  int get hashCode => approvalNumber.hashCode;

  static List<DairyFactory> parseFromXmlDoc(XmlDocument codes) => codes
      .findAllElements("bvl:betrieb")
      .map(DairyFactory.parseFromXmlNode)
      .toList();

  @override
  int compareTo(DairyFactory other) {
    // use name for comparison
    return name.compareTo(other.name);
  }
}
