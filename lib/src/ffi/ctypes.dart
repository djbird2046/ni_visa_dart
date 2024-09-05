import 'dart:ffi';
import 'package:ffi/ffi.dart';

/*= from visa.h =================================*/

// Basic type definitions
typedef ViObject = Uint32;
typedef ViUInt32 = Uint32;
typedef ViUInt64 = Uint64;
typedef ViStatus = Uint32;
typedef ViSession = Uint32;
typedef ViAddr = Pointer<Void>;
typedef ViChar = Utf8;
typedef ViFindList = Uint32;
typedef ViConstRsrc = Pointer<Utf8>;
typedef ViAttr = Uint32;
typedef ViEvent = Uint32;

// Only support 64bit
typedef ViBusAddress = Uint64;
typedef ViBusSize = Uint64;
typedef ViAttrState = Uint64;

// Pointer type definitions
typedef ViPEvent = Pointer<ViObject>;
typedef ViPFindList = Pointer<ViObject>;

typedef ViBusAddress64 = Uint64;
typedef ViPBusAddress64 = Pointer<ViBusAddress64>;

typedef ViEventType = Uint32;
typedef ViPEventType = Pointer<ViEventType>;
typedef ViAEventType = Pointer<ViEventType>;

typedef ViPAttrState = Pointer<Void>;
typedef ViPAttr = Pointer<Uint32>;
typedef ViAAttr = Pointer<Uint32>;

typedef ViString = ViPChar;
typedef ViConstString = Pointer<ViChar>;
typedef ViPString = ViPChar;

typedef ViKeyId = ViString;
typedef ViConstKeyId = ViConstString;
typedef ViPKeyId = ViPString;

typedef ViJobId = Uint32;
typedef ViPJobId = Pointer<ViJobId>;

typedef ViAccessMode = Uint32;
typedef ViPAccessMode = Pointer<ViAccessMode>;

typedef ViPBusAddress = Pointer<ViBusAddress>;

typedef ViEventFilter = Uint32;

// VarArgs type definition
typedef ViVAList = Pointer<Void>;

// Handler function type definition
typedef ViHndlr = Pointer<NativeFunction<ViStatus Function(ViSession vi, ViEventType eventType, ViObject event, ViAddr userHandle)>>;

/*= from visatype.h =================================*/

typedef ViInt64 = Int64;

typedef ViPUInt64 = Pointer<Uint64>;
typedef ViAUInt64 = Pointer<Uint64>;
typedef ViPInt64 = Pointer<Int64>;
typedef ViAInt64 = Pointer<Int64>;

typedef ViInt32 = Int32;

typedef ViPUInt32 = Pointer<Uint32>;
typedef ViAUInt32 = Pointer<Uint32>;
typedef ViPInt32 = Pointer<Int32>;
typedef ViAInt32 = Pointer<Int32>;

typedef ViUInt16 = Uint16;
typedef ViPUInt16 = Pointer<Uint16>;
typedef ViAUInt16 = Pointer<Uint16>;

typedef ViInt16 = Int16;
typedef ViPInt16 = Pointer<Int16>;
typedef ViAInt16 = Pointer<Int16>;

typedef ViUInt8 = Uint8;
typedef ViPUInt8 = Pointer<Uint8>;
typedef ViAUInt8 = Pointer<Uint8>;

typedef ViInt8 = Int8;
typedef ViPInt8 = Pointer<Int8>;
typedef ViAInt8 = Pointer<Int8>;

typedef ViPChar = Pointer<Utf8>;
typedef ViAChar = Pointer<Utf8>;

typedef ViByte = Uint8;
typedef ViPByte = Pointer<Uint8>;
typedef ViAByte = Pointer<Uint8>;

typedef ViPAddr = Pointer<ViAddr>;
typedef ViAAddr = Pointer<ViAddr>;

typedef ViReal32 = Float;
typedef ViPReal32 = Pointer<Float>;
typedef ViAReal32 = Pointer<Float>;

typedef ViReal64 = Double;
typedef ViPReal64 = Pointer<Double>;
typedef ViAReal64 = Pointer<Double>;

typedef ViBuf = Pointer<Utf8>;
typedef ViConstBuf = Pointer<Utf8>;
typedef ViPBuf = Pointer<Uint8>;
typedef ViABuf = Pointer<ViPByte>;

typedef ViAString = Pointer<ViPChar>;

typedef ViRsrc = ViString;
typedef ViPRsrc = ViRsrc;
typedef ViARsrc = Pointer<ViRsrc>;

typedef ViBoolean = Uint16;
typedef ViPBoolean = Pointer<ViBoolean>;
typedef ViABoolean = Pointer<ViPBoolean>;

typedef ViPStatus = Pointer<ViStatus>;
typedef ViAStatus = Pointer<ViPStatus>;

typedef ViVersion = Uint32;
typedef ViPVersion = Pointer<ViVersion>;
typedef ViAVersion = Pointer<ViPVersion>;

typedef ViPObject = Pointer<Uint32>;
typedef ViAObject = Pointer<ViPObject>;

typedef ViPSession = Pointer<Uint32>;
typedef ViASession = Pointer<ViPSession>;
