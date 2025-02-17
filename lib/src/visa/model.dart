import 'dart:typed_data';

import 'package:ni_visa_dart/src/visa/exception.dart';

class Status {
  VISAStatus status;
  Status(this.status);
}

class Session extends Status{
  int session;
  Session(this.session, super.status);
}

class Resources extends Status {
  List<int> viList;
  String description;
  Resources(this.viList, this.description, super.status);
}

class InstrumentDescriptor extends Status {
  String instrumentDescriptor;
  InstrumentDescriptor(this.instrumentDescriptor, super.status);
}

class Interface extends Status {
  int type;
  int number;
  Interface(this.type, this.number, super.status);
}

class ExpandedInterface extends Interface {
  String resourceClass;
  String expandedUnaliasedName;
  String aliasIfExists;
  ExpandedInterface(super.type, super.number, this.resourceClass, this.expandedUnaliasedName, this.aliasIfExists, super.status);
}

class AttributeState extends Status {
  int attributeState;
  AttributeState(this.attributeState, super.status);
}

class StatusDescription extends Status {
  String statusDescription;
  StatusDescription(this.statusDescription, super.status);
}

class AccessKey extends Status {
  String accessKey;
  AccessKey(this.accessKey, super.status);
}

class EventContext extends Status {
  int eventType;
  int context;

  EventContext(this.eventType, this.context, super.status);
}

class Data extends Status {
  Uint8List data;
  Data(this.data, super.status);
}

class ReturnCount extends Status {
  int retCnt;
  ReturnCount(this.retCnt, super.status);
}

class IntVal extends Status {
  int intVal;
  IntVal(this.intVal, super.status);
}

class IntValue {
  int intVal;
  IntValue(this.intVal);
}

class JobId extends Status {
  int jobId;
  JobId(this.jobId, super.status);
}

class Offset extends Status {
  int offset;
  Offset(this.offset, super.status);
}

class Response extends Status {
  int response;
  Response(this.response, super.status);
}

class ServiceStatus extends Status {
  int serviceStatus;
  ServiceStatus(this.serviceStatus, super.status);
}

class Address extends Status {
  int address;
  Address(this.address, super.status);
}

class Buffer extends ReturnCount {
  Uint8List buf;
  Buffer(this.buf, super.retCnt, super.status);
}

class FailureIndex extends Status {
  int failureIndex;
  FailureIndex(this.failureIndex, super.status);
}