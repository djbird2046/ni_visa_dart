class VISAException implements Exception {
  int code;
  String identifier;
  String message;
  VISAException({required this.code, required this.identifier,required this.message});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message
    };
  }
}

class Resources {
  List<int> viList;
  String description;

  Resources({required this.viList, required this.description});
}

class Interface {
  int type;
  int number;
  Interface({required this.type, required this.number});
}

class ExpandedInterface extends Interface {
  String resourceClass;
  String expandedUnaliasedName;
  String aliasIfExists;
  ExpandedInterface({required super.type, required super.number, required this.resourceClass, required this.expandedUnaliasedName, required this.aliasIfExists});
}

class EventContext {
  int eventType;
  int context;

  EventContext({required this.eventType, required this.context});
}
