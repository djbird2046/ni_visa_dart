import 'dart:ffi';
import 'package:ffi/ffi.dart';
import '../ffi/ctypes.dart';
import '../ffi/functions.dart';
import 'constant.dart';
import 'exception.dart';
import 'model.dart';

const int MAX_LIST_LENGTH = 128;
const int MAX_STRING_LENGTH = 256;

/// This function returns a session to the Default Resource Manager resource.
int openDefaultRM() {
  Pointer<Uint32> vi = malloc<Uint32>(1);
  int status = viOpenDefaultRM(vi);
  if(status == VI_WARN_CONFIG_NLOADED) {
    malloc.free(vi);
    throw VI_WARN_CONFIG_NLOADED_EXCEPTION;
  } else if(status == VI_ERROR_SYSTEM_ERROR) {
    malloc.free(vi);
    throw VI_ERROR_SYSTEM_ERROR_EXCEPTION;
  } else if(status == VI_ERROR_SYSTEM_ERROR) {
    malloc.free(vi);
    throw VI_ERROR_ALLOC_EXCEPTION;
  } else if(status == VI_ERROR_SYSTEM_ERROR) {
    malloc.free(vi);
    throw VI_ERROR_INV_SETUP_EXCEPTION;
  } else if(status == VI_ERROR_SYSTEM_ERROR) {
    malloc.free(vi);
    throw VI_ERROR_LIBRARY_NFOUND;
  }

  int session = vi.asTypedList(1).first;
  malloc.free(vi);
  return session;
}

/// Queries a VISA system to locate the resources associated with a specified interface
Resources findRsrc(int session, String expression) {
  Pointer<ViFindList> vi = malloc<Uint32>(MAX_LIST_LENGTH);
  Pointer<ViUInt32> retCnt =  malloc<Uint32>(1);
  Pointer<ViChar> desc = malloc<Utf8>(MAX_STRING_LENGTH);
  int status = viFindRsrc(session, expression.toNativeUtf8(), vi, retCnt, desc);
  if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(vi); malloc.free(retCnt); malloc.free(desc);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if(status == VI_ERROR_NSUP_OPER) {
    malloc.free(vi); malloc.free(retCnt); malloc.free(desc);
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  } else if(status == VI_ERROR_SYSTEM_ERROR) {
    malloc.free(vi); malloc.free(retCnt); malloc.free(desc);
    throw VI_ERROR_SYSTEM_ERROR_EXCEPTION;
  } else if(status == VI_ERROR_INV_EXPR) {
    malloc.free(vi); malloc.free(retCnt); malloc.free(desc);
    throw VI_ERROR_INV_EXPR_EXCEPTION;
  } else if(status == VI_ERROR_RSRC_NFOUND) {
    malloc.free(vi); malloc.free(retCnt); malloc.free(desc);
    throw VI_ERROR_RSRC_NFOUND_EXCEPTION;
  }

  int returnCount= retCnt.asTypedList(1).first;
  List<int> viList = vi.asTypedList(returnCount);
  String description = desc.cast<Utf8>().toDartString();

  malloc.free(vi); malloc.free(retCnt); malloc.free(desc);

  return Resources(viList: viList, description: description);
}


/// Returns the next resource from the list of resources found during a previous call to findRsrc().
String findNext(int findList, String description) {
  ViPChar buf = malloc<Utf8>(MAX_STRING_LENGTH);
  int status = viFindNext(findList, buf);
  if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(buf);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_OPER) {
    malloc.free(buf);
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  } else if (status == VI_ERROR_RSRC_NFOUND) {
    malloc.free(buf);
    throw VI_ERROR_RSRC_NFOUND_EXCEPTION;
  }
  String instrDesc = buf.toDartString();
  malloc.free(buf);
  return instrDesc;
}

///Parse a resource string to get extended interface information.
Interface parseRsrc(int resourceManagerSession, String resourceName) {
  Pointer<Utf8> name = resourceName.toNativeUtf8();
  Pointer<Uint16> intfType = malloc<Uint16>(1);
  Pointer<Uint16> intfNum = malloc<Uint16>(1);
  int status = viParseRsrc(resourceManagerSession, name, intfType, intfNum);

  if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(intfType); malloc.free(intfNum);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if(status == VI_ERROR_NSUP_OPER) {
    malloc.free(intfType); malloc.free(intfNum);
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  }  else if(status == VI_ERROR_INV_RSRC_NAME) {
    malloc.free(intfType); malloc.free(intfNum);
    throw VI_ERROR_INV_RSRC_NAME_EXCEPTION;
  } else if(status == VI_ERROR_RSRC_NFOUND) {
    malloc.free(intfType); malloc.free(intfNum);
    throw VI_ERROR_RSRC_NFOUND_EXCEPTION;
  } else if(status == VI_ERROR_ALLOC) {
    malloc.free(intfType); malloc.free(intfNum);
    throw VI_ERROR_ALLOC_EXCEPTION;
  } else if(status == VI_ERROR_LIBRARY_NFOUND) {
    malloc.free(intfType); malloc.free(intfNum);
    throw VI_ERROR_LIBRARY_NFOUND_EXCEPTION;
  } else if(status == VI_ERROR_INTF_NUM_NCONFIG) {
    malloc.free(intfType); malloc.free(intfNum);
    throw VI_ERROR_INTF_NUM_NCONFIG_EXCEPTION;
  }

  int interfaceType= intfType.asTypedList(1).first;
  int interfaceNumber= intfNum.asTypedList(1).first;

  Interface interface = Interface(type: interfaceType, number: interfaceNumber);

  return interface;
}

/// Parse a resource string to get extended interface information.
ExpandedInterface parseRsrcEx(int resourceManagerSession, String resourceName) {
  Pointer<Utf8> rsrcName = resourceName.toNativeUtf8();
  Pointer<Uint16> intfType = malloc<Uint16>(1);
  Pointer<Uint16> intfNum = malloc<Uint16>(1);
  Pointer<ViChar> rsrcClass = malloc<ViChar>(MAX_STRING_LENGTH);
  Pointer<ViChar> expUnaliasedName = malloc<ViChar>(MAX_STRING_LENGTH);
  Pointer<ViChar> aliasIfExs = malloc<ViChar>(MAX_STRING_LENGTH);

  int status = viParseRsrcEx(resourceManagerSession, rsrcName, intfType, intfNum, rsrcClass, expUnaliasedName, aliasIfExs);

  if(status == VI_WARN_EXT_FUNC_NIMPL) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_WARN_EXT_FUNC_NIMPL_EXCEPTION;
  } else if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  }  else if(status == VI_ERROR_NSUP_OPER) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  } else if(status == VI_ERROR_INV_RSRC_NAME) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_ERROR_INV_RSRC_NAME_EXCEPTION;
  } else if(status == VI_ERROR_RSRC_NFOUND) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_ERROR_RSRC_NFOUND_EXCEPTION;
  } else if(status == VI_ERROR_ALLOC) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_ERROR_ALLOC_EXCEPTION;
  } else if(status == VI_ERROR_LIBRARY_NFOUND) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_ERROR_LIBRARY_NFOUND_EXCEPTION;
  } else if(status == VI_ERROR_INTF_NUM_NCONFIG) {
    malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);
    throw VI_ERROR_INTF_NUM_NCONFIG_EXCEPTION;
  }

  int interfaceType = intfType.asTypedList(1).first;
  int interfaceNumber = intfNum.asTypedList(1).first;
  String resourceClass = rsrcClass.toDartString();
  String expandedUnaliasedName = expUnaliasedName.toDartString();
  String aliasIfExists = aliasIfExs.toDartString();

  malloc.free(intfType); malloc.free(intfNum); malloc.free(rsrcClass); malloc.free(expUnaliasedName); malloc.free(aliasIfExs);

  ExpandedInterface expandedInterface = ExpandedInterface(type: interfaceType, number: interfaceNumber, resourceClass: resourceClass, expandedUnaliasedName: expandedUnaliasedName, aliasIfExists: aliasIfExists);

  return expandedInterface;
}

/// Opens a session to the specified resource.
int open(int resourceManagerSession, String resourceName, {int? mode, int? timeout}) {
  Pointer<Utf8> name = resourceName.toNativeUtf8();
  Pointer<Uint32> vi = malloc<Uint32>(1);

  int status = viOpen(resourceManagerSession, name, mode??VI_NULL, timeout??VI_NULL, vi);

  if(status == VI_SUCCESS_DEV_NPRESENT) {
    malloc.free(vi);
    throw VI_SUCCESS_DEV_NPRESENT_EXCEPTION;
  } else if(status == VI_WARN_CONFIG_NLOADED) {
    malloc.free(vi);
    throw VI_WARN_CONFIG_NLOADED_EXCEPTION;
  }  else if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(vi);
    throw VI_SUCCESS_DEV_NPRESENT_EXCEPTION;
  } else if(status == VI_ERROR_NSUP_OPER) {
    malloc.free(vi);
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  } else if(status == VI_ERROR_INV_RSRC_NAME) {
    malloc.free(vi);
    throw VI_ERROR_INV_RSRC_NAME_EXCEPTION;
  } else if(status == VI_ERROR_INV_ACC_MODE) {
    malloc.free(vi);
    throw VI_ERROR_INV_ACC_MODE_EXCEPTION;
  } else if(status == VI_ERROR_RSRC_NFOUND) {
    malloc.free(vi);
    throw VI_ERROR_RSRC_NFOUND_EXCEPTION;
  } else if(status == VI_ERROR_ALLOC) {
    malloc.free(vi);
    throw VI_ERROR_ALLOC_EXCEPTION;
  } else if(status == VI_ERROR_RSRC_BUSY) {
    malloc.free(vi);
    throw VI_ERROR_RSRC_BUSY_EXCEPTION;
  } else if(status == VI_ERROR_RSRC_LOCKED) {
    malloc.free(vi);
    throw VI_ERROR_RSRC_LOCKED_EXCEPTION;
  } else if(status == VI_ERROR_TMO) {
    malloc.free(vi);
    throw VI_ERROR_TMO_EXCEPTION;
  } else if(status == VI_ERROR_LIBRARY_NFOUND) {
    malloc.free(vi);
    throw VI_ERROR_LIBRARY_NFOUND_EXCEPTION;
  } else if(status == VI_ERROR_INTF_NUM_NCONFIG) {
    malloc.free(vi);
    throw VI_ERROR_INTF_NUM_NCONFIG_EXCEPTION;
  } else if(status == VI_ERROR_MACHINE_NAVAIL) {
    malloc.free(vi);
    throw VI_ERROR_MACHINE_NAVAIL_EXCEPTION;
  } else if(status == VI_ERROR_NPERMISSION) {
    malloc.free(vi);
    throw VI_ERROR_NPERMISSION_EXCEPTION;
  }

  int session = vi.asTypedList(1).first;
  malloc.free(vi);
  return session;
}

/// Closes the specified session, event, or find list.
void close(int vi) {

  int status = viClose(vi);

  if(status == VI_WARN_NULL_OBJECT) {
    throw VI_WARN_NULL_OBJECT_EXCEPTION;
  } else if(status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if(status == VI_ERROR_CLOSING_FAILED) {
    throw VI_ERROR_CLOSING_FAILED_EXCEPTION;
  }

}

/// Sets the state of an attribute.
void setAttribute(int vi, int attributeName, int attributeValue) {
  int status = viSetAttribute(vi, attributeName, attributeValue);

  if(status == VI_WARN_NSUP_ATTR_STATE) {
    throw VI_WARN_NSUP_ATTR_STATE_EXCEPTION;
  } else if (status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_ATTR) {
    throw VI_ERROR_NSUP_ATTR_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_ATTR_STATE) {
    throw VI_ERROR_NSUP_ATTR_STATE_EXCEPTION;
  } else if (status == VI_ERROR_ATTR_READONLY) {
    throw VI_ERROR_ATTR_READONLY_EXCEPTION;
  } else if (status == VI_ERROR_RSRC_LOCKED) {
    throw VI_ERROR_RSRC_LOCKED_EXCEPTION;
  }
}

/// Retrieves the state of an attribute.
int getAttribute(int vi, int attributeName) {
  Pointer<ViAttrState> attrState = malloc<ViAttrState>(1);
  int status = viGetAttribute(vi, attributeName, attrState.cast<Void>());

  if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(attrState);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_ATTR) {
    malloc.free(attrState);
    throw VI_ERROR_NSUP_ATTR_EXCEPTION;
  }

  int attributeState = attrState.asTypedList(1).first;
  return attributeState;
}

/// Returns a user-readable description of the status code passed to the operation.
String statusDesc(int vi, int statusCode) {
  Pointer<Utf8> decs = malloc<Utf8>(MAX_STRING_LENGTH);
  int status = viStatusDesc(vi, statusCode, decs);
  if(status == VI_WARN_UNKNOWN_STATUS) {
    throw VI_WARN_UNKNOWN_STATUS_EXCEPTION;
  }
  String description = decs.toDartString();
  return description;
}

/// Requests a VISA session to terminate normal execution of an operation.
void terminate(int vi, int degree, int jobId) {
  int status = viTerminate(vi, degree, jobId);
  if(status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_INV_JOB_ID) {
    throw VI_ERROR_INV_JOB_ID_EXCEPTION;
  } else if (status == VI_ERROR_INV_DEGREE) {
    throw VI_ERROR_INV_DEGREE_EXCEPTION;
  }
}

/// Establishes an access mode to the specified resources.
String lock(int vi, int lockType, int timeout, String requestedKey) {
  Pointer<Utf8> reqKey = requestedKey.toNativeUtf8();
  Pointer<Utf8> accKey = malloc<Utf8>(MAX_STRING_LENGTH);
  int status = viLock(vi, lockType, timeout, reqKey, accKey);

  if(status == VI_SUCCESS_NESTED_EXCLUSIVE) {
    malloc.free(reqKey); malloc.free(accKey);
    throw VI_SUCCESS_NESTED_EXCLUSIVE_EXCEPTION;
  } else if (status == VI_SUCCESS_NESTED_SHARED) {
    malloc.free(reqKey); malloc.free(accKey);
    throw VI_SUCCESS_NESTED_SHARED_EXCEPTION;
  } else if (status == VI_ERROR_INV_OBJECT) {
    malloc.free(reqKey); malloc.free(accKey);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_RSRC_LOCKED) {
    malloc.free(reqKey); malloc.free(accKey);
    throw VI_ERROR_RSRC_LOCKED_EXCEPTION;
  } else if (status == VI_ERROR_INV_LOCK_TYPE) {
    malloc.free(reqKey); malloc.free(accKey);
    throw VI_ERROR_INV_LOCK_TYPE_EXCEPTION;
  } else if (status == VI_ERROR_INV_ACCESS_KEY) {
    malloc.free(reqKey); malloc.free(accKey);
    throw VI_ERROR_INV_ACCESS_KEY_EXCEPTION;
  } else if (status == VI_ERROR_TMO) {
    malloc.free(reqKey); malloc.free(accKey);
    throw VI_ERROR_TMO_EXCEPTION;
  }

  String accessKey = accKey.toDartString();
  malloc.free(reqKey); malloc.free(accKey);
  return accessKey;
}

/// Relinquishes a lock for the specified resource.
void unLock(int vi) {
  int status = viUnlock(vi);

  if(status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_OPER) {
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  } else if (status ==VI_ERROR_WINDOW_NMAPPED) {
    throw VI_ERROR_WINDOW_NMAPPED_EXCEPTION;
  }
}

/// Enables notification of a specified event.
void enableEvent(int vi, int eventType, int mechanism, int context,) {

  int status = viEnableEvent(vi, eventType, mechanism, context);

  if(status == VI_SUCCESS_EVENT_EN) {
    throw VI_SUCCESS_EVENT_EN_EXCEPTION;
  } else if (status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_INV_EVENT) {
    throw VI_ERROR_INV_EVENT_EXCEPTION;
  } else if (status == VI_ERROR_INV_MECH) {
    throw VI_ERROR_INV_MECH_EXCEPTION;
  } else if (status == VI_ERROR_INV_CONTEXT) {
    throw VI_ERROR_INV_CONTEXT_EXCEPTION;
  } else if (status == VI_ERROR_INV_SETUP) {
    throw VI_ERROR_INV_SETUP_EXCEPTION;
  } else if (status == VI_ERROR_HNDLR_NINSTALLED) {
    throw VI_ERROR_HNDLR_NINSTALLED_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_MECH) {
    throw VI_ERROR_NSUP_MECH_EXCEPTION;
  }
}

/// Disable event notifications for the given session.
void disableEvent(int session, int eventType, int mechanism) {
  int status = viDisableEvent(session, eventType, mechanism);

  if (status == VI_SUCCESS_EVENT_DIS) {
    throw VI_SUCCESS_EVENT_DIS_EXCEPTION;
  } else if (status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_INV_EVENT) {
    throw VI_ERROR_INV_EVENT_EXCEPTION;
  } else if (status == VI_ERROR_INV_MECH) {
    throw VI_ERROR_INV_MECH_EXCEPTION;
  }
}

/// Discards event occurrences for specified event types and mechanisms in a session.
void discardEvents(int session, int eventType, int mechanism) {
  int status = viDiscardEvents(session, eventType, mechanism);

  if (status == VI_SUCCESS_QUEUE_EMPTY) {
    throw VI_SUCCESS_QUEUE_EMPTY_EXCEPTION;
  } else if (status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_INV_EVENT) {
    throw VI_ERROR_INV_EVENT_EXCEPTION;
  } else if (status == VI_ERROR_INV_MECH) {
    throw VI_ERROR_INV_MECH_EXCEPTION;
  }
}

/// This function waits for a specified event and returns the event type and context.
EventContext waitOnEvent(int vi, int eventType, int timeout) {
  Pointer<ViEventType> outEventType = malloc<ViEventType>(1);
  Pointer<ViEvent> outContext = malloc<ViEvent>(1);
  int status = viWaitOnEvent(vi, eventType, timeout, outEventType, outContext);

  if (status == VI_ERROR_INV_OBJECT) {
    malloc.free(outEventType); malloc.free(outContext);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_INV_EVENT) {
    malloc.free(outEventType); malloc.free(outContext);
    throw VI_ERROR_INV_EVENT_EXCEPTION;
  } else if (status == VI_ERROR_TMO) {
    malloc.free(outEventType); malloc.free(outContext);
    throw VI_ERROR_TMO_EXCEPTION;
  } else if (status == VI_ERROR_NENABLED) {
    malloc.free(outEventType); malloc.free(outContext);
    throw VI_ERROR_NENABLED_EXCEPTION;
  } else if (status == VI_ERROR_QUEUE_OVERFLOW) {
    malloc.free(outEventType); malloc.free(outContext);
    throw VI_ERROR_QUEUE_OVERFLOW_EXCEPTION;
  }

  int EventType = outEventType.asTypedList(1).first;
  int receivedContext = outEventType.asTypedList(1).first;

  EventContext eventContext = EventContext(
    eventType: EventType,
    context: receivedContext,
  );

  return eventContext;
}

typedef EventHandlerNative = ViStatus Function(
    ViSession vi,
    ViEventType eventType,
    ViObject event,
    ViAddr userHandle
    );
typedef EventHandler = int Function(
    int vi,
    int eventType,
    int event,
    int userHandle,
    );

/// Install a handler for an event callback.
void installHandler(int session, int eventType, EventHandler handler, int userHandle) {
  int handlr (int vi, int eventType, int event, Pointer<Void> userHandle,) {
    return handler(vi, eventType, event, userHandle.address);
  };

  ViHndlr hndlr = Pointer.fromFunction<EventHandlerNative>(handlr, VI_ERROR_INV_HNDLR_REF);
  Pointer<Void> userHandlePtr = Pointer.fromAddress(userHandle);
  int status = viInstallHandler(session, eventType, hndlr, userHandlePtr);

  if (status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_INV_EVENT) {
    throw VI_ERROR_INV_EVENT_EXCEPTION;
  } else if (status == VI_ERROR_INV_HNDLR_REF) {
    throw VI_ERROR_INV_HNDLR_REF_EXCEPTION;
  } else if (status == VI_ERROR_HNDLR_NINSTALLED) {
    throw VI_ERROR_HNDLR_NINSTALLED_EXCEPTION;
  }
}

/// Uninstalls a handler for a given event type.
void uninstallHandler(int session, int eventType, EventHandler handler, int userHandle) {
  int handlr (int vi, int eventType, int event, Pointer<Void> userHandle,) {
    return handler(vi, eventType, event, userHandle.address);
  };

  ViHndlr hndlr = Pointer.fromFunction<EventHandlerNative>(handlr, VI_ERROR_INV_HNDLR_REF);
  Pointer<Void> userHandlePtr = Pointer.fromAddress(userHandle);
  int status = viUninstallHandler(session, eventType, hndlr, userHandlePtr);

  if (status == VI_ERROR_INV_OBJECT) {
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_INV_EVENT) {
    throw VI_ERROR_INV_EVENT_EXCEPTION;
  } else if (status == VI_ERROR_INV_HNDLR_REF) {
    throw VI_ERROR_INV_HNDLR_REF_EXCEPTION;
  } else if (status == VI_ERROR_HNDLR_NINSTALLED) {
    throw VI_ERROR_HNDLR_NINSTALLED_EXCEPTION;
  }
}

/// Reads data from device or interface synchronously.
String read(int session) {
  Pointer<Utf8> buf = malloc<Utf8>(MAX_STRING_LENGTH);
  Pointer<Uint32> retCnt = malloc<Uint32>(1);
  int status = viRead(session, buf, buf.length, retCnt);

  if(status == VI_SUCCESS_TERM_CHAR) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_SUCCESS_TERM_CHAR_EXCEPTION;
  } else if(status == VI_SUCCESS_MAX_CNT) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_SUCCESS_MAX_CNT_EXCEPTION;
  } else if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_OPER) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  } else if (status == VI_ERROR_RSRC_LOCKED) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_RSRC_LOCKED_EXCEPTION;
  } else if (status == VI_ERROR_TMO) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_TMO_EXCEPTION;
  } else if (status == VI_ERROR_RAW_WR_PROT_VIOL) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_RAW_WR_PROT_VIOL_EXCEPTION;
  } else if (status == VI_ERROR_RAW_RD_PROT_VIOL) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_RAW_RD_PROT_VIOL_EXCEPTION;
  } else if (status == VI_ERROR_INP_PROT_VIOL) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_INP_PROT_VIOL_EXCEPTION;
  } else if (status == VI_ERROR_BERR) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_BERR_EXCEPTION;
  } else if (status == VI_ERROR_INV_SETUP) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_INV_SETUP_EXCEPTION;
  } else if (status == VI_ERROR_NCIC) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_NCIC_EXCEPTION;
  } else if (status == VI_ERROR_NLISTENERS) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_NLISTENERS_EXCEPTION;
  } else if (status == VI_ERROR_ASRL_PARITY) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_ASRL_PARITY_EXCEPTION;
  } else if (status == VI_ERROR_ASRL_FRAMING) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_ASRL_FRAMING_EXCEPTION;
  } else if (status == VI_ERROR_ASRL_OVERRUN) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_ASRL_OVERRUN_EXCEPTION;
  } else if (status == VI_ERROR_IO) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_IO_EXCEPTION;
  } else if (status == VI_ERROR_CONN_LOST) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_CONN_LOST_EXCEPTION;
  }

  int returnCount= retCnt.asTypedList(1).first;
  String data = buf.toDartString(length: returnCount);
  malloc.free(buf); malloc.free(retCnt);

  return data;
}

/// Writes data to device or interface synchronously.
int write(int vi, String data) {
  Pointer<Utf8> buf = data.toNativeUtf8();
  Pointer<Uint32> retCnt = malloc<Uint32>(1);
  int status = viWrite(vi, buf, buf.length, retCnt);

  if(status == VI_ERROR_INV_OBJECT) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_INV_OBJECT_EXCEPTION;
  } else if (status == VI_ERROR_NSUP_OPER) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_NSUP_OPER_EXCEPTION;
  } else if (status == VI_ERROR_RSRC_LOCKED) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_RSRC_LOCKED_EXCEPTION;
  } else if (status == VI_ERROR_TMO) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_TMO_EXCEPTION;
  } else if (status == VI_ERROR_RAW_WR_PROT_VIOL) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_RAW_WR_PROT_VIOL_EXCEPTION;
  } else if (status == VI_ERROR_RAW_RD_PROT_VIOL) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_RAW_RD_PROT_VIOL_EXCEPTION;
  } else if (status == VI_ERROR_INP_PROT_VIOL) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_INP_PROT_VIOL_EXCEPTION;
  } else if (status == VI_ERROR_BERR) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_BERR_EXCEPTION;
  } else if (status == VI_ERROR_INV_SETUP) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_INV_SETUP_EXCEPTION;
  } else if (status == VI_ERROR_NCIC) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_NCIC_EXCEPTION;
  } else if (status == VI_ERROR_NLISTENERS) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_NLISTENERS_EXCEPTION;
  } else if (status == VI_ERROR_IO) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_IO_EXCEPTION;
  } else if (status == VI_ERROR_CONN_LOST) {
    malloc.free(buf); malloc.free(retCnt);
    throw VI_ERROR_CONN_LOST_EXCEPTION;
  }

  int returnCount= retCnt.asTypedList(1).first;
  malloc.free(buf); malloc.free(retCnt);
  return returnCount;
}