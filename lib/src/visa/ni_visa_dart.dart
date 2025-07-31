import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'extension.dart';
import '../ffi/ni_visa_ffi.dart';
import 'exception.dart';
import 'model.dart';

class NIVisaDart {

  static const int MAX_LIST_LENGTH = 1024;
  static const int MAX_STRING_LENGTH = 2048;

  late NIVisaFFI visa;

  NIVisaDart(File dynamicLibrary) {
    visa = NIVisaFFI(DynamicLibrary.open(dynamicLibrary.path));
  }

  T _call<T>({required int Function() onCall, required T Function(VISAStatus) onResult, required void Function() onFree,}) {
    int status = onCall();
    VISAStatus visaStatus = getVISAStatus(status);
    if(visaStatus is VISAError) {
      onFree();
      throw visaStatus;
    }
    T result = onResult(visaStatus);
    onFree();
    return result;
  }

  T _callVoid<T>({required void Function() onCall, required T Function() onResult, required void Function() onFree,}) {
    onCall();
    T result = onResult();
    onFree();
    return result;
  }

  /// This function returns a session to the Default Resource Manager resource.
  Session viOpenDefaultRM() {
    ViPSession vi = malloc<UnsignedInt>(1);

    return _call<Session>(
      onCall: () {
        return visa.viOpenDefaultRM(vi);
      },
      onResult: (visaStatus) {
        int session = vi.value;
        return Session(session, visaStatus);
      },
      onFree: () {
        malloc.free(vi);
      },
    );
  }

  /// Queries a VISA system to locate the resources associated with a specified interface.
  Resources viFindRsrc(int session, String expression) {
    /// IN
    int sesn = session;
    ViConstString expr = expression.toPointerCharMalloc();

    ///OUT
    ViPFindList vi = malloc<UnsignedInt>(MAX_LIST_LENGTH);
    ViPUInt32 retCnt =  malloc<UnsignedInt>(1);
    Pointer<ViChar> desc = malloc<Char>(MAX_STRING_LENGTH);

    return _call<Resources>(
      onCall: () {
        return visa.viFindRsrc(sesn, expr, vi, retCnt, desc);
      },
      onResult: (visaStatus) {
        int retCnt_= retCnt.value;
        List<int> viList = vi.asTypedList(retCnt_);
        String desc_ = desc.cast<Utf8>().toDartString();

        return Resources(viList, desc_, visaStatus);
      },
      onFree: () {
        malloc.free(expr);malloc.free(vi); malloc.free(retCnt); malloc.free(desc);
      },
    );
  }

  /// Returns the next resource from the list of resources found during a previous call to viFindRsrc()
  InstrumentDescriptor viFindNext(int findList) {
    ///OUT
    Pointer<ViChar> instrDesc = malloc<ViChar>(MAX_STRING_LENGTH);

    return _call<InstrumentDescriptor>(
      onCall: () {
        return visa.viFindNext(findList, instrDesc);
      },
      onResult: (visaStatus) {
        String instrDesc_ = instrDesc.toStringFromPointerChar();

        return InstrumentDescriptor(instrDesc_, visaStatus);
      },
      onFree: () {
        malloc.free(instrDesc);
      },
    );
  }

  /// Parse a resource string to get extended interface information.
  Interface viParseRsrc(int resourceManagerSession, String resourceName) {
    /// IN
    int rmSesn = resourceManagerSession;
    ViConstRsrc rsrcName = resourceName.toPointerCharMalloc();

    ///OUT
    ViPUInt16 intfType = malloc<UnsignedShort>(1);
    ViPUInt16 intfNum = malloc<UnsignedShort>(1);

    return _call<Interface>(
      onCall: () {
        return visa.viParseRsrc(rmSesn, rsrcName, intfType, intfNum);
      },
      onResult: (visaStatus) {
        int intfType_ = intfType.value;
        int intfNum_ = intfNum.value;

        return Interface(intfType_, intfNum_, visaStatus);
      },
      onFree: () {
        malloc.free(rsrcName); malloc.free(intfType); malloc.free(intfNum);
      },
    );
  }

  /// Parse a resource string to get extended interface information.
  ExpandedInterface viParseRsrcEx(int resourceManagerSession, String resourceName) {
    /// IN
    int rmSesn = resourceManagerSession;
    ViConstRsrc rsrcName = resourceName.toPointerCharMalloc();

    ///OUT
    ViPUInt16 intfType = malloc<UnsignedShort>(1);
    ViPUInt16 intfNum = malloc<UnsignedShort>(1);
    Pointer<ViChar> rsrcClass = malloc<ViChar>(MAX_STRING_LENGTH);
    Pointer<ViChar> expUnaliasedName = malloc<ViChar>(MAX_STRING_LENGTH);
    Pointer<ViChar> aliasIfExs = malloc<ViChar>(MAX_STRING_LENGTH);

    return _call<ExpandedInterface>(
      onCall: () {
        return visa.viParseRsrcEx(rmSesn, rsrcName, intfType, intfNum, rsrcClass, expUnaliasedName, aliasIfExs);
      },
      onResult: (visaStatus) {
        int intfType_ = intfType.value;
        int intfNum_ = intfNum.value;
        String rsrcClass_ = rsrcClass.toStringFromPointerChar();
        String expUnaliasedName_ = expUnaliasedName.toStringFromPointerChar();
        String aliasIfExs_ = aliasIfExs.toStringFromPointerChar();

        return ExpandedInterface(intfType_, intfNum_, rsrcClass_, expUnaliasedName_, aliasIfExs_, visaStatus);
      },
      onFree: () {
        malloc.free(rsrcName); malloc.free(intfType); malloc.free(intfNum);
      },
    );
  }

  /// Opens a session to the specified resource.
  Session viOpen(int resourceManagerSession, String resourceName, {int? mode, int? timeout}) {
    /// IN
    int sesn = resourceManagerSession;
    ViConstRsrc name = resourceName.toPointerCharMalloc();
    int _mode = mode??VI_NULL;
    int _timeout = timeout??VI_NULL;

    ///OUT
    ViPSession vi = malloc<UnsignedInt>(1);

    return _call<Session>(
      onCall: () {
        return visa.viOpen(sesn, name, _mode, _timeout, vi);
      },
      onResult: (visaStatus) {
        int vi_ = vi.asTypedList(1).first;
        return Session(vi_, visaStatus);
      },
      onFree: () {
        malloc.free(name); malloc.free(vi);
      },
    );
  }

  /// Closes the specified session, event, or find list.
  Status viClose(int vi) {
    /// IN

    ///OUT

    return _call<Status>(
      onCall: () {
        return visa.viClose(vi);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Sets the state of an attribute.
  Status viSetAttribute(int vi, int attributeName, int attributeValue) {
    /// IN
    int attrName = attributeName;
    int attrValue = attributeValue;

    return _call<Status>(
      onCall: () {
        return visa.viSetAttribute(vi, attrName, attrValue);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Retrieves the state of an attribute.
  AttributeState viGetAttribute(int vi, int attributeName) {
    /// IN
    int attrName = attributeName;

    ///OUT
    Pointer<Void> attrState = malloc<UnsignedInt>(8).cast<Void>();

    return _call<AttributeState>(
      onCall: () {
        return visa.viGetAttribute(vi, attrName, attrState);
      },
      onResult: (visaStatus) {
        Pointer<ViAttrState> attrStatePointer = attrState.cast<ViAttrState>();
        int attrState_ = attrStatePointer.value;
        return AttributeState(attrState_, visaStatus);
      },
      onFree: () {
        malloc.free(attrState);
      },
    );
  }

  /// Returns a user-readable description of the status code passed to the operation.
  StatusDescription viStatusDesc(int vi, int status) {
    ///OUT
    Pointer<ViChar> desc = malloc<Char>(MAX_STRING_LENGTH);

    return _call<StatusDescription>(
      onCall: () {
        return visa.viStatusDesc(vi, status, desc);
      },
      onResult: (visaStatus) {
        String desc_ = desc.toStringFromPointerChar();
        return StatusDescription(desc_, visaStatus);
      },
      onFree: () {
        malloc.free(desc);
      },
    );
  }

  /// Requests a VISA session to terminate normal execution of an operation.
  Status viTerminate(int vi, int degree, int jobId) {
    return _call<Status>(
      onCall: () {
        return visa.viTerminate(vi, degree, jobId);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Establishes an access mode to the specified resources.
  AccessKey viLock(int vi, int lockType, int timeout, String requestedKey) {
    /// IN
    ViConstKeyId _requestedKey = requestedKey.toPointerCharMalloc();

    ///OUT
    Pointer<ViChar> accessKey = malloc<ViChar>(MAX_STRING_LENGTH);

    return _call<AccessKey>(
      onCall: () {
        return visa.viLock(vi, lockType, timeout, _requestedKey, accessKey);
      },
      onResult: (visaStatus) {
        String accessKey_ = accessKey.toStringFromPointerChar();
        return AccessKey(accessKey_, visaStatus);
      },
      onFree: () {
        malloc.free(_requestedKey); malloc.free(accessKey);
      },
    );
  }

  /// Relinquishes a lock for the specified resource.
  Status viUnlock(int vi) {
    return _call<Status>(
      onCall: () {
        return visa.viUnlock(vi);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Enables notification of a specified event.
  Status viEnableEvent(int vi, int eventType, int mechanism, int context) {
    return _call<Status>(
      onCall: () {
        return visa.viEnableEvent(vi, eventType, mechanism, context);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Disable event notifications for the given session.
  Status viDisableEvent(int vi, int eventType, int mechanism) {
    return _call<Status>(
      onCall: () {
        return visa.viDisableEvent(vi, eventType, mechanism);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Discards event occurrences for specified event types and mechanisms in a session.
  Status viDiscardEvents(int vi, int eventType, int mechanism) {
    return _call<Status>(
      onCall: () {
        return visa.viDiscardEvents(vi, eventType, mechanism);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// This function waits for a specified event and returns the event type and context.
  EventContext viWaitOnEvent(int vi, int eventType, int timeout) {
    ///OUT
    ViPEventType outEventType = malloc<UnsignedInt>(1);
    ViPEvent outContext = malloc<UnsignedInt>(1);

    return _call<EventContext>(
      onCall: () {
        return visa.viWaitOnEvent(vi, eventType, timeout, outEventType, outContext);
      },
      onResult: (visaStatus) {
        int outEventType_ = outEventType.value;
        int outContext_ = outContext.value;

        return EventContext(outEventType_, outContext_, visaStatus);
      },
      onFree: () {
      },
    );
  }

  static int Function(int vi, int eventType, int event, int userHandle)? eventHandler;

  static int _eventHandler(int vi, int eventType, int event, Pointer<Void> userHandle) {
    if(eventHandler != null) return eventHandler!(vi, eventType, event, Pointer<UnsignedInt>.fromAddress(userHandle.address).value);
    else return VI_SUCCESS;
  }

  /// Install a handler for an event callback.
  Status viInstallHandler(int vi, int eventType, int userHandle) {
    /// IN
    Pointer<NativeFunction<ViStatus Function(ViSession, ViEventType, ViEvent, ViAddr)>> __handler = Pointer.fromFunction(_eventHandler, 0);
    ViAddr _userHandle = Pointer.fromAddress(userHandle);

    return _call<Status>(
      onCall: () {
        return visa.viInstallHandler(vi, eventType, __handler, _userHandle);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Uninstalls a handler for a given event type.
  Status viUninstallHandler(int vi, int eventType, int userHandle) {

    /// IN
    Pointer<NativeFunction<ViStatus Function(ViSession, ViEventType, ViEvent, ViAddr)>> __handler = Pointer.fromFunction(_eventHandler, 0);
    ViAddr _userHandle = Pointer.fromAddress(userHandle);

    return _call<Status>(
      onCall: () {
        return visa.viUninstallHandler(vi, eventType, __handler, _userHandle);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads data from device or interface synchronously.
  Data viRead(int session, int count) {
    /// IN
    int cnt = count;

    ///OUT
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);
    Pointer<UnsignedInt> retCnt = malloc<UnsignedInt>(1);

    return _call<Data>(
      onCall: () {
        return visa.viRead(session, buf, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_= retCnt.value;
        Uint8List data = buf.toUint8List(retCnt_);
        return Data(data, visaStatus);
      },
      onFree: () {
        malloc.free(buf); malloc.free(retCnt);
      },
    );
  }

  /// Reads data from device or interface asynchronously.
  Data viReadAsync(int session, int count) {
    /// IN
    int cnt = count;

    ///OUT
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);
    ViPJobId jobId = malloc<UnsignedInt>(1);

    return _call<Data>(
      onCall: () {
        return visa.viReadAsync(session, buf, cnt, jobId);
      },
      onResult: (visaStatus) {
        int jobId_ = jobId.value;
        Uint8List data = buf.toUint8List(jobId_);
        return Data(data, visaStatus);
      },
      onFree: () {
        malloc.free(buf); malloc.free(jobId);
      },
    );
  }

  /// Read data synchronously, and store the transferred data in a file.
  ReturnCount viReadToFile(int vi, String filename, int cnt) {

    /// IN
    ViConstString _filename = filename.toPointerCharMalloc();

    ///OUT
    ViPUInt32 retCnt = malloc<UnsignedInt>(1);

    return _call<ReturnCount>(
      onCall: () {
        return visa.viReadToFile(vi, _filename, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_ = retCnt.value;
        return ReturnCount(retCnt_, visaStatus);
      },
      onFree: () {
        malloc.free(_filename); malloc.free(retCnt);
      },
    );
  }

  /// Writes data to device or interface synchronously.
  ReturnCount viWrite(int vi, Uint8List data) {

    /// IN
    int cnt = data.length;
    ViPBuf buf = data.toPointerUnsignedCharMalloc();

    ///OUT
    Pointer<UnsignedInt> retCnt = malloc<UnsignedInt>(1);

    return _call<ReturnCount>(
      onCall: () {
        return visa.viWrite(vi, buf, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_= retCnt.value;
        return ReturnCount(retCnt_, visaStatus);
      },
      onFree: () {
        malloc.free(buf); malloc.free(retCnt);
      },
    );
  }

  /// Writes data to device or interface asynchronously.
  ReturnCount viWriteAsync(int vi, Uint8List data) {

    /// IN
    int cnt = data.length;
    ViPBuf buf = data.toPointerUnsignedCharMalloc();

    ///OUT
    Pointer<UnsignedInt> retCnt = malloc<UnsignedInt>(1);

    return _call<ReturnCount>(
      onCall: () {
        return visa.viWriteAsync(vi, buf, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_= retCnt.value;
        return ReturnCount(retCnt_, visaStatus);
      },
      onFree: () {
        malloc.free(buf); malloc.free(retCnt);
      },
    );
  }

  /// Take data from a file and write it out synchronously.
  ReturnCount viWriteFromFile(int vi, String filename, int cnt) {

    /// IN
    ViConstString _filename = filename.toPointerCharMalloc();

    ///OUT
    ViPUInt32 retCnt = malloc<UnsignedInt>(1);

    return _call<ReturnCount>(
      onCall: () {
        return visa.viWriteFromFile(vi, _filename, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_= retCnt.value;
        return ReturnCount(retCnt_, visaStatus);
      },
      onFree: () {
        malloc.free(_filename); malloc.free(retCnt);
      },
    );
  }

  /// Asserts software or hardware trigger.
  Status viAssertTrigger(int vi, int protocol) {
    return _call<Status>(
      onCall: () {
        return visa.viAssertTrigger(vi, protocol);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads a status byte of the service request.
  ServiceStatus viReadSTB(int vi) {
    ///OUT
    ViPUInt16 status = malloc<UnsignedShort>(1);

    return _call<ServiceStatus>(
      onCall: () {
        return visa.viReadSTB(vi, status);
      },
      onResult: (visaStatus) {
        int status_ = status.value;
        return ServiceStatus(status_, visaStatus);
      },
      onFree: () {
        malloc.free(status);
      },
    );
  }

  /// Clears a device.
  Status viClear(int vi) {
    return _call<Status>(
      onCall: () {
        return visa.viClear(vi);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Sets the size for the formatted I/O and/or low-level I/O communication buffer(s).
  Status viSetBuf(int vi, int mask, int size) {
    return _call<Status>(
      onCall: () {
        return visa.viSetBuf(vi, mask, size);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Manually flushes the specified buffers associated with formatted I/O operations and/or serial communication.
  Status viFlush(int vi, int mask) {
    return _call<Status>(
      onCall: () {
        return visa.viFlush(vi, mask);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Writes data to a formatted I/O write buffer synchronously.
  ReturnCount viBufWrite(int vi, Uint8List data) {
    /// IN
    int cnt = data.length;
    ViPBuf buf = malloc<UnsignedChar>(data.length);
    for (int i = 0; i < cnt; i++) {
      buf[i] = data[i];
    }

    ///OUT
    Pointer<UnsignedInt> retCnt = malloc<UnsignedInt>(1);

    return _call<ReturnCount>(
      onCall: () {
        return visa.viBufWrite(vi, buf, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_= retCnt.value;
        return ReturnCount(retCnt_, visaStatus);
      },
      onFree: () {
        malloc.free(buf); malloc.free(retCnt);
      },
    );
  }

  /// Reads data from device or interface through the use of a formatted I/O read buffer.
  Data viBufRead(int session, int count) {
    /// IN
    int cnt = count;

    ///OUT
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);
    Pointer<UnsignedInt> retCnt = malloc<UnsignedInt>(1);

    return _call<Data>(
      onCall: () {
        return visa.viBufRead(session, buf, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_= retCnt.value;
        Uint8List data = buf.toUint8List(retCnt_);
        return Data(data, visaStatus);
      },
      onFree: () {
        malloc.free(buf); malloc.free(retCnt);
      },
    );
  }

  /// Converts, formats, and sends the parameters (designated by...) to the device as specified by the format string.
  Status viPrintf(int vi, String writeFmt) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();

    return _call<Status>(
      onCall: () {
        return visa.viPrintf(vi, _writeFmt);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);
      },
    );
  }

  /// Converts, formats, and sends the parameters designated by params to the device or interface as specified by the format string.
  Status viVPrintf(int vi, String writeFmt, String params) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();
    ViVAList _params = params.toPointerCharMalloc();

    return _call<Status>(
      onCall: () {
        return visa.viVPrintf(vi, _writeFmt, _params);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);malloc.free(_params);
      },
    );
  }

  ///Converts, formats, and sends the parameters (designated by...) to a user-specified buffer as specified by the format string.
  Status viSPrintf(int vi, String writeFmt) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();

    ///OUT
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);

    return _call<Status>(
      onCall: () {
        return visa.viSPrintf(vi, buf, _writeFmt);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);
      },
    );
  }

  /// Converts, formats, and sends the parameters designated by params to a user-specified buffer as specified by the format string.
  Status viVSPrintf(int vi, String writeFmt, String params) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();
    ViVAList _params = params.toPointerCharMalloc();

    ///OUT
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);

    return _call<Status>(
      onCall: () {
        return visa.viVSPrintf(vi, buf, _writeFmt, _params);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);malloc.free(_params);
      },
    );
  }

  /// Reads, converts, and formats data using the format specifier. Stores the formatted data in the parameters (designated by ...).
  Status viScanf(int vi, String writeFmt) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();

    return _call<Status>(
      onCall: () {
        return visa.viScanf(vi, _writeFmt);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);
      },
    );
  }

  /// Reads, converts, and formats data using the format specifier. Stores the formatted data in the parameters designated by params.
  Status viVScanf(int vi, String writeFmt, String params) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();
    ViVAList _params = params.toPointerCharMalloc();

    return _call<Status>(
      onCall: () {
        return visa.viVScanf(vi, _writeFmt, _params);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);malloc.free(_params);
      },
    );
  }

  /// Reads, converts, and formats data from a user-specified buffer using the format specifier. Stores the formatted data in the parameters (designated by ...).
  Status viSScanf(int vi, String writeFmt) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();

    ///OUT
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);

    return _call<Status>(
      onCall: () {
        return visa.viSScanf(vi, buf, _writeFmt);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);malloc.free(buf);
      },
    );
  }

  /// Reads, converts, and formats data from a user-specified buffer using the format specifier. Stores the formatted data in the parameters designated by params.
  Status viVSScanf(int vi, String writeFmt, String params) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();
    ViVAList _params = params.toPointerCharMalloc();

    ///OUT
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);

    return _call<Status>(
      onCall: () {
        return visa.viVSScanf(vi, buf, _writeFmt, _params);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);malloc.free(_params);malloc.free(buf);
      },
    );
  }

  /// Performs a formatted write and read through a single call to an operation.
  Status viQueryf(int vi, String writeFmt, String readFmt) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();
    ViConstString _readFmt = writeFmt.toPointerCharMalloc();

    return _call<Status>(
      onCall: () {
        return visa.viQueryf(vi, _writeFmt, _readFmt);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);malloc.free(_readFmt);
      },
    );
  }

  /// Performs a formatted write and read through a single call to an operation.
  Status viVQueryf(int vi, String writeFmt, String readFmt, String params) {
    /// IN
    ViConstString _writeFmt = writeFmt.toPointerCharMalloc();
    ViConstString _readFmt = writeFmt.toPointerCharMalloc();
    ViVAList _params = params.toPointerCharMalloc();

    return _call<Status>(
      onCall: () {
        return visa.viVQueryf(vi, _writeFmt, _readFmt, _params);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_writeFmt);malloc.free(_readFmt);malloc.free(_params);
      },
    );
  }

  /// Reads in an 8-bit value from the specified memory space and offset.
  IntVal viIn8(int vi, int space, int offset) {
    ///OUT
    ViPUInt8 val8 = malloc<UnsignedChar>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn8(vi, space, offset, val8);
      },
      onResult: (visaStatus) {
        int val8_ = val8.value;
        return IntVal(val8_, visaStatus);
      },
      onFree: () {
        malloc.free(val8);
      },
    );
  }

  /// Writes an 8-bit value to the specified memory space and offset.
  Status viOut8(int vi, int space, int offset, int val8) {
    return _call<Status>(
      onCall: () {
        return visa.viOut8(vi, space, offset, val8);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads in an 16-bit value from the specified memory space and offset.
  IntVal viIn16(int vi, int space, int offset) {
    ///OUT
    ViPUInt16 val16 = malloc<UnsignedShort>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn16(vi, space, offset, val16);
      },
      onResult: (visaStatus) {
        int val16_ = val16.value;
        return IntVal(val16_, visaStatus);
      },
      onFree: () {
        malloc.free(val16);
      },
    );
  }

  /// Writes an 16-bit value to the specified memory space and offset.
  Status viOut16(int vi, int space, int offset, int val16) {
    return _call<Status>(
      onCall: () {
        return visa.viOut16(vi, space, offset, val16);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads in an 32-bit value from the specified memory space and offset.
  IntVal viIn32(int vi, int space, int offset) {
    ///OUT
    ViPUInt32 val32 = malloc<UnsignedInt>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn32(vi, space, offset, val32);
      },
      onResult: (visaStatus) {
        int val32_ = val32.value;
        return IntVal(val32_, visaStatus);
      },
      onFree: () {
        malloc.free(val32);
      },
    );
  }

  /// Writes an 32-bit value to the specified memory space and offset.
  Status viOut32(int vi, int space, int offset, int val32) {
    return _call<Status>(
      onCall: () {
        return visa.viOut32(vi, space, offset, val32);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads in an 64-bit value from the specified memory space and offset.
  IntVal viIn64(int vi, int space, int offset) {
    ///OUT
    ViPUInt64 val64 = malloc<UnsignedLongLong>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn64(vi, space, offset, val64);
      },
      onResult: (visaStatus) {
        int val64_ = val64.value;
        return IntVal(val64_, visaStatus);
      },
      onFree: () {
        malloc.free(val64);
      },
    );
  }

  /// Writes an 64-bit value to the specified memory space and offset.
  Status viOut64(int vi, int space, int offset, int val64) {
    return _call<Status>(
      onCall: () {
        return visa.viOut64(vi, space, offset, val64);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads in an 8-bit value from the specified memory space and offset.
  IntVal viIn8Ex(int vi, int space, int offset) {
    ///OUT
    ViPUInt8 val8 = malloc<UnsignedChar>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn8Ex(vi, space, offset, val8);
      },
      onResult: (visaStatus) {
        int val8_ = val8.value;
        return IntVal(val8_, visaStatus);
      },
      onFree: () {
        malloc.free(val8);
      },
    );
  }

  /// Writes an 8-bit value to the specified memory space and offset.
  Status viOut8Ex(int vi, int space, int offset, int val8) {
    return _call<Status>(
      onCall: () {
        return visa.viOut8Ex(vi, space, offset, val8);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads in an 16-bit value from the specified memory space and offset.
  IntVal viIn16Ex(int vi, int space, int offset) {
    ///OUT
    ViPUInt16 val16 = malloc<UnsignedShort>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn16Ex(vi, space, offset, val16);
      },
      onResult: (visaStatus) {
        int val16_ = val16.value;
        return IntVal(val16_, visaStatus);
      },
      onFree: () {
        malloc.free(val16);
      },
    );
  }

  /// Writes an 16-bit value to the specified memory space and offset.
  Status viOut16Ex(int vi, int space, int offset, int val16) {
    return _call<Status>(
      onCall: () {
        return visa.viOut16Ex(vi, space, offset, val16);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads in an 32-bit value from the specified memory space and offset.
  IntVal viIn32Ex(int vi, int space, int offset) {
    ///OUT
    ViPUInt32 val32 = malloc<UnsignedInt>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn32Ex(vi, space, offset, val32);
      },
      onResult: (visaStatus) {
        int val32_ = val32.value;
        return IntVal(val32_, visaStatus);
      },
      onFree: () {
        malloc.free(val32);
      },
    );
  }

  /// Writes an 32-bit value to the specified memory space and offset.
  Status viOut32Ex(int vi, int space, int offset, int val32) {
    return _call<Status>(
      onCall: () {
        return visa.viOut32Ex(vi, space, offset, val32);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Reads in an 64-bit value from the specified memory space and offset.
  IntVal viIn64Ex(int vi, int space, int offset) {
    ///OUT
    ViPUInt64 val64 = malloc<UnsignedLongLong>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viIn64Ex(vi, space, offset, val64);
      },
      onResult: (visaStatus) {
        int val64_ = val64.value;
        return IntVal(val64_, visaStatus);
      },
      onFree: () {
        malloc.free(val64);
      },
    );
  }

  /// Writes an 64-bit value to the specified memory space and offset.
  Status viOut64Ex(int vi, int space, int offset, int val64) {
    return _call<Status>(
      onCall: () {
        return visa.viOut64Ex(vi, space, offset, val64);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn8(int vi, int space, int length, int offset) {
    ///OUT
    ViAUInt8 buf8 = malloc<UnsignedChar>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn8(vi, space, offset, length, buf8);
      },
      onResult: (visaStatus) {
        int buf8_ = buf8.value;
        return IntVal(buf8_, visaStatus);
      },
      onFree: () {
        malloc.free(buf8);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut8(int vi, int space, int offset, int length, int buf8) {
    /// IN
    ViAUInt8 _buf8 = malloc<UnsignedChar>(1);
    _buf8.value = buf8.toUnsigned(8);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut8(vi, space, offset, length, _buf8);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_buf8);
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn16(int vi, int space, int length, int offset) {
    ///OUT
    ViAUInt16 buf16 = malloc<UnsignedShort>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn16(vi, space, offset, length, buf16);
      },
      onResult: (visaStatus) {
        int buf16_ = buf16.value;
        return IntVal(buf16_, visaStatus);
      },
      onFree: () {
        malloc.free(buf16);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut16(int vi, int space, int offset, int length, int buf16) {
    /// IN
    ViAUInt16 _buf16 = malloc<UnsignedShort>(1);
    _buf16.value = buf16.toUnsigned(16);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut16(vi, space, offset, length, _buf16);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn32(int vi, int space, int offset, int length) {
    ///OUT
    ViAUInt32 buf32 = malloc<UnsignedInt>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn32(vi, space, offset, length, buf32);
      },
      onResult: (visaStatus) {
        int buf32_ = buf32.value;
        return IntVal(buf32_, visaStatus);
      },
      onFree: () {
        malloc.free(buf32);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut32(int vi, int space, int offset, int length, int buf32) {
    /// IN
    ViAUInt32 _buf32 = malloc<UnsignedInt>(1);
    _buf32.value = buf32.toUnsigned(32);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut32(vi, space, offset, length, _buf32);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn64(int vi, int space, int length, int offset) {
    ///OUT
    ViAUInt64 buf64 = malloc<UnsignedLongLong>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn64(vi, space, offset, length, buf64);
      },
      onResult: (visaStatus) {
        int buf64_ = buf64.value;
        return IntVal(buf64_, visaStatus);
      },
      onFree: () {
        malloc.free(buf64);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut64(int vi, int space, int offset, int length, int buf64) {
    /// IN
    ViAUInt64 _buf64 = malloc<UnsignedLongLong>(1);
    _buf64.value = buf64.toUnsigned(64);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut64(vi, space, offset, length, _buf64);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn8Ex(int vi, int space, int offset, int length) {
    ///OUT
    ViAUInt8 buf8 = malloc<UnsignedChar>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn8Ex(vi, space, offset, length, buf8);
      },
      onResult: (visaStatus) {
        int buf8_ = buf8.value;
        return IntVal(buf8_, visaStatus);
      },
      onFree: () {
        malloc.free(buf8);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut8Ex(int vi, int space, int offset, int length, int buf8) {
    /// IN
    ViAUInt8 _buf8 = malloc<UnsignedChar>(1);
    _buf8.value = buf8.toUnsigned(8);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut8Ex(vi, space, offset, length, _buf8);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_buf8);
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn16Ex(int vi, int space, int offset, int length) {
    ///OUT
    ViAUInt16 buf16 = malloc<UnsignedShort>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn16Ex(vi, space, offset, length, buf16);
      },
      onResult: (visaStatus) {
        int buf16_ = buf16.value;
        return IntVal(buf16_, visaStatus);
      },
      onFree: () {
        malloc.free(buf16);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut16Ex(int vi, int space, int offset, int length, int buf16) {
    /// IN
    ViAUInt16 _buf16 = malloc<UnsignedShort>(1);
    _buf16.value = buf16.toUnsigned(16);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut16Ex(vi, space, offset, length, _buf16);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_buf16);
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn32Ex(int vi, int space, int offset, int length) {
    ///OUT
    ViAUInt32 buf32 = malloc<UnsignedInt>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn32Ex(vi, space, offset, length, buf32);
      },
      onResult: (visaStatus) {
        int buf32_ = buf32.value;
        return IntVal(buf32_, visaStatus);
      },
      onFree: () {
        malloc.free(buf32);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut32Ex(int vi, int space, int offset, int length, int buf32) {
    /// IN
    ViAUInt32 _buf32 = malloc<UnsignedInt>(1);
    _buf32.value = buf32.toUnsigned(32);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut32Ex(vi, space, offset, length, _buf32);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_buf32);
      },
    );
  }

  /// Moves a block of data from the specified address space and offset to local memory.
  IntVal viMoveIn64Ex(int vi, int space, int offset, int length) {
    ///OUT
    ViAUInt64 buf64 = malloc<UnsignedLongLong>(1);

    return _call<IntVal>(
      onCall: () {
        return visa.viMoveIn64Ex(vi, space, offset, length, buf64);
      },
      onResult: (visaStatus) {
        int buf64_ = buf64.value;
        return IntVal(buf64_, visaStatus);
      },
      onFree: () {
        malloc.free(buf64);
      },
    );
  }

  /// Moves a block of data from local memory to the specified address space and offset.
  Status viMoveOut64Ex(int vi, int space, int offset, int length, int buf64) {
    /// IN
    ViAUInt64 _buf64 = malloc<UnsignedLongLong>(1);
    _buf64.value = buf64.toUnsigned(64);

    return _call<Status>(
      onCall: () {
        return visa.viMoveOut64Ex(vi, space, offset, length, _buf64);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_buf64);
      },
    );
  }

  /// Moves a block of data.
  Status viMove(int vi, int srcSpace, int srcOffset, int srcWidth, int destSpace, int destOffset, int destWidth, int srcLength) {
    return _call<Status>(
      onCall: () {
        return visa.viMove(vi, srcSpace, srcOffset, srcWidth, destSpace, destOffset, destWidth, srcLength);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Moves a block of data.
  Status viMoveEx(int vi, int srcSpace, int srcOffset, int srcWidth, int destSpace, int destOffset, int destWidth, int srcLength) {
    return _call<Status>(
      onCall: () {
        return visa.viMoveEx(vi, srcSpace, srcOffset, srcWidth, destSpace, destOffset, destWidth, srcLength);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Moves a block of data asynchronously.
  JobId viMoveAsync(int vi, int srcSpace, int srcOffset, int srcWidth, int destSpace, int destOffset, int destWidth, int srcLength) {
    ///OUT
    ViPJobId jobId = malloc<UnsignedInt>(1);

    return _call<JobId>(
      onCall: () {
        return visa.viMoveAsync(vi, srcSpace, srcOffset, srcWidth, destSpace, destOffset, destWidth, srcLength, jobId);
      },
      onResult: (visaStatus) {
        int jobId_ = jobId.value;
        return JobId(jobId_, visaStatus);
      },
      onFree: () {
        malloc.free(jobId);
      },
    );
  }

  /// Moves a block of data asynchronously.
  JobId viMoveAsyncEx(int vi, int srcSpace, int srcOffset, int srcWidth, int destSpace, int destOffset, int destWidth, int srcLength) {
    ///OUT
    ViPJobId jobId = malloc<UnsignedInt>(1);

    return _call<JobId>(
      onCall: () {
        return visa.viMoveAsyncEx(vi, srcSpace, srcOffset, srcWidth, destSpace, destOffset, destWidth, srcLength, jobId);
      },
      onResult: (visaStatus) {
        int jobId_ = jobId.value;
        return JobId(jobId_, visaStatus);
      },
      onFree: () {
        malloc.free(jobId);
      },
    );
  }

  /// Maps the specified memory space into the process's address space.
  Address viMapAddress(int vi, int mapSpace, int mapOffset, int mapSize, int access, int suggested) {
    /// IN
    Pointer<Int> suggestedPointer = malloc<Int>(1);
    suggestedPointer.value = suggested;
    ViAddr _suggested = suggestedPointer.cast<Void>();

    ///OUT
    ViPAddr address = malloc<Pointer<Void>>(1);

    return _call<Address>(
      onCall: () {
        return visa.viMapAddress(vi, mapSpace, mapOffset, mapSize, access, _suggested, address);
      },
      onResult: (visaStatus) {
        int address_ = address.value.address;
        return Address(address_, visaStatus);
      },
      onFree: () {
        malloc.free(suggestedPointer);malloc.free(_suggested);malloc.free(address);
      },
    );
  }

  /// Unmaps memory space previously mapped by viMapAddress().
  Status viUnmapAddress(int vi) {
    return _call<Status>(
      onCall: () {
        return visa.viUnmapAddress(vi);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Maps the specified memory space into the process's address space.
  Address viMapAddressEx(int vi, int mapSpace, int mapOffset, int mapSize, int access, int suggested) {
    /// IN
    Pointer<Int> suggestedPointer = malloc<Int>(1);
    suggestedPointer.value = suggested;
    ViAddr _suggested = suggestedPointer.cast<Void>();

    ///OUT
    ViPAddr address = malloc<Pointer<Void>>(1);

    return _call<Address>(
      onCall: () {
        return visa.viMapAddressEx(vi, mapSpace, mapOffset, mapSize, access, _suggested, address);
      },
      onResult: (visaStatus) {
        int address_ = address.value.address;
        return Address(address_, visaStatus);
      },
      onFree: () {
        malloc.free(suggestedPointer);malloc.free(_suggested);malloc.free(address);
      },
    );
  }

  /// Reads an 8-bit value from the specified address.
  IntValue viPeek8(int vi, int address) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    ///OUT
    ViPUInt8 val8 = malloc<UnsignedChar>(1);

    return _callVoid<IntValue>(
      onCall: () {
        visa.viPeek8(vi, _address, val8);
      },
      onResult: () {
        int val8_ = val8.value;
        return IntValue(val8_);
      },
      onFree: () {
        malloc.free(_address);malloc.free(val8);
      },
    );
  }

  /// Writes an 8-bit value to the specified address.
  void viPoke8(int vi, int address, int val8) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    _callVoid<void>(
      onCall: () {
        visa.viPoke8(vi, _address, val8);
      },
      onResult: () {
      },
      onFree: () {
        malloc.free(_address);
      },
    );
  }

  /// Reads an 16-bit value from the specified address.
  IntValue viPeek16(int vi, int address) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    ///OUT
    ViPUInt16 val16 = malloc<UnsignedShort>(1);

    return _callVoid<IntValue>(
      onCall: () {
        visa.viPeek16(vi, _address, val16);
      },
      onResult: () {
        int val8_ = val16.value;
        return IntValue(val8_);
      },
      onFree: () {
        malloc.free(_address);malloc.free(val16);
      },
    );
  }

  /// Writes 16-bit value to the specified address.
  void viPoke16(int vi, int address, int val16) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    _callVoid<void>(
      onCall: () {
        visa.viPoke16(vi, _address, val16);
      },
      onResult: () {
      },
      onFree: () {
        malloc.free(_address);
      },
    );
  }

  /// Reads an 32-bit value from the specified address.
  IntValue viPeek32(int vi, int address) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    ///OUT
    ViPUInt32 val32 = malloc<UnsignedInt>(1);

    return _callVoid<IntValue>(
      onCall: () {
        visa.viPeek32(vi, _address, val32);
      },
      onResult: () {
        int val32_ = val32.value;
        return IntValue(val32_);
      },
      onFree: () {
        malloc.free(_address);malloc.free(val32);
      },
    );
  }

  /// Writes an 32-bit value to the specified address.
  void viPoke32(int vi, int address, int val32) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    _callVoid<void>(
      onCall: () {
        visa.viPoke32(vi, _address, val32);
      },
      onResult: () {
      },
      onFree: () {
        malloc.free(_address);
      },
    );
  }

  /// Reads an 64-bit value from the specified address.
  IntValue viPeek64(int vi, int address) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    ///OUT
    ViPUInt64 val64 = malloc<UnsignedLongLong>(1);

    return _callVoid<IntValue>(
      onCall: () {
        visa.viPeek64(vi, _address, val64);
      },
      onResult: () {
        int val64_ = val64.value;
        return IntValue(val64_);
      },
      onFree: () {
        malloc.free(_address);malloc.free(val64);
      },
    );
  }

  /// Writes an 64-bit value to the specified address.
  void viPoke64(int vi, int address, int val64) {
    /// IN
    ViAddr _address = Pointer.fromAddress(address);

    _callVoid<void>(
      onCall: () {
        visa.viPoke64(vi, _address, val64);
      },
      onResult: () {
      },
      onFree: () {
        malloc.free(_address);
      },
    );
  }

  /// Allocates memory from a resource's memory region.
  Offset viMemAlloc(int vi, int size) {
    ///OUT
    ViPBusAddress offset = malloc<UnsignedLongLong>(1);

    return _call<Offset>(
      onCall: () {
        return visa.viMemAlloc(vi, size, offset);
      },
      onResult: (visaStatus) {
        int offset_ = offset.value;
        return Offset(offset_, visaStatus);
      },
      onFree: () {
        malloc.free(offset);
      },
    );
  }

  /// Frees memory previously allocated using the viMemAlloc() operation.
  Status viMemFree(int vi, int offset) {
    return _call<Status>(
      onCall: () {
        return visa.viMemFree(vi, offset);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Allocates memory from a resource's memory region.
  Offset viMemAllocEx(int vi, int size) {
    ///OUT
    ViPBusAddress offset = malloc<UnsignedLongLong>(1);

    return _call<Offset>(
      onCall: () {
        return visa.viMemAllocEx(vi, size, offset);
      },
      onResult: (visaStatus) {
        int offset_ = offset.value;
        return Offset(offset_, visaStatus);
      },
      onFree: () {
        malloc.free(offset);
      },
    );
  }

  /// Frees memory previously allocated using the viMemAlloc() operation.
  Status viMemFreeEx(int vi, int offset) {
    return _call<Status>(
      onCall: () {
        return visa.viMemFreeEx(vi, offset);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Controls the state of the GPIB Remote Enable (REN) interface line, and optionally the remote/local state of the device.
  Status viGpibControlREN(int vi, int mode) {
    return _call<Status>(
      onCall: () {
        return visa.viGpibControlREN(vi, mode);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Specifies the state of the ATN line and the local active controller state.
  Status viGpibControlATN(int vi, int mode) {
    return _call<Status>(
      onCall: () {
        return visa.viGpibControlATN(vi, mode);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Pulse the interface clear line (IFC) for at least 100 microseconds.
  Status viGpibSendIFC(int vi) {
    return _call<Status>(
      onCall: () {
        return visa.viGpibSendIFC(vi);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Write GPIB command bytes on the bus.
  ReturnCount viGpibCommand(int vi, String cmd, int cnt) {
    /// IN
    ViConstBuf _cmd = malloc<UnsignedChar>(cmd.length);

    ///OUT
    ViPUInt32 retCnt = malloc<UnsignedInt>(1);

    return _call<ReturnCount>(
      onCall: () {
        return visa.viGpibCommand(vi, _cmd, cnt, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_ = retCnt.value;
        return ReturnCount(retCnt_, visaStatus);
      },
      onFree: () {
        malloc.free(_cmd);malloc.free(retCnt);
      },
    );
  }

  /// Tell the GPIB device at the specified address to become controller in charge (CIC).
  Status viGpibPassControl(int vi, int primAddr, int secAddr) {
    return _call<Status>(
      onCall: () {
        return visa.viGpibPassControl(vi, primAddr, secAddr);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Sends the device a miscellaneous command or query and/or retrieves the response to a previous query.
  Status viVxiCommandQuery(int vi, int mode, int cmd) {
    ///OUT
    ViPUInt32 response = malloc<UnsignedInt>(1);

    return _call<Status>(
      onCall: () {
        return visa.viVxiCommandQuery(vi, mode, cmd, response);
      },
      onResult: (visaStatus) {
        int response_ = response.value;
        return Response(response_, visaStatus);
      },
      onFree: () {
        malloc.free(response);
      },
    );
  }

  /// Asserts or deasserts the specified utility bus signal.
  Status viAssertUtilSignal(int vi, int line) {
    return _call<Status>(
      onCall: () {
        return visa.viAssertUtilSignal(vi, line);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Asserts the specified interrupt or signal.
  Status viAssertIntrSignal(int vi, int mode, int statusID) {
    return _call<Status>(
      onCall: () {
        return visa.viAssertIntrSignal(vi, mode, statusID);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Map the specified trigger source line to the specified destination line.
  Status viMapTrigger(int vi, int trigSrc, int trigDest, int mode) {
    return _call<Status>(
      onCall: () {
        return visa.viMapTrigger(vi, trigSrc, trigDest, mode);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Undo a previous map from the specified trigger source line to the specified destination line.
  Status viUnmapTrigger(int vi, int trigSrc, int trigDest) {
    return _call<Status>(
      onCall: () {
        return visa.viUnmapTrigger(vi, trigSrc, trigDest);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

  /// Performs a USB control pipe transfer to the device.
  Status viUsbControlOut(int vi, int bmRequestType, int bRequest, int wValue, int wIndex, int wLength, String buf) {
    /// IN
    ViConstBuf _buf = malloc<UnsignedChar>(buf.length);

    return _call<Status>(
      onCall: () {
        return visa.viUsbControlOut(vi, bmRequestType, bRequest, wValue, wIndex, wLength, _buf);
      },
      onResult: (visaStatus) {
        return Status(visaStatus);
      },
      onFree: () {
        malloc.free(_buf);
      },
    );
  }

  /// Performs a USB control pipe transfer from the device.
  Buffer viUsbControlIn(int vi, int bmRequestType, int bRequest, int wValue, int wIndex, int wLength) {
    ///OUT
    ViPBuf buf = malloc<UnsignedChar>(MAX_STRING_LENGTH);
    ViPUInt16 retCnt = malloc<UnsignedShort>(1);

    return _call<Buffer>(
      onCall: () {
        return visa.viUsbControlIn(vi, bmRequestType, bRequest, wValue, wIndex, wLength, buf, retCnt);
      },
      onResult: (visaStatus) {
        int retCnt_ = retCnt.value;
        Uint8List buf_ = buf.toUint8List(retCnt_);
        return Buffer(buf_, retCnt_, visaStatus);
      },
      onFree: () {
        malloc.free(buf);malloc.free(retCnt);
      },
    );
  }

  /// Reserves multiple trigger lines that the caller can then map and/or assert.
  Status viPxiReserveTriggers(int vi, int cnt, int trigBuses, int trigLines) {
    /// IN
    ViAInt16 _trigBuses = malloc<Short>(1);
    _trigBuses.value = trigBuses;
    ViAInt16 _trigLines = malloc<Short>(1);
    _trigLines.value = trigLines;

    ///OUT
    ViPInt16 failureIndex = malloc<Short>(1);

    return _call<Status>(
      onCall: () {
        return visa.viPxiReserveTriggers(vi, cnt, _trigBuses, _trigLines, failureIndex);
      },
      onResult: (visaStatus) {
        int failureIndex_ = failureIndex.value;
        return FailureIndex(failureIndex_, visaStatus);
      },
      onFree: () {
        malloc.free(_trigBuses);malloc.free(_trigLines);malloc.free(failureIndex);
      },
    );
  }

  /// mode values include VI_VXI_RESP16, VI_VXI_RESP32, and the next 2 values
  Status viVxiServantResponse(int vi, int mode, int resp) {
    return _call<Status>(
      onCall: () {
        return visa.viVxiServantResponse(vi, mode, resp);
      },
      onResult: (visaStatus) {

        return Status(visaStatus);
      },
      onFree: () {
      },
    );
  }

}