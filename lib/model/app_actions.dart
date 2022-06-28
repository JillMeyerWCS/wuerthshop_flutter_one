import 'dairy_factory.dart';

class AddToSaved {
  final DairyFactory factory;
  AddToSaved(this.factory);
}

class RemoveFromSaved {
  final DairyFactory factory;
  RemoveFromSaved(this.factory);
}

class NameSearchAction {
  final String search;
  NameSearchAction(this.search);
}

class IdSearchAction {
  final String search;
  IdSearchAction(this.search);
}
