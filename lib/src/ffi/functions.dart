import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'ctypes.dart';

final DynamicLibrary visaLib = Platform.isMacOS
    ? DynamicLibrary.open('/Library/Frameworks/VISA.framework/Versions/A/VISA')
    : DynamicLibrary.open('visa32.dll'); // or appropriate path for other platforms

// Resource Manager Functions and Operations

/// PURPOSE
/// Queries a VISA system to locate the resources associated with a specified interface.
/// DESCRIPTION
/// The viOpenDefaultRM() function must be called before any VISA operations can
/// be invoked. The first call to this function initializes the VISA system, including the
/// Default Resource Manager resource, and also returns a session to that resource.
/// Subsequent calls to this function return unique sessions to the same Default Resource
/// Manager resource.
/// When a Resource Manager session is passed to viClose(), not only is that session
/// closed, but also all find lists and device sessions (which that Resource Manager session
/// was used to create) are closed.
typedef ViOpenDefaultRMNative = ViStatus Function(Pointer<ViSession> vi);
typedef ViOpenDefaultRM = int Function(Pointer<ViSession> vi);
final ViOpenDefaultRM viOpenDefaultRM = visaLib.lookupFunction<ViOpenDefaultRMNative, ViOpenDefaultRM>('viOpenDefaultRM');

/// PURPOSE
/// Queries a VISA system to locate the resources associated with a specified interface.
/// DESCRIPTION
/// The viFindRsrc() operation matches the value specified in the expr parameter
/// with the resources available for a particular interface. A regular expression is a string
/// consisting of ordinary characters as well as special characters. You use a regular
/// expression to specify patterns to match in a given string; in other words, it is a search
/// criterion. The viFindRsrc() operation uses a case-insensitive compare feature
/// when matching resource names against the regular expression specified in expr. For
/// example, calling viFindRsrc() with "VXI?*INSTR" would return the same
/// resources as invoking it with "vxi?*instr".
/// On successful completion, this function returns the first resource found (instrDesc)
/// and returns a count (retcnt) to indicate if there were more resources found for the
/// designated interface. This function also returns, in the findList parameter, a handle to
/// a find list. This handle points to the list of resources and it must be used as an input to
/// viFindNext(). When this handle is no longer needed, it should be passed to viClose().
/// Notice that retcnt and findList are optional parameters. This is useful if only the
/// first match is important, and the number of matches is not needed. If you specify V
/// I_NULL in the findList parameter and the operation completes successfully, VISA
/// automatically invokes viClose() on the find list handle rather than returning it to
/// the application.
typedef ViFindRsrcNative = ViStatus Function(
  ViSession sesn,
  ViConstString expr,
  ViPFindList vi,
  ViPUInt32 retCnt,
  ViPChar desc,
);
typedef ViFindRsrc = int Function(
  int sesn,
  Pointer<Utf8> expr,
  Pointer<Uint32> vi,
  Pointer<Uint32> retCnt,
  Pointer<Utf8> desc,
);
final ViFindRsrc viFindRsrc = visaLib.lookupFunction<ViFindRsrcNative, ViFindRsrc>('viFindRsrc');

/// PURPOSE
/// Returns the next resource from the list of resources found during a previous call to viFindRsrc().
/// DESCRIPTION
/// The viFindNext() operation returns the next device found in the list created by viFindRsrc().
/// The list is referenced by the handle that was returned by viFindRsrc().
typedef ViFindNextNative = ViStatus Function(
  ViFindList vi,
  ViPChar desc,
);
typedef ViFindNext = int Function(
  int vi,
  Pointer<Utf8> desc,
);
final ViFindNext viFindNext = visaLib.lookupFunction<ViFindNextNative, ViFindNext>('viFindNext');

/// PURPOSE
/// Parse a resource string to get the interface information.
/// DESCRIPTION
/// This operation parses a resource string to verify its validity. It should succeed for all
/// strings returned by viFindRsrc() and recognized by viOpen(). This operation is
/// useful if you want to know what interface a given resource descriptor would use
/// without actually opening a session to it. Refer to VISA Resource Syntax and Examples
/// for the syntax of resource strings and examples.
/// The values returned in intfType and intfNum correspond to the attributes VI_ATT
/// R_INTF_TYPE and VI_ATTR_INTF_NUM. These values would be the same if a user
/// opened that resource with viOpen() and queried the attributes with viGetAttrib
/// ute().
/// Calling viParseRsrc() with "VXI::1::INSTR" will produce the same results as
/// invoking it with "vxi::1::instr".
typedef ViParseRsrcNative = ViStatus Function(
  ViSession rmSesn,
  ViConstRsrc rsrcName,
  ViPUInt16 intfType,
  ViPUInt16 intfNum,
);
typedef ViParseRsrc = int Function(
  int rmSesn,
  Pointer<Utf8> rsrcName,
  Pointer<Uint16> intfType,
  Pointer<Uint16> intfNum,
);
final ViParseRsrc viParseRsrc = visaLib.lookupFunction<ViParseRsrcNative, ViParseRsrc>('viParseRsrc');

/// PURPOSE
/// Parse a resource string to get extended interface information.
/// DESCRIPTION
/// This operation parses a resource string to verify its validity. It should succeed for all
/// strings returned by viFindRsrc() and recognized by viOpen(). This operation is
/// useful if you want to know what interface a given resource descriptor would use
/// without actually opening a session to it. Refer to VISA Resource Syntax and Examples
/// for the syntax of resource strings and examples.
/// The values returned in intfType and intfNum correspond to the attributes VI_ATT
/// R_INTF_TYPE and VI_ATTR_INTF_NUM. These values would be the same if a user
/// opened that resource with viOpen() and queried the attributes with viGetAttrib
/// ute().
/// The value returned in unaliasedExpandedName should in most cases be identical to
/// the VISA-defined canonical resource name. However, there may be cases where the
/// canonical name includes information that the driver may not know until the resource
/// has actually been opened. In these cases, the value returned in this parameter must be
/// semantically similar.
/// The value returned in aliasIfExists allows programmatic access to user-defined aliases.
/// Calling viParseRsrc() with "VXI::1::INSTR" will produce the same results as
/// invoking it with "vxi::1::instr".
typedef ViParseRsrcExNative = ViStatus Function(
    ViSession rmSesn,
    ViConstRsrc rsrcName,
    Pointer<Uint16> intfType,
    Pointer<Uint16> intfNum,
    Pointer<ViChar> rsrcClass,
    Pointer<ViChar> expandedUnaliasedName,
    Pointer<ViChar> aliasIfExists,
    );
typedef ViParseRsrcEx = int Function(
    int rmSesn,
    ViConstRsrc rsrcName,
    Pointer<Uint16> intfType,
    Pointer<Uint16> intfNum,
    Pointer<ViChar> rsrcClass,
    Pointer<ViChar> expandedUnaliasedName,
    Pointer<ViChar> aliasIfExists,
    );
final ViParseRsrcEx viParseRsrcEx = visaLib.lookupFunction<ViParseRsrcExNative, ViParseRsrcEx>('viParseRsrcEx');

/// PURPOSE
/// Opens a session to the specified resource.
/// DESCRIPTION
/// The viOpen() operation opens a session to the specified resource. It returns a
/// session identifier that can be used to call any other operations of that resource. The
/// address string passed to viOpen() must uniquely identify a resource. Refer to VISA
/// Resource Syntax and Examples for the syntax of resource strings and examples.
/// For the parameter accessMode, the value VI_EXCLUSIVE_LOCK (1) is used to
/// acquire an exclusive lock immediately upon opening a session; if a lock cannot be
/// acquired, the session is closed and an error is returned. The value VI_LOAD_CONFIG
/// (4) is used to configure attributes to values specified by some external configuration
/// utility. Multiple access modes can be used simultaneously by specifying a bit -wise
/// OR of the values other than VI_NULL. NI-VISA currently supports VI_LOAD_CONFIG
/// only on Serial INSTR sessions.
/// All resource strings returned by viFindRsrc() will always be recognized by viOpe
/// n(). However, viFindRsrc() will not necessarily return all strings that you can
/// pass to viParseRsrc() or viOpen(). This is especially true for network and TCPIP
/// resources.
typedef ViOpenNative = ViStatus Function(
    ViSession sesn,
    ViConstRsrc name,
    ViAccessMode mode,
    ViUInt32 timeout,
    Pointer<ViSession> vi,
    );
typedef ViOpen = int Function(
    int sesn,
    ViConstRsrc name,
    int mode,
    int timeout,
    Pointer<ViSession> vi,
    );
final ViOpen viOpen = visaLib.lookupFunction<ViOpenNative, ViOpen>('viOpen');

// Resource Template Operations

/// PURPOSE
/// Closes the specified session, event, or find list.
/// DESCRIPTION
/// The viClose() operation closes a session, event, or a find list. In this process all the
/// data structures that had been allocated for the specified vi are freed. Calling viClose()
/// on a VISA Resource Manager session will also close all I/O sessions associated
/// with that resource manager session.
typedef ViCloseNative = ViStatus Function(ViObject vi);
typedef ViClose = int Function(int vi);
final ViClose viClose = visaLib.lookupFunction<ViCloseNative, ViClose>('viClose');

/// PURPOSE
/// Sets the state of an attribute.
/// DESCRIPTION
/// The viSetAttribute() operation is used to modify the state of an attribute for the
/// specified object.
/// Both VI_WARN_NSUP_ATTR_STATE and VI_ERROR_NSUP_ATTR_STATE indicate
/// that the specified attribute state is not supported. A resource normally returns the
/// error code VI_ERROR_NSUP_ATTR_STATE when it cannot set a specified attribute
/// state. The completion code VI_WARN_NSUP_ATTR_STATE is intended to alert the
/// application that although the specified optional attribute state is not supported, the
/// application should not fail. One example is attempting to set an attribute value that
/// would increase performance speeds. This is different than attempting to set an
/// attribute value that specifies required but nonexistent hardware (such as specifying a
/// VXI ECL trigger line when no hardware support exists) or a value that would change
/// assumptions a resource might make about the way data is stored or formatted (such
/// as byte order).
/// Some attributes documented as being generally Read/Write may at times be Read
/// Only. This is usually the case when an attribute configures how the VISA driver receives
/// events of a given type, and the event type associated with that attribute is currently
/// enabled. Under these circumstances, calling viSetAttribute on that attribute
/// returns VI_ERROR_ATTR_READONLY.
/// The error code VI_ERROR_RSRC_LOCKED is returned only if the specified attribute is
/// Read/Write and Global, and the resource is locked by another session.
typedef ViSetAttributeNative = ViStatus Function(
    ViObject vi,
    ViAttr attrName,
    ViAttrState attrValue,
    );
typedef ViSetAttribute = int Function(
    int vi,
    int attrName,
    int attrValue,
    );
final ViSetAttribute viSetAttribute = visaLib.lookupFunction<ViSetAttributeNative, ViSetAttribute>('viSetAttribute');

/// PURPOSE
/// Retrieves the state of an attribute.
/// DESCRIPTION
/// The viGetAttribute() operation is used to retrieve the state of an attribute for
/// the specified session, event, or find list.
/// The output parameter attrState is of the type of the attribute actually being retrieved.
/// For example, when retrieving an attribute that is defined as a ViBoolean, your
/// application should pass a reference to a variable of type ViBoolean. Similarly, if the
/// attribute is defined as being ViUInt32, your application should pass a reference to a
/// variable of type ViUInt32.
typedef ViGetAttributeNative = ViStatus Function(
    ViObject vi,
    ViAttr attrName,
    Pointer<Void> attrValue,
    );
typedef ViGetAttribute = int Function(
    int vi,
    int attrName,
    Pointer<Void> attrValue,
    );
final ViGetAttribute viGetAttribute = visaLib.lookupFunction<ViGetAttributeNative, ViGetAttribute>('viGetAttribute');

/// PURPOSE
/// Returns a user-readable description of the status code passed to the operation.
/// DESCRIPTION
/// The viStatusDesc() operation is used to retrieve a user-readable string that
/// describes the status code presented. If the string cannot be interpreted, the operation
/// returns the warning code VI_WARN_UNKNOWN_STATUS. However, the output string
/// desc is valid regardless of the status return value.
typedef ViStatusDescNative = ViStatus Function(
    ViObject vi,
    ViStatus status,
    Pointer<ViChar> desc,
    );
typedef ViStatusDesc = int Function(
    int vi,
    int status,
    Pointer<ViChar> desc,
    );
final ViStatusDesc viStatusDesc = visaLib.lookupFunction<ViStatusDescNative, ViStatusDesc>('viStatusDesc');

/// PURPOSE
/// Requests a VISA session to terminate normal execution of an operation.
/// DESCRIPTION
/// This operation is used to request a session to terminate normal execution of an
/// operation, as specified by the jobId parameter. The jobId parameter is a unique value
/// generated from each call to an asynchronous operation.
/// If a user passes VI_NULL as the jobId value to viTerminate(), VISA will abort any
/// calls in the current process executing on the specified vi. Any call that is terminated
/// this way should return VI_ERROR_ABORT. Due to the nature of multi-threaded
/// systems, for example where operations in other threads may complete normally
/// before the operation viTerminate() has any effect, the specified return value is
/// not guaranteed.
typedef ViTerminateNative = ViStatus Function(
    ViObject vi,
    Uint16 degree,
    ViJobId jobId,
    );
typedef ViTerminate = int Function(
    int vi,
    int degree,
    int jobId,
    );
final ViTerminate viTerminate = visaLib.lookupFunction<ViTerminateNative, ViTerminate>('viTerminate');

/// PURPOSE
/// Establishes an access mode to the specified resources.
/// DESCRIPTION
/// This operation is used to obtain a lock on the specified resource. The caller can specify
/// the type of lock requested—exclusive or shared lock—and the length of time the
/// operation will suspend while waiting to acquire the lock before timing out. This
/// operation can also be used for sharing and nesting locks.
/// The requestedKey and the accessKey parameters apply only to shared locks. These
/// parameters are not applicable when using the lock type VI_EXCLUSIVE_LOCK; in
/// this case, requestedKey and accessKey should be set to VI_NULL. VISA allows user
/// applications to specify a key to be used for lock sharing, through the use of the
/// requestedKey parameter. Alternatively, a user application can pass VI_NULL for the
/// requestedKey parameter when obtaining a shared lock, in which case VISA will
/// generate a unique access key and return it through the accessKey parameter. If a user
/// application does specify a requestedKey value, VISA will try to use this value for the
/// accessKey. As long as the resource is not locked, VISA will use the requestedKey as the
/// access key and grant the lock. When the operation succeeds, the requestedKey will be
/// copied into the user buffer referred to by the accessKey parameter.
/// The session that gained a shared lock can pass the accessKey to other sessions for the
/// purpose of sharing the lock. The session wanting to join the group of sessions sharing
/// the lock can use the key as an input value to the requestedKey parameter. VISA will
/// add the session to the list of sessions sharing the lock, as long as the requestedKey
/// value matches the accessKey value for the particular resource. The session obtaining a
/// shared lock in this manner will then have the same access privileges as the original
/// session that obtained the lock.
/// It is also possible to obtain nested locks through this operation. To acquire nested
/// locks, invoke the viLock() operation with the same lock type as the previous
/// invocation of this operation. For each session, viLock() and viUnlock() share a
/// lock count, which is initialized to 0. Each invocation of viLock() for the same
/// session (and for the same lockType) increases the lock count. In the case of a shared
/// lock, it returns with the same accessKey every time. When a session locks the resource
/// a multiple number of times, it is necessary to invoke the viUnlock() operation an
/// equal number of times in order to unlock the resource. That is, the lock count
/// increments for each invocation of viLock(), and decrements for each invocation of
/// viUnlock(). A resource is actually unlocked only when the lock count is 0.
/// The VISA locking mechanism enforces arbitration of accesses to resources on an
/// individual basis. If a session locks a resource, operations invoked by other sessions to
/// the same resource are serviced or returned with a locking error, depending on the
/// operation and the type of lock used. If a session has an exclusive lock, other sessions
/// cannot modify global attributes or invoke operations, but can still get attributes and
/// set local attributes. If the session has a shared lock, other sessions that have shared
/// locks can also modify global attributes and invoke operations. Regardless of which
/// type of lock a session has, if the session is closed without first being unlocked, VISA
/// automatically performs a viUnlock() on that session.
/// The locking mechanism works for all processes and resources existing on the same
typedef ViLockNative = ViStatus Function(
    ViSession vi,
    ViAccessMode lockType,
    ViUInt32 timeout,
    ViConstKeyId requestedKey,
    Pointer<ViChar> accessKey,
    );
typedef ViLock = int Function(
    int vi,
    int lockType,
    int timeout,
    ViConstKeyId requestedKey,
    Pointer<ViChar> accessKey,
    );
final ViLock viLock = visaLib.lookupFunction<ViLockNative, ViLock>('viLock');

/// PURPOSE
/// Relinquishes a lock for the specified resource.
/// DESCRIPTION
/// This operation is used to relinquish the lock previously obtained using the viLock()
/// operation.
typedef ViUnlockNative = ViStatus Function(ViSession vi);
typedef ViUnlock = int Function(int vi);
final ViUnlock viUnlock = visaLib.lookupFunction<ViUnlockNative, ViUnlock>('viUnlock');

typedef ViEnableEventNative = ViStatus Function(
    ViSession vi,
    ViEventType eventType,
    Uint16 mechanism,
    ViEventFilter context,
    );
typedef ViEnableEvent = int Function(
    int vi,
    int eventType,
    int mechanism,
    int context,
    );
final ViEnableEvent viEnableEvent = visaLib.lookupFunction<ViEnableEventNative, ViEnableEvent>('viEnableEvent');

typedef ViDisableEventNative = ViStatus Function(
    ViSession vi,
    ViEventType eventType,
    Uint16 mechanism,
    );
typedef ViDisableEvent = int Function(
    int vi,
    int eventType,
    int mechanism,
    );
final ViDisableEvent viDisableEvent = visaLib.lookupFunction<ViDisableEventNative, ViDisableEvent>('viDisableEvent');

typedef ViDiscardEventsNative = ViStatus Function(
    ViSession vi,
    ViEventType eventType,
    Uint16 mechanism,
    );
typedef ViDiscardEvents = int Function(
    int vi,
    int eventType,
    int mechanism,
    );
final ViDiscardEvents viDiscardEvents = visaLib.lookupFunction<ViDiscardEventsNative, ViDiscardEvents>('viDiscardEvents');

typedef ViWaitOnEventNative = ViStatus Function(
    ViSession vi,
    ViEventType inEventType,
    ViUInt32 timeout,
    Pointer<ViEventType> outEventType,
    Pointer<ViEvent> outContext,
    );
typedef ViWaitOnEvent = int Function(
    int vi,
    int inEventType,
    int timeout,
    Pointer<ViEventType> outEventType,
    Pointer<ViEvent> outContext,
    );
final ViWaitOnEvent viWaitOnEvent = visaLib.lookupFunction<ViWaitOnEventNative, ViWaitOnEvent>('viWaitOnEvent');

typedef ViInstallHandlerNative = ViStatus Function(
    ViSession vi,
    ViEventType eventType,
    ViHndlr handler,
    ViAddr userHandle,
    );
typedef ViInstallHandler = int Function(
    int vi,
    int eventType,
    ViHndlr handler,
    ViAddr userHandle,
    );
final ViInstallHandler viInstallHandler = visaLib.lookupFunction<ViInstallHandlerNative, ViInstallHandler>('viInstallHandler');

typedef ViUninstallHandlerNative = ViStatus Function(
    ViSession vi,
    ViEventType eventType,
    ViHndlr handler,
    ViAddr userHandle,
    );
typedef ViUninstallHandler = int Function(
    int vi,
    int eventType,
    ViHndlr handler,
    ViAddr userHandle,
    );
final ViUninstallHandler viUninstallHandler = visaLib.lookupFunction<ViUninstallHandlerNative, ViUninstallHandler>('viUninstallHandler');

// Basic I/O Operations

typedef ViReadNative = ViStatus Function(
    ViSession vi,
    ViBuf buf,
    ViUInt32 cnt,
    Pointer<ViUInt32> retCnt,
    );
typedef ViRead = int Function(
    int vi,
    Pointer<Utf8> buf,
    int cnt,
    Pointer<ViUInt32> retCnt,
    );
final ViRead viRead = visaLib.lookupFunction<ViReadNative, ViRead>('viRead');

typedef ViReadAsyncNative = ViStatus Function(
    ViSession vi,
    Pointer<Uint8> buf,
    ViUInt32 cnt,
    Pointer<ViJobId> jobId,
    );
typedef ViReadAsync = int Function(
    int vi,
    Pointer<Uint8> buf,
    int cnt,
    Pointer<ViJobId> jobId,
    );
final ViReadAsync viReadAsync = visaLib.lookupFunction<ViReadAsyncNative, ViReadAsync>('viReadAsync');

typedef ViReadToFileNative = ViStatus Function(
    ViSession vi,
    ViConstString filename,
    ViUInt32 cnt,
    Pointer<ViUInt32> retCnt,
    );
typedef ViReadToFile = int Function(
    int vi,
    ViConstString filename,
    int cnt,
    Pointer<ViUInt32> retCnt,
    );
final ViReadToFile viReadToFile = visaLib.lookupFunction<ViReadToFileNative, ViReadToFile>('viReadToFile');

/// PURPOSE
/// Writes data to device or interface synchronously.
/// DESCRIPTION
/// The viWrite() operation synchronously transfers data. The data to be written is in
/// the buffer represented by buf. This operation returns only when the transfer
/// terminates. Only one synchronous write operation can occur at any one time.
typedef ViWriteNative = ViStatus Function(
    ViSession vi,
    ViBuf buf,
    ViUInt32 cnt,
    Pointer<ViUInt32> retCnt,
    );
typedef ViWrite = int Function(
    int vi,
    Pointer<Utf8> buf,
    int cnt,
    Pointer<ViUInt32> retCnt,
    );
final ViWrite viWrite = visaLib.lookupFunction<ViWriteNative, ViWrite>('viWrite');

typedef ViWriteAsyncNative = ViStatus Function(
    ViSession vi,
    Pointer<Uint8> buf,
    ViUInt32 cnt,
    Pointer<ViJobId> jobId,
    );
typedef ViWriteAsync = int Function(
    int vi,
    Pointer<Uint8> buf,
    int cnt,
    Pointer<ViJobId> jobId,
    );
final ViWriteAsync viWriteAsync = visaLib.lookupFunction<ViWriteAsyncNative, ViWriteAsync>('viWriteAsync');

typedef ViWriteFromFileNative = ViStatus Function(
    ViSession vi,
    ViConstString filename,
    ViUInt32 cnt,
    Pointer<ViUInt32> retCnt,
    );
typedef ViWriteFromFile = int Function(
    int vi,
    ViConstString filename,
    int cnt,
    Pointer<ViUInt32> retCnt,
    );
final ViWriteFromFile viWriteFromFile = visaLib.lookupFunction<ViWriteFromFileNative, ViWriteFromFile>('viWriteFromFile');

typedef ViAssertTriggerNative = ViStatus Function(
    ViSession vi,
    Uint16 protocol,
    );
typedef ViAssertTrigger = int Function(
    int vi,
    int protocol,
    );
final ViAssertTrigger viAssertTrigger = visaLib.lookupFunction<ViAssertTriggerNative, ViAssertTrigger>('viAssertTrigger');

typedef ViReadSTBNative = ViStatus Function(
    ViSession vi,
    Pointer<Uint16> status,
    );
typedef ViReadSTB = int Function(
    int vi,
    Pointer<Uint16> status,
    );
final ViReadSTB viReadSTB = visaLib.lookupFunction<ViReadSTBNative, ViReadSTB>('viReadSTB');

typedef ViClearNative = ViStatus Function(ViSession vi);
typedef ViClear = int Function(int vi);
final ViClear viClear = visaLib.lookupFunction<ViClearNative, ViClear>('viClear');

// Formatted and Buffered I/O Operations

typedef ViSetBufNative = ViStatus Function(
    ViSession vi,
    Uint16 mask,
    ViUInt32 size,
    );
typedef ViSetBuf = int Function(
    int vi,
    int mask,
    int size,
    );
final ViSetBuf viSetBuf = visaLib.lookupFunction<ViSetBufNative, ViSetBuf>('viSetBuf');

typedef ViFlushNative = ViStatus Function(
    ViSession vi,
    Uint16 mask,
    );
typedef ViFlush = int Function(
    int vi,
    int mask,
    );
final ViFlush viFlush = visaLib.lookupFunction<ViFlushNative, ViFlush>('viFlush');

typedef ViBufWriteNative = ViStatus Function(
    ViSession vi,
    Pointer<Uint8> buf,
    ViUInt32 cnt,
    Pointer<ViUInt32> retCnt,
    );
typedef ViBufWrite = int Function(
    int vi,
    Pointer<Uint8> buf,
    int cnt,
    Pointer<ViUInt32> retCnt,
    );
final ViBufWrite viBufWrite = visaLib.lookupFunction<ViBufWriteNative, ViBufWrite>('viBufWrite');

typedef ViBufReadNative = ViStatus Function(
    ViSession vi,
    Pointer<Uint8> buf,
    ViUInt32 cnt,
    Pointer<ViUInt32> retCnt,
    );
typedef ViBufRead = int Function(
    int vi,
    Pointer<Uint8> buf,
    int cnt,
    Pointer<ViUInt32> retCnt,
    );
final ViBufRead viBufRead = visaLib.lookupFunction<ViBufReadNative, ViBufRead>('viBufRead');

typedef ViPrintfNative = ViStatus Function(
    ViSession vi,
    ViConstString writeFmt,
    Pointer<Uint8> params,
    );
typedef ViPrintf = int Function(
    int vi,
    ViConstString writeFmt,
    Pointer<Uint8> params,
    );
final ViPrintf viPrintf = visaLib.lookupFunction<ViPrintfNative, ViPrintf>('viPrintf');

typedef ViVPrintfNative = ViStatus Function(
    ViSession vi,
    ViConstString writeFmt,
    ViVAList params,
    );
typedef ViVPrintf = int Function(
    int vi,
    ViConstString writeFmt,
    ViVAList params,
    );
final ViVPrintf viVPrintf = visaLib.lookupFunction<ViVPrintfNative, ViVPrintf>('viVPrintf');

typedef ViSPrintfNative = ViStatus Function(
    Pointer<Uint8> buf,
    ViConstString writeFmt,
    Pointer<Uint8> params,
    );
typedef ViSPrintf = int Function(
    Pointer<Uint8> buf,
    ViConstString writeFmt,
    Pointer<Uint8> params,
    );
final ViSPrintf viSPrintf = visaLib.lookupFunction<ViSPrintfNative, ViSPrintf>('viSPrintf');

typedef ViVSPrintfNative = ViStatus Function(
    Pointer<Uint8> buf,
    ViConstString writeFmt,
    ViVAList params,
    );
typedef ViVSPrintf = int Function(
    Pointer<Uint8> buf,
    ViConstString writeFmt,
    ViVAList params,
    );
final ViVSPrintf viVSPrintf = visaLib.lookupFunction<ViVSPrintfNative, ViVSPrintf>('viVSPrintf');

typedef ViScanfNative = ViStatus Function(
    ViSession vi,
    ViConstString readFmt,
    Pointer<Uint8> params,
    );
typedef ViScanf = int Function(
    int vi,
    ViConstString readFmt,
    Pointer<Uint8> params,
    );
final ViScanf viScanf = visaLib.lookupFunction<ViScanfNative, ViScanf>('viScanf');

typedef ViVScanfNative = ViStatus Function(
    ViSession vi,
    ViConstString readFmt,
    ViVAList params,
    );
typedef ViVScanf = int Function(
    int vi,
    ViConstString readFmt,
    ViVAList params,
    );
final ViVScanf viVScanf = visaLib.lookupFunction<ViVScanfNative, ViVScanf>('viVScanf');

typedef ViSScanfNative = ViStatus Function(
    Pointer<Uint8> buf,
    ViConstString readFmt,
    Pointer<Uint8> params,
    );
typedef ViSScanf = int Function(
    Pointer<Uint8> buf,
    ViConstString readFmt,
    Pointer<Uint8> params,
    );
final ViSScanf viSScanf = visaLib.lookupFunction<ViSScanfNative, ViSScanf>('viSScanf');

typedef ViVSScanfNative = ViStatus Function(
    Pointer<Uint8> buf,
    ViConstString readFmt,
    ViVAList params,
    );
typedef ViVSScanf = int Function(
    Pointer<Uint8> buf,
    ViConstString readFmt,
    ViVAList params,
    );
final ViVSScanf viVSScanf = visaLib.lookupFunction<ViVSScanfNative, ViVSScanf>('viVSScanf');

typedef ViQueryfNative = ViStatus Function(
    ViSession vi,
    ViConstString writeFmt,
    ViConstString readFmt,
    Pointer<Uint8> params,
    );
typedef ViQueryf = int Function(
    int vi,
    ViConstString writeFmt,
    ViConstString readFmt,
    Pointer<Uint8> params,
    );
final ViQueryf viQueryf = visaLib.lookupFunction<ViQueryfNative, ViQueryf>('viQueryf');

typedef ViVQueryfNative = ViStatus Function(
    ViSession vi,
    ViConstString writeFmt,
    ViConstString readFmt,
    ViVAList params,
    );
typedef ViVQueryf = int Function(
    int vi,
    ViConstString writeFmt,
    ViConstString readFmt,
    ViVAList params,
    );
final ViVQueryf viVQueryf = visaLib.lookupFunction<ViVQueryfNative, ViVQueryf>('viVQueryf');

// Memory I/O Operations

typedef ViIn8Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Pointer<Uint8> val8,
    );
typedef ViIn8 = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint8> val8,
    );
final ViIn8 viIn8 = visaLib.lookupFunction<ViIn8Native, ViIn8>('viIn8');

typedef ViOut8Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Uint8 val8,
    );
typedef ViOut8 = int Function(
    int vi,
    int space,
    int offset,
    int val8,
    );
final ViOut8 viOut8 = visaLib.lookupFunction<ViOut8Native, ViOut8>('viOut8');

typedef ViIn16Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Pointer<Uint16> val16,
    );
typedef ViIn16 = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint16> val16,
    );
final ViIn16 viIn16 = visaLib.lookupFunction<ViIn16Native, ViIn16>('viIn16');

typedef ViOut16Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Uint16 val16,
    );
typedef ViOut16 = int Function(
    int vi,
    int space,
    int offset,
    int val16,
    );
final ViOut16 viOut16 = visaLib.lookupFunction<ViOut16Native, ViOut16>('viOut16');

typedef ViIn32Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Pointer<Uint32> val32,
    );
typedef ViIn32 = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint32> val32,
    );
final ViIn32 viIn32 = visaLib.lookupFunction<ViIn32Native, ViIn32>('viIn32');

typedef ViOut32Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Uint32 val32,
    );
typedef ViOut32 = int Function(
    int vi,
    int space,
    int offset,
    int val32,
    );
final ViOut32 viOut32 = visaLib.lookupFunction<ViOut32Native, ViOut32>('viOut32');

typedef ViIn64Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Pointer<Uint64> val64,
    );
typedef ViIn64 = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint64> val64,
    );
final ViIn64 viIn64 = visaLib.lookupFunction<ViIn64Native, ViIn64>('viIn64');

typedef ViOut64Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    Uint64 val64,
    );
typedef ViOut64 = int Function(
    int vi,
    int space,
    int offset,
    int val64,
    );
final ViOut64 viOut64 = visaLib.lookupFunction<ViOut64Native, ViOut64>('viOut64');

typedef ViIn8ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Pointer<Uint8> val8,
    );
typedef ViIn8Ex = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint8> val8,
    );
final ViIn8Ex viIn8Ex = visaLib.lookupFunction<ViIn8ExNative, ViIn8Ex>('viIn8Ex');

typedef ViOut8ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Uint8 val8,
    );
typedef ViOut8Ex = int Function(
    int vi,
    int space,
    int offset,
    int val8,
    );
final ViOut8Ex viOut8Ex = visaLib.lookupFunction<ViOut8ExNative, ViOut8Ex>('viOut8Ex');

typedef ViIn16ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Pointer<Uint16> val16,
    );
typedef ViIn16Ex = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint16> val16,
    );
final ViIn16Ex viIn16Ex = visaLib.lookupFunction<ViIn16ExNative, ViIn16Ex>('viIn16Ex');

typedef ViOut16ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Uint16 val16,
    );
typedef ViOut16Ex = int Function(
    int vi,
    int space,
    int offset,
    int val16,
    );
final ViOut16Ex viOut16Ex = visaLib.lookupFunction<ViOut16ExNative, ViOut16Ex>('viOut16Ex');

typedef ViIn32ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Pointer<Uint32> val32,
    );
typedef ViIn32Ex = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint32> val32,
    );
final ViIn32Ex viIn32Ex = visaLib.lookupFunction<ViIn32ExNative, ViIn32Ex>('viIn32Ex');

typedef ViOut32ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Uint32 val32,
    );
typedef ViOut32Ex = int Function(
    int vi,
    int space,
    int offset,
    int val32,
    );
final ViOut32Ex viOut32Ex = visaLib.lookupFunction<ViOut32ExNative, ViOut32Ex>('viOut32Ex');

typedef ViIn64ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Pointer<Uint64> val64,
    );
typedef ViIn64Ex = int Function(
    int vi,
    int space,
    int offset,
    Pointer<Uint64> val64,
    );
final ViIn64Ex viIn64Ex = visaLib.lookupFunction<ViIn64ExNative, ViIn64Ex>('viIn64Ex');

typedef ViOut64ExNative = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress64 offset,
    Uint64 val64,
    );
typedef ViOut64Ex = int Function(
    int vi,
    int space,
    int offset,
    int val64,
    );
final ViOut64Ex viOut64Ex = visaLib.lookupFunction<ViOut64ExNative, ViOut64Ex>('viOut64Ex');

typedef ViMoveIn8Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint8> buf8,
    );
typedef ViMoveIn8 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint8> buf8,
    );
final ViMoveIn8 viMoveIn8 = visaLib.lookupFunction<ViMoveIn8Native, ViMoveIn8>('viMoveIn8');

typedef ViMoveOut8Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint8> buf8,
    );
typedef ViMoveOut8 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint8> buf8,
    );
final ViMoveOut8 viMoveOut8 = visaLib.lookupFunction<ViMoveOut8Native, ViMoveOut8>('viMoveOut8');

typedef ViMoveIn16Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint16> buf16,
    );
typedef ViMoveIn16 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint16> buf16,
    );
final ViMoveIn16 viMoveIn16 = visaLib.lookupFunction<ViMoveIn16Native, ViMoveIn16>('viMoveIn16');

typedef ViMoveOut16Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint16> buf16,
    );
typedef ViMoveOut16 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint16> buf16,
    );
final ViMoveOut16 viMoveOut16 = visaLib.lookupFunction<ViMoveOut16Native, ViMoveOut16>('viMoveOut16');

typedef ViMoveIn32Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint32> buf32,
    );
typedef ViMoveIn32 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint32> buf32,
    );
final ViMoveIn32 viMoveIn32 = visaLib.lookupFunction<ViMoveIn32Native, ViMoveIn32>('viMoveIn32');

typedef ViMoveOut32Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint32> buf32,
    );
typedef ViMoveOut32 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint32> buf32,
    );
final ViMoveOut32 viMoveOut32 = visaLib.lookupFunction<ViMoveOut32Native, ViMoveOut32>('viMoveOut32');

typedef ViMoveIn64Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint64> buf64,
    );
typedef ViMoveIn64 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint64> buf64,
    );
final ViMoveIn64 viMoveIn64 = visaLib.lookupFunction<ViMoveIn64Native, ViMoveIn64>('viMoveIn64');

typedef ViMoveOut64Native = ViStatus Function(
    ViSession vi,
    Uint16 space,
    ViBusAddress offset,
    ViBusSize length,
    Pointer<Uint64> buf64,
    );
typedef ViMoveOut64 = int Function(
    int vi,
    int space,
    int offset,
    int length,
    Pointer<Uint64> buf64,
    );
final ViMoveOut64 viMoveOut64 = visaLib.lookupFunction<ViMoveOut64Native, ViMoveOut64>('viMoveOut64');

typedef ViMoveExNative = ViStatus Function(
    ViSession vi,
    Uint16 srcSpace,
    ViBusAddress64 srcOffset,
    Uint16 srcWidth,
    Uint16 destSpace,
    ViBusAddress64 destOffset,
    Uint16 destWidth,
    ViBusSize srcLength,
    );
typedef ViMoveEx = int Function(
    int vi,
    int srcSpace,
    int srcOffset,
    int srcWidth,
    int destSpace,
    int destOffset,
    int destWidth,
    int srcLength,
    );
final ViMoveEx viMoveEx = visaLib.lookupFunction<ViMoveExNative, ViMoveEx>('viMoveEx');

typedef ViMoveAsyncNative = ViStatus Function(
    ViSession vi,
    Uint16 srcSpace,
    ViBusAddress srcOffset,
    Uint16 srcWidth,
    Uint16 destSpace,
    ViBusAddress destOffset,
    Uint16 destWidth,
    ViBusSize srcLength,
    Pointer<ViJobId> jobId,
    );
typedef ViMoveAsync = int Function(
    int vi,
    int srcSpace,
    int srcOffset,
    int srcWidth,
    int destSpace,
    int destOffset,
    int destWidth,
    int srcLength,
    Pointer<ViJobId> jobId,
    );
final ViMoveAsync viMoveAsync = visaLib.lookupFunction<ViMoveAsyncNative, ViMoveAsync>('viMoveAsync');

typedef ViMoveAsyncExNative = ViStatus Function(
    ViSession vi,
    Uint16 srcSpace,
    ViBusAddress64 srcOffset,
    Uint16 srcWidth,
    Uint16 destSpace,
    ViBusAddress64 destOffset,
    Uint16 destWidth,
    ViBusSize srcLength,
    Pointer<ViJobId> jobId,
    );
typedef ViMoveAsyncEx = int Function(
    int vi,
    int srcSpace,
    int srcOffset,
    int srcWidth,
    int destSpace,
    int destOffset,
    int destWidth,
    int srcLength,
    Pointer<ViJobId> jobId,
    );
final ViMoveAsyncEx viMoveAsyncEx = visaLib.lookupFunction<ViMoveAsyncExNative, ViMoveAsyncEx>('viMoveAsyncEx');

typedef ViMapAddressNative = ViStatus Function(
    ViSession vi,
    Uint16 mapSpace,
    ViBusAddress mapOffset,
    ViBusSize mapSize,
    Uint8 access,
    ViAddr suggested,
    Pointer<ViAddr> address,
    );
typedef ViMapAddress = int Function(
    int vi,
    int mapSpace,
    int mapOffset,
    int mapSize,
    int access,
    ViAddr suggested,
    Pointer<ViAddr> address,
    );
final ViMapAddress viMapAddress = visaLib.lookupFunction<ViMapAddressNative, ViMapAddress>('viMapAddress');

typedef ViUnmapAddressNative = ViStatus Function(ViSession vi);
typedef ViUnmapAddress = int Function(int vi);
final ViUnmapAddress viUnmapAddress = visaLib.lookupFunction<ViUnmapAddressNative, ViUnmapAddress>('viUnmapAddress');

typedef ViMapAddressExNative = ViStatus Function(
    ViSession vi,
    Uint16 mapSpace,
    ViBusAddress64 mapOffset,
    ViBusSize mapSize,
    Uint8 access,
    ViAddr suggested,
    Pointer<ViAddr> address,
    );
typedef ViMapAddressEx = int Function(
    int vi,
    int mapSpace,
    int mapOffset,
    int mapSize,
    int access,
    ViAddr suggested,
    Pointer<ViAddr> address,
    );
final ViMapAddressEx viMapAddressEx = visaLib.lookupFunction<ViMapAddressExNative, ViMapAddressEx>('viMapAddressEx');

typedef ViPeek8Native = Void Function(
    ViSession vi,
    ViAddr address,
    Pointer<Uint8> val8,
    );
typedef ViPeek8 = void Function(
    int vi,
    ViAddr address,
    Pointer<Uint8> val8,
    );
final ViPeek8 viPeek8 = visaLib.lookupFunction<ViPeek8Native, ViPeek8>('viPeek8');

typedef ViPoke8Native = Void Function(
    ViSession vi,
    ViAddr address,
    Uint8 val8,
    );
typedef ViPoke8 = void Function(
    int vi,
    ViAddr address,
    int val8,
    );
final ViPoke8 viPoke8 = visaLib.lookupFunction<ViPoke8Native, ViPoke8>('viPoke8');

typedef ViPeek16Native = Void Function(
    ViSession vi,
    ViAddr address,
    Pointer<Uint16> val16,
    );
typedef ViPeek16 = void Function(
    int vi,
    ViAddr address,
    Pointer<Uint16> val16,
    );
final ViPeek16 viPeek16 = visaLib.lookupFunction<ViPeek16Native, ViPeek16>('viPeek16');

typedef ViPoke16Native = Void Function(
    ViSession vi,
    ViAddr address,
    Uint16 val16,
    );
typedef ViPoke16 = void Function(
    int vi,
    ViAddr address,
    int val16,
    );
final ViPoke16 viPoke16 = visaLib.lookupFunction<ViPoke16Native, ViPoke16>('viPoke16');

typedef ViPeek32Native = Void Function(
    ViSession vi,
    ViAddr address,
    Pointer<Uint32> val32,
    );
typedef ViPeek32 = void Function(
    int vi,
    ViAddr address,
    Pointer<Uint32> val32,
    );
final ViPeek32 viPeek32 = visaLib.lookupFunction<ViPeek32Native, ViPeek32>('viPeek32');

typedef ViPoke32Native = Void Function(
    ViSession vi,
    ViAddr address,
    Uint32 val32,
    );
typedef ViPoke32 = void Function(
    int vi,
    ViAddr address,
    int val32,
    );
final ViPoke32 viPoke32 = visaLib.lookupFunction<ViPoke32Native, ViPoke32>('viPoke32');

typedef ViPeek64Native = Void Function(
    ViSession vi,
    ViAddr address,
    Pointer<Uint64> val64,
    );
typedef ViPeek64 = void Function(
    int vi,
    ViAddr address,
    Pointer<Uint64> val64,
    );
final ViPeek64 viPeek64 = visaLib.lookupFunction<ViPeek64Native, ViPeek64>('viPeek64');

typedef ViPoke64Native = Void Function(
    ViSession vi,
    ViAddr address,
    Uint64 val64,
    );
typedef ViPoke64 = void Function(
    int vi,
    ViAddr address,
    int val64,
    );
final ViPoke64 viPoke64 = visaLib.lookupFunction<ViPoke64Native, ViPoke64>('viPoke64');

typedef ViMemAllocNative = ViStatus Function(
    ViSession vi,
    ViBusSize size,
    Pointer<ViBusAddress> offset,
    );
typedef ViMemAlloc = int Function(
    int vi,
    int size,
    Pointer<ViBusAddress> offset,
    );
final ViMemAlloc viMemAlloc = visaLib.lookupFunction<ViMemAllocNative, ViMemAlloc>('viMemAlloc');

typedef ViMemFreeNative = ViStatus Function(
    ViSession vi,
    ViBusAddress offset,
    );
typedef ViMemFree = int Function(
    int vi,
    int offset,
    );
final ViMemFree viMemFree = visaLib.lookupFunction<ViMemFreeNative, ViMemFree>('viMemFree');

typedef ViMemAllocExNative = ViStatus Function(
    ViSession vi,
    ViBusSize size,
    Pointer<ViBusAddress64> offset,
    );
typedef ViMemAllocEx = int Function(
    int vi,
    int size,
    Pointer<ViBusAddress64> offset,
    );
final ViMemAllocEx viMemAllocEx = visaLib.lookupFunction<ViMemAllocExNative, ViMemAllocEx>('viMemAllocEx');

typedef ViMemFreeExNative = ViStatus Function(
    ViSession vi,
    ViBusAddress64 offset,
    );
typedef ViMemFreeEx = int Function(
    int vi,
    int offset,
    );
final ViMemFreeEx viMemFreeEx = visaLib.lookupFunction<ViMemFreeExNative, ViMemFreeEx>('viMemFreeEx');

typedef ViGpibControlRENative = ViStatus Function(
    ViSession vi,
    Uint16 mode,
    );
typedef ViGpibControlRE = int Function(
    int vi,
    int mode,
    );
final ViGpibControlRE viGpibControlRE = visaLib.lookupFunction<ViGpibControlRENative, ViGpibControlRE>('viGpibControlRE');

typedef ViGpibControlATNNative = ViStatus Function(
    ViSession vi,
    Uint16 mode,
    );
typedef ViGpibControlATN = int Function(
    int vi,
    int mode,
    );
final ViGpibControlATN viGpibControlATN = visaLib.lookupFunction<ViGpibControlATNNative, ViGpibControlATN>('viGpibControlATN');

typedef ViGpibSendIFCNative = ViStatus Function(ViSession vi);
typedef ViGpibSendIFC = int Function(int vi);
final ViGpibSendIFC viGpibSendIFC = visaLib.lookupFunction<ViGpibSendIFCNative, ViGpibSendIFC>('viGpibSendIFC');

typedef ViGpibCommandNative = ViStatus Function(
    ViSession vi,
    Pointer<Uint8> cmd,
    ViUInt32 cnt,
    Pointer<ViUInt32> retCnt,
    );
typedef ViGpibCommand = int Function(
    int vi,
    Pointer<Uint8> cmd,
    int cnt,
    Pointer<ViUInt32> retCnt,
    );
final ViGpibCommand viGpibCommand = visaLib.lookupFunction<ViGpibCommandNative, ViGpibCommand>('viGpibCommand');

typedef ViGpibPassControlNative = ViStatus Function(
    ViSession vi,
    Uint16 primAddr,
    Uint16 secAddr,
    );
typedef ViGpibPassControl = int Function(
    int vi,
    int primAddr,
    int secAddr,
    );
final ViGpibPassControl viGpibPassControl = visaLib.lookupFunction<ViGpibPassControlNative, ViGpibPassControl>('viGpibPassControl');

typedef ViVxiCommandQueryNative = ViStatus Function(
    ViSession vi,
    Uint16 mode,
    ViUInt32 cmd,
    Pointer<ViUInt32> response,
    );
typedef ViVxiCommandQuery = int Function(
    int vi,
    int mode,
    int cmd,
    Pointer<ViUInt32> response,
    );
final ViVxiCommandQuery viVxiCommandQuery = visaLib.lookupFunction<ViVxiCommandQueryNative, ViVxiCommandQuery>('viVxiCommandQuery');

typedef ViAssertUtilSignalNative = ViStatus Function(
    ViSession vi,
    Uint16 line,
    );
typedef ViAssertUtilSignal = int Function(
    int vi,
    int line,
    );
final ViAssertUtilSignal viAssertUtilSignal = visaLib.lookupFunction<ViAssertUtilSignalNative, ViAssertUtilSignal>('viAssertUtilSignal');

typedef ViAssertIntrSignalNative = ViStatus Function(
    ViSession vi,
    Int16 mode,
    ViUInt32 statusID,
    );
typedef ViAssertIntrSignal = int Function(
    int vi,
    int mode,
    int statusID,
    );
final ViAssertIntrSignal viAssertIntrSignal = visaLib.lookupFunction<ViAssertIntrSignalNative, ViAssertIntrSignal>('viAssertIntrSignal');

typedef ViMapTriggerNative = ViStatus Function(
    ViSession vi,
    Int16 trigSrc,
    Int16 trigDest,
    Uint16 mode,
    );
typedef ViMapTrigger = int Function(
    int vi,
    int trigSrc,
    int trigDest,
    int mode,
    );
final ViMapTrigger viMapTrigger = visaLib.lookupFunction<ViMapTriggerNative, ViMapTrigger>('viMapTrigger');

typedef ViUnmapTriggerNative = ViStatus Function(
    ViSession vi,
    Int16 trigSrc,
    Int16 trigDest,
    );
typedef ViUnmapTrigger = int Function(
    int vi,
    int trigSrc,
    int trigDest,
    );
final ViUnmapTrigger viUnmapTrigger = visaLib.lookupFunction<ViUnmapTriggerNative, ViUnmapTrigger>('viUnmapTrigger');

typedef ViUsbControlOutNative = ViStatus Function(
    ViSession vi,
    Int16 bmRequestType,
    Int16 bRequest,
    Uint16 wValue,
    Uint16 wIndex,
    Uint16 wLength,
    Pointer<Uint8> buf,
    );
typedef ViUsbControlOut = int Function(
    int vi,
    int bmRequestType,
    int bRequest,
    int wValue,
    int wIndex,
    int wLength,
    Pointer<Uint8> buf,
    );
final ViUsbControlOut viUsbControlOut = visaLib.lookupFunction<ViUsbControlOutNative, ViUsbControlOut>('viUsbControlOut');

typedef ViUsbControlInNative = ViStatus Function(
    ViSession vi,
    Int16 bmRequestType,
    Int16 bRequest,
    Uint16 wValue,
    Uint16 wIndex,
    Uint16 wLength,
    Pointer<Uint8> buf,
    Pointer<Uint16> retCnt,
    );
typedef ViUsbControlIn = int Function(
    int vi,
    int bmRequestType,
    int bRequest,
    int wValue,
    int wIndex,
    int wLength,
    Pointer<Uint8> buf,
    Pointer<Uint16> retCnt,
    );
final ViUsbControlIn viUsbControlIn = visaLib.lookupFunction<ViUsbControlInNative, ViUsbControlIn>('viUsbControlIn');

typedef ViPxiReserveTriggersNative = ViStatus Function(
    ViSession vi,
    Int16 cnt,
    Pointer<Int16> trigBuses,
    Pointer<Int16> trigLines,
    Pointer<Int16> failureIndex,
    );
typedef ViPxiReserveTriggers = int Function(
    int vi,
    int cnt,
    Pointer<Int16> trigBuses,
    Pointer<Int16> trigLines,
    Pointer<Int16> failureIndex,
    );
final ViPxiReserveTriggers viPxiReserveTriggers = visaLib.lookupFunction<ViPxiReserveTriggersNative, ViPxiReserveTriggers>('viPxiReserveTriggers');
