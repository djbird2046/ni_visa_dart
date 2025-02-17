import '../ffi/ni_visa_ffi.dart';

class VISAStatus implements Exception {
  int code;
  String identifier;
  String message;
  VISAStatus({required this.code, required this.identifier,required this.message});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'identifier': identifier,
      'message': message
    };
  }
}

class VISASuccess extends VISAStatus {
  VISASuccess({required int code, required String identifier, required String message}) : super(code: code, identifier: identifier, message: message);
}

class VISAWarning extends VISAStatus {
  VISAWarning({required int code, required String identifier, required String message}) : super(code: code, identifier: identifier, message: message);
}

class VISAError extends VISAStatus implements Exception {
  VISAError({required int code, required String identifier, required String message}) : super(code: code, identifier: identifier, message: message);
}

/// SUCCESS
final VISASuccess VI_SUCCESS_STATUS = VISASuccess(code: VI_SUCCESS, identifier: "VI_SUCCESS", message: "Operation completed successfully.");
final VISASuccess VI_SUCCESS_EVENT_EN_STATUS = VISASuccess(code: VI_SUCCESS_EVENT_EN, identifier: "VI_SUCCESS_EVENT_EN", message: "Specified event is already enabled for at least one of the specified mechanisms.");
final VISASuccess VI_SUCCESS_EVENT_DIS_STATUS = VISASuccess(code: VI_SUCCESS_EVENT_DIS, identifier: "VI_SUCCESS_EVENT_DIS", message: "Specified event is already disabled for at least one of the specified mechanisms.");
final VISASuccess VI_SUCCESS_QUEUE_EMPTY_STATUS = VISASuccess(code: VI_SUCCESS_QUEUE_EMPTY, identifier: "VI_SUCCESS_QUEUE_EMPTY", message: "Operation completed successfully, but queue was already empty.");
final VISASuccess VI_SUCCESS_TERM_CHAR_STATUS = VISASuccess(code: VI_SUCCESS_TERM_CHAR, identifier: "VI_SUCCESS_TERM_CHAR", message: "The specified termination character was read but no END indicator was received. This completion code is returned regardless of whether the number of bytes read is equal to count. ");
final VISASuccess VI_SUCCESS_MAX_CNT_STATUS = VISASuccess(code: VI_SUCCESS_MAX_CNT, identifier: "VI_SUCCESS_MAX_CNT", message: "The number of bytes read is equal to count. No END indicator was received and no termination character was read. ");
final VISASuccess VI_SUCCESS_DEV_NPRESENT_STATUS = VISASuccess(code: VI_SUCCESS_DEV_NPRESENT, identifier: "VI_SUCCESS_DEV_NPRESENT", message: "The given session reference is invalid. ");
final VISASuccess VI_SUCCESS_TRIG_MAPPED_STATUS = VISASuccess(code: VI_SUCCESS_TRIG_MAPPED, identifier: "VI_SUCCESS_TRIG_MAPPED", message: "The path from trigSrc to trigDest is already mapped.");
final VISASuccess VI_SUCCESS_QUEUE_NEMPTY_STATUS = VISASuccess(code: VI_SUCCESS_QUEUE_NEMPTY, identifier: "VI_SUCCESS_QUEUE_NEMPTY", message: "Wait terminated successfully on receipt of an event notification. There is still at least one more event occurrence of the type specified by inEventType available for this session.");
final VISASuccess VI_SUCCESS_NCHAIN_STATUS = VISASuccess(code: VI_SUCCESS_NCHAIN, identifier: "VI_SUCCESS_NCHAIN", message: "Event handled successfully. Do not invoke any other handlers on this session for this event.");
final VISASuccess VI_SUCCESS_NESTED_SHARED_STATUS = VISASuccess(code: VI_SUCCESS_NESTED_SHARED, identifier: "VI_SUCCESS_NESTED_SHARED", message: "Specified access mode is successfully acquired, and this session has nested shared locks.");
final VISASuccess VI_SUCCESS_NESTED_EXCLUSIVE_STATUS = VISASuccess(code: VI_SUCCESS_NESTED_EXCLUSIVE, identifier: "VI_SUCCESS_NESTED_EXCLUSIVE", message: "Specified access mode is successfully acquired, and this session has nested exclusive locks.");
final VISASuccess VI_SUCCESS_SYNC_STATUS = VISASuccess(code: VI_SUCCESS_SYNC, identifier: "VI_SUCCESS_SYNC", message: "Operation performed synchronously.");

/// WARNING
final VISAWarning VI_WARN_QUEUE_OVERFLOW_WARNING = VISAWarning(code: VI_WARN_QUEUE_OVERFLOW, identifier: "VI_WARN_QUEUE_OVERFLOW", message: "The event returned is valid. One or more events that occurred have not been raised because there was no room available on the queue at the time of their occurrence. This could happen because VI_ATTR_MA X_QUEUE_LENGTH is not set to a large enough value for your application and/or events are coming in faster than you are servicing them.");
final VISAWarning VI_WARN_CONFIG_NLOADED_WARNING = VISAWarning(code: VI_WARN_CONFIG_NLOADED, identifier: "VI_WARN_CONFIG_NLOADED", message: "At least one configured Passport module could not be loaded.");
final VISAWarning VI_WARN_NULL_OBJECT_WARNING = VISAWarning(code: VI_WARN_NULL_OBJECT, identifier: "VI_WARN_NULL_OBJECT", message: "The specified object reference is uninitialized. ");
final VISAWarning VI_WARN_NSUP_ATTR_STATE_WARNING = VISAWarning(code: VI_WARN_NSUP_ATTR_STATE, identifier: "VI_WARN_NSUP_ATTR_STATE", message: "Although the specified attribute state is valid, it is not supported by this implementation.");
final VISAWarning VI_WARN_UNKNOWN_STATUS_WARNING = VISAWarning(code: VI_WARN_UNKNOWN_STATUS, identifier: "VI_WARN_UNKNOWN_STATUS", message: "The status code passed to the operation could not be interpreted.");
final VISAWarning VI_WARN_NSUP_BUF_WARNING = VISAWarning(code: VI_WARN_NSUP_BUF, identifier: "VI_WARN_NSUP_BUF", message: "The specified buffer is not supported.");
final VISAWarning VI_WARN_EXT_FUNC_NIMPL_WARNING = VISAWarning(code: VI_WARN_EXT_FUNC_NIMPL, identifier: "VI_WARN_EXT_FUNC_NIMPL", message: "The operation succeeded, but a lower level driver did not implement the extended functionality.");

/// ERROR
final VISAError VI_ERROR_SYSTEM_ERROR_EXCEPTION = VISAError(code: VI_ERROR_SYSTEM_ERROR, identifier: "VI_ERROR_SYSTEM_ERROR", message: "The VISA system failed to initialize.");
final VISAError VI_ERROR_INV_OBJECT_EXCEPTION = VISAError(code: VI_ERROR_INV_OBJECT, identifier: "VI_ERROR_INV_OBJECT", message: "The given session reference is invalid. ");
final VISAError VI_ERROR_RSRC_LOCKED_EXCEPTION = VISAError(code: VI_ERROR_RSRC_LOCKED, identifier: "VI_ERROR_RSRC_LOCKED", message: "Specified type of lock cannot be obtained because the resource is already locked with a lock type incompatible with the lock requested. ");
final VISAError VI_ERROR_INV_EXPR_EXCEPTION = VISAError(code: VI_ERROR_INV_EXPR, identifier: "VI_ERROR_INV_EXPR", message: "Some implementation-specific configuration file is corrupt or does not exist.");
final VISAError VI_ERROR_RSRC_NFOUND_EXCEPTION = VISAError(code: VI_ERROR_RSRC_NFOUND, identifier: "VI_ERROR_RSRC_NFOUND", message: "Specified expression does not match any devices. ");
final VISAError VI_ERROR_INV_RSRC_NAME_EXCEPTION = VISAError(code: VI_ERROR_INV_RSRC_NAME, identifier: "VI_ERROR_INV_RSRC_NAME", message: "Invalid resource reference specified. Parsing error. ");
final VISAError VI_ERROR_INV_ACC_MODE_EXCEPTION = VISAError(code: VI_ERROR_INV_ACC_MODE, identifier: "VI_ERROR_INV_ACC_MODE", message: "Invalid access mode. ");
final VISAError VI_ERROR_TMO_EXCEPTION = VISAError(code: VI_ERROR_TMO, identifier: "VI_ERROR_TMO", message: "A session to the resource could not be obtained within the specified openTimeout period. ");
final VISAError VI_ERROR_CLOSING_FAILED_EXCEPTION = VISAError(code: VI_ERROR_CLOSING_FAILED, identifier: "VI_ERROR_CLOSING_FAILED", message: "Unable to deallocate the previously allocated data structures corresponding to this session or object reference. ");
final VISAError VI_ERROR_INV_DEGREE_EXCEPTION = VISAError(code: VI_ERROR_INV_DEGREE, identifier: "VI_ERROR_INV_DEGREE", message: "Specified degree is invalid.");
final VISAError VI_ERROR_INV_JOB_ID_EXCEPTION = VISAError(code: VI_ERROR_INV_JOB_ID, identifier: "VI_ERROR_INV_JOB_ID", message: "Specified job identifier is invalid.");
final VISAError VI_ERROR_NSUP_ATTR_EXCEPTION = VISAError(code: VI_ERROR_NSUP_ATTR, identifier: "VI_ERROR_NSUP_ATTR", message: "The specified attribute is not defined by the referenced object.");
final VISAError VI_ERROR_NSUP_ATTR_STATE_EXCEPTION = VISAError(code: VI_ERROR_NSUP_ATTR_STATE, identifier: "VI_ERROR_NSUP_ATTR_STATE", message: "The specified state of the attribute is not valid, or is not supported as defined by the object.");
final VISAError VI_ERROR_ATTR_READONLY_EXCEPTION = VISAError(code: VI_ERROR_ATTR_READONLY, identifier: "VI_ERROR_ATTR_READONLY", message: "The specified attribute is Read Only.");
final VISAError VI_ERROR_INV_LOCK_TYPE_EXCEPTION = VISAError(code: VI_ERROR_INV_LOCK_TYPE, identifier: "VI_ERROR_INV_LOCK_TYPE", message: "Specified lockType is not supported by this resource.");
final VISAError VI_ERROR_INV_ACCESS_KEY_EXCEPTION = VISAError(code: VI_ERROR_INV_ACCESS_KEY, identifier: "VI_ERROR_INV_ACCESS_KEY", message: "The requestedKey value passed in is not a valid accessKey to the specified resource.");
final VISAError VI_ERROR_INV_EVENT_EXCEPTION = VISAError(code: VI_ERROR_INV_EVENT, identifier: "VI_ERROR_INV_EVENT", message: "Specified eventType is not supported by the resource.");
final VISAError VI_ERROR_INV_MECH_EXCEPTION = VISAError(code: VI_ERROR_INV_MECH, identifier: "VI_ERROR_INV_MECH", message: "Invalid mechanism specified for the event.");
final VISAError VI_ERROR_HNDLR_NINSTALLED_EXCEPTION = VISAError(code: VI_ERROR_HNDLR_NINSTALLED, identifier: "VI_ERROR_HNDLR_NINSTALLED", message: "A handler is not currently installed for the specified event. The session cannot be enabled for the VI_HNDLR mode of the callback mechanism.");
final VISAError VI_ERROR_INV_HNDLR_REF_EXCEPTION = VISAError(code: VI_ERROR_INV_HNDLR_REF, identifier: "VI_ERROR_INV_HNDLR_REF", message: "The given handler reference is invalid.");
final VISAError VI_ERROR_INV_CONTEXT_EXCEPTION = VISAError(code: VI_ERROR_INV_CONTEXT, identifier: "VI_ERROR_INV_CONTEXT", message: "Specified event context is invalid.");
final VISAError VI_ERROR_QUEUE_OVERFLOW_EXCEPTION = VISAError(code: VI_ERROR_QUEUE_OVERFLOW, identifier: "VI_ERROR_QUEUE_OVERFLOW", message: "No new event is raised because there is no room available on the queue. This means you have already received all previous events but not closed them. You must call viClose on each event you receive from viWaitOnEvent.");
final VISAError VI_ERROR_NENABLED_EXCEPTION = VISAError(code: VI_ERROR_NENABLED, identifier: "VI_ERROR_NENABLED", message: "The session must be enabled for events of the specified type in order to receive them.");
final VISAError VI_ERROR_ABORT_EXCEPTION = VISAError(code: VI_ERROR_ABORT, identifier: "VI_ERROR_ABORT", message: "The operation was aborted.");
final VISAError VI_ERROR_RAW_WR_PROT_VIOL_EXCEPTION = VISAError(code: VI_ERROR_RAW_WR_PROT_VIOL, identifier: "VI_ERROR_RAW_WR_PROT_VIOL", message: "Violation of raw write protocol occurred during transfer. ");
final VISAError VI_ERROR_RAW_RD_PROT_VIOL_EXCEPTION = VISAError(code: VI_ERROR_RAW_RD_PROT_VIOL, identifier: "VI_ERROR_RAW_RD_PROT_VIOL", message: "Violation of raw read protocol occurred during transfer. ");
final VISAError VI_ERROR_OUTP_PROT_VIOL_EXCEPTION = VISAError(code: VI_ERROR_OUTP_PROT_VIOL, identifier: "VI_ERROR_OUTP_PROT_VIOL", message: "Device reported an output protocol error during transfer.");
final VISAError VI_ERROR_INP_PROT_VIOL_EXCEPTION = VISAError(code: VI_ERROR_INP_PROT_VIOL, identifier: "VI_ERROR_INP_PROT_VIOL", message: "Device reported an input protocol error during transfer. ");
final VISAError VI_ERROR_BERR_EXCEPTION = VISAError(code: VI_ERROR_BERR, identifier: "VI_ERROR_BERR", message: "Bus error occurred during transfer. ");
final VISAError VI_ERROR_IN_PROGRESS_EXCEPTION = VISAError(code: VI_ERROR_IN_PROGRESS, identifier: "VI_ERROR_IN_PROGRESS", message: "Unable to queue the asynchronous operation because there is already an operation in progress.");
final VISAError VI_ERROR_INV_SETUP_EXCEPTION = VISAError(code: VI_ERROR_INV_SETUP, identifier: "VI_ERROR_INV_SETUP", message: "Unable to start operation because setup is invalid. ");
final VISAError VI_ERROR_QUEUE_ERROR_EXCEPTION = VISAError(code: VI_ERROR_QUEUE_ERROR, identifier: "VI_ERROR_QUEUE_ERROR", message: "Unable to queue move operation (usually due to the I/O completion event not being enabled or insufficient space in the session's queue).");
final VISAError VI_ERROR_ALLOC_EXCEPTION = VISAError(code: VI_ERROR_ALLOC, identifier: "VI_ERROR_ALLOC", message: "Insufficient system resources to perform necessary memory allocation. ");
final VISAError VI_ERROR_INV_MASK_EXCEPTION = VISAError(code: VI_ERROR_INV_MASK, identifier: "VI_ERROR_INV_MASK", message: "The specified mask does not specify a valid flush operation on Read/Write resource.");
final VISAError VI_ERROR_IO_EXCEPTION = VISAError(code: VI_ERROR_IO, identifier: "VI_ERROR_IO", message: "An unknown I/O error occurred during transfer. ");
final VISAError VI_ERROR_INV_FMT_EXCEPTION = VISAError(code: VI_ERROR_INV_FMT, identifier: "VI_ERROR_INV_FMT" , message: "A format specifier in the writeFmt string is invalid.");
final VISAError VI_ERROR_NSUP_FMT_EXCEPTION = VISAError(code: VI_ERROR_NSUP_FMT, identifier: "VI_ERROR_NSUP_FMT" , message: "A format specifier in the writeFmt string is not supported.");
final VISAError VI_ERROR_LINE_IN_USE_EXCEPTION = VISAError(code: VI_ERROR_LINE_IN_USE, identifier: "VI_ERROR_LINE_IN_USE" , message: "The specified trigger line is currently in use.");
final VISAError VI_ERROR_LINE_NRESERVED_EXCEPTION = VISAError(code: VI_ERROR_LINE_NRESERVED, identifier: "VI_ERROR_LINE_NRESERVED" , message: "An attempt was made to use a line that was not reserved.");
final VISAError VI_ERROR_NSUP_MODE_EXCEPTION = VISAError(code: VI_ERROR_NSUP_MODE, identifier: "VI_ERROR_NSUP_MODE" , message: "The specified mode is not supported by this VISA implementation.");
final VISAError VI_ERROR_SRQ_NOCCURRED_EXCEPTION = VISAError(code: VI_ERROR_SRQ_NOCCURRED, identifier: "VI_ERROR_SRQ_NOCCURRED" , message: "Service request has not been received for the session.");
final VISAError VI_ERROR_INV_SPACE_EXCEPTION = VISAError(code: VI_ERROR_INV_SPACE, identifier: "VI_ERROR_INV_SPACE" , message: "Invalid address space specified.");
final VISAError VI_ERROR_INV_OFFSET_EXCEPTION = VISAError(code: VI_ERROR_INV_OFFSET, identifier: "VI_ERROR_INV_OFFSET" , message: "Invalid offset specified.");
final VISAError VI_ERROR_INV_WIDTH_EXCEPTION = VISAError(code: VI_ERROR_INV_WIDTH, identifier: "VI_ERROR_INV_WIDTH" , message: "Invalid source or destination width specified.");
final VISAError VI_ERROR_NSUP_OFFSET_EXCEPTION = VISAError(code: VI_ERROR_NSUP_OFFSET, identifier: "VI_ERROR_NSUP_OFFSET" , message: "Specified offset is not accessible from this hardware.");
final VISAError VI_ERROR_NSUP_VAR_WIDTH_EXCEPTION = VISAError(code: VI_ERROR_NSUP_VAR_WIDTH, identifier: "VI_ERROR_NSUP_VAR_WIDTH" , message: "Cannot support source and destination widths that are different.");
final VISAError VI_ERROR_WINDOW_NMAPPED_EXCEPTION = VISAError(code: VI_ERROR_WINDOW_NMAPPED, identifier: "VI_ERROR_WINDOW_NMAPPED", message: "The specified session is not currently mapped.");
final VISAError VI_ERROR_RESP_PENDING_EXCEPTION = VISAError(code: VI_ERROR_RESP_PENDING, identifier: "VI_ERROR_RESP_PENDING" , message: "A previous response is still pending, causing a multiple query error.");
final VISAError VI_ERROR_NLISTENERS_EXCEPTION = VISAError(code: VI_ERROR_NLISTENERS, identifier: "VI_ERROR_NLISTENERS", message: "Access to the remote machine is denied. ");
final VISAError VI_ERROR_NCIC_EXCEPTION = VISAError(code: VI_ERROR_NCIC, identifier: "VI_ERROR_NCIC", message: "Unable to start write operation because setup is invalid (due to attributes being set to an inconsistent state). ");
final VISAError VI_ERROR_NSYS_CNTLR_EXCEPTION = VISAError(code: VI_ERROR_NSYS_CNTLR, identifier: "VI_ERROR_NSYS_CNTLR" , message: "The interface associated with this session is not the system controller.");
final VISAError VI_ERROR_NSUP_OPER_EXCEPTION = VISAError(code: VI_ERROR_NSUP_OPER, identifier: "VI_ERROR_NSUP_OPER", message: "The given sesn does not support this operation. This operation is supported only by a Resource Manager session. ");
final VISAError VI_ERROR_INTR_PENDING_EXCEPTION = VISAError(code: VI_ERROR_INTR_PENDING, identifier: "VI_ERROR_INTR_PENDING" , message: "An interrupt is still pending from a previous call.");
final VISAError VI_ERROR_ASRL_PARITY_EXCEPTION = VISAError(code: VI_ERROR_ASRL_PARITY, identifier: "VI_ERROR_ASRL_PARITY", message: "A parity error occurred during transfer. ");
final VISAError VI_ERROR_ASRL_FRAMING_EXCEPTION = VISAError(code: VI_ERROR_ASRL_FRAMING, identifier: "VI_ERROR_ASRL_FRAMING", message: "A framing error occurred during transfer. ");
final VISAError VI_ERROR_ASRL_OVERRUN_EXCEPTION = VISAError(code: VI_ERROR_ASRL_OVERRUN, identifier: "VI_ERROR_ASRL_OVERRUN", message: "An overrun error occurred during transfer. A character was not read from the hardware before the next character arrived. ");
final VISAError VI_ERROR_TRIG_NMAPPED_EXCEPTION = VISAError(code: VI_ERROR_TRIG_NMAPPED, identifier: "VI_ERROR_TRIG_NMAPPED" , message: "The path from trigSrc to trigDest is not currently mapped.");
final VISAError VI_ERROR_NSUP_ALIGN_OFFSET_EXCEPTION = VISAError(code: VI_ERROR_NSUP_ALIGN_OFFSET, identifier: "VI_ERROR_NSUP_ALIGN_OFFSET" , message: "The specified offset is not properly aligned for the access width of the operation.");
final VISAError VI_ERROR_USER_BUF_EXCEPTION = VISAError(code: VI_ERROR_USER_BUF, identifier: "VI_ERROR_USER_BUF" , message: "A specified user buffer is not valid or cannot be accessed for the required size.");
final VISAError VI_ERROR_RSRC_BUSY_EXCEPTION = VISAError(code: VI_ERROR_RSRC_BUSY, identifier: "VI_ERROR_RSRC_BUSY" , message: "The resource is valid, but VISA cannot currently access it.");
final VISAError VI_ERROR_NSUP_WIDTH_EXCEPTION = VISAError(code: VI_ERROR_NSUP_WIDTH, identifier: "VI_ERROR_NSUP_WIDTH" , message: "Specified width is not supported by this hardware.");
final VISAError VI_ERROR_INV_PARAMETER_EXCEPTION = VISAError(code: VI_ERROR_INV_PARAMETER, identifier: "VI_ERROR_INV_PARAMETER" , message: "The primary or secondary address is invalid.");
final VISAError VI_ERROR_INV_PROT_EXCEPTION = VISAError(code: VI_ERROR_INV_PROT, identifier: "VI_ERROR_INV_PROT" , message: "The protocol specified is invalid.");
final VISAError VI_ERROR_INV_SIZE_EXCEPTION = VISAError(code: VI_ERROR_INV_SIZE, identifier: "VI_ERROR_INV_SIZE" , message: "Invalid size of window specified.");
final VISAError VI_ERROR_WINDOW_MAPPED_EXCEPTION = VISAError(code: VI_ERROR_WINDOW_MAPPED, identifier: "VI_ERROR_WINDOW_MAPPED" , message: "The specified session already contains a mapped window.");
final VISAError VI_ERROR_NIMPL_OPER_EXCEPTION = VISAError(code: VI_ERROR_NIMPL_OPER, identifier: "VI_ERROR_NIMPL_OPER" , message: "The given operation is not implemented.");
final VISAError VI_ERROR_INV_LENGTH_EXCEPTION = VISAError(code: VI_ERROR_INV_LENGTH, identifier: "VI_ERROR_INV_LENGTH" , message: "Invalid length specified.");
final VISAError VI_ERROR_INV_MODE_EXCEPTION = VISAError(code: VI_ERROR_INV_MODE, identifier: "VI_ERROR_INV_MODE" , message: "The value specified by the mode parameter is invalid.");
final VISAError VI_ERROR_SESN_NLOCKED_EXCEPTION = VISAError(code: VI_ERROR_SESN_NLOCKED, identifier: "VI_ERROR_SESN_NLOCKED" , message: "The current session did not have any lock on the resource.");
final VISAError VI_ERROR_MEM_NSHARED_EXCEPTION = VISAError(code: VI_ERROR_MEM_NSHARED, identifier: "VI_ERROR_MEM_NSHARED" , message: "The device does not export any memory.");
final VISAError VI_ERROR_LIBRARY_NFOUND_EXCEPTION = VISAError(code: VI_ERROR_LIBRARY_NFOUND, identifier: "VI_ERROR_LIBRARY_NFOUND" , message: "A code library required by VISA could not be located or loaded.");
final VISAError VI_ERROR_NSUP_INTR_EXCEPTION = VISAError(code: VI_ERROR_NSUP_INTR, identifier: "VI_ERROR_NSUP_INTR" , message: "The interface cannot generate an interrupt on the requested level or with the requested statusID value.");
final VISAError VI_ERROR_INV_LINE_EXCEPTION = VISAError(code: VI_ERROR_INV_LINE, identifier: "VI_ERROR_INV_LINE" , message: "The value specified by the line parameter is invalid.");
final VISAError VI_ERROR_FILE_ACCESS_EXCEPTION = VISAError(code: VI_ERROR_FILE_ACCESS, identifier: "VI_ERROR_FILE_ACCESS" , message: "An error occurred while trying to open the specified file. Possible reasons include an invalid path or lack of access rights.");
final VISAError VI_ERROR_FILE_IO_EXCEPTION = VISAError(code: VI_ERROR_FILE_IO, identifier: "VI_ERROR_FILE_IO" , message: "An error occurred while accessing the specified file.");
final VISAError VI_ERROR_NSUP_LINE_EXCEPTION = VISAError(code: VI_ERROR_NSUP_LINE, identifier: "VI_ERROR_NSUP_LINE" , message: "One of the specified lines (trigSrc or trigDest) is not supported by this VISA implementation.");
final VISAError VI_ERROR_NSUP_MECH_EXCEPTION = VISAError(code: VI_ERROR_NSUP_MECH, identifier: "VI_ERROR_NSUP_MECH", message: "The specified mechanism is not supported for the given eventType.");
final VISAError VI_ERROR_INTF_NUM_NCONFIG_EXCEPTION = VISAError(code: VI_ERROR_INTF_NUM_NCONFIG, identifier: "VI_ERROR_INTF_NUM_NCONFIG", message: "The interface type is valid, but the specified interface number is not configured. ");
final VISAError VI_ERROR_CONN_LOST_EXCEPTION = VISAError(code: VI_ERROR_CONN_LOST, identifier: "VI_ERROR_CONN_LOST", message: "The I/O connection for the given session has been lost. ");
final VISAError VI_ERROR_MACHINE_NAVAIL_EXCEPTION = VISAError(code: VI_ERROR_MACHINE_NAVAIL, identifier: "VI_ERROR_MACHINE_NAVAIL", message: "The remote machine does not exist or is not accepting any connections. If the NI-VISA server is installed and running on the remote machine, it may have an incompatible version or may be listening on a different port. ");
final VISAError VI_ERROR_NPERMISSION_EXCEPTION = VISAError(code: VI_ERROR_NPERMISSION, identifier: "VI_ERROR_NPERMISSION", message: "Access to the remote machine is denied. ");

VISAStatus getVISAStatus(int status) {
  switch (status) {
    /// SUCCESS
    case VI_SUCCESS: return VI_SUCCESS_STATUS;
    case VI_SUCCESS_EVENT_EN: return VI_SUCCESS_EVENT_EN_STATUS;
    case VI_SUCCESS_EVENT_DIS: return VI_SUCCESS_EVENT_DIS_STATUS;
    case VI_SUCCESS_QUEUE_EMPTY: return VI_SUCCESS_QUEUE_EMPTY_STATUS;
    case VI_SUCCESS_TERM_CHAR: return VI_SUCCESS_TERM_CHAR_STATUS;
    case VI_SUCCESS_MAX_CNT: return VI_SUCCESS_MAX_CNT_STATUS;
    case VI_SUCCESS_DEV_NPRESENT: return VI_SUCCESS_DEV_NPRESENT_STATUS;
    case VI_SUCCESS_TRIG_MAPPED: return VI_SUCCESS_TRIG_MAPPED_STATUS;
    case VI_SUCCESS_QUEUE_NEMPTY: return VI_SUCCESS_QUEUE_NEMPTY_STATUS;
    case VI_SUCCESS_NCHAIN: return VI_SUCCESS_NCHAIN_STATUS;
    case VI_SUCCESS_NESTED_SHARED: return VI_SUCCESS_NESTED_SHARED_STATUS;
    case VI_SUCCESS_NESTED_EXCLUSIVE: return VI_SUCCESS_NESTED_EXCLUSIVE_STATUS;
    case VI_SUCCESS_SYNC: return VI_SUCCESS_SYNC_STATUS;
    /// WARNING
    case VI_WARN_QUEUE_OVERFLOW: return VI_WARN_QUEUE_OVERFLOW_WARNING;
    case VI_WARN_CONFIG_NLOADED: return VI_WARN_CONFIG_NLOADED_WARNING;
    case VI_WARN_NULL_OBJECT: return VI_WARN_NULL_OBJECT_WARNING;
    case VI_WARN_NSUP_ATTR_STATE: return VI_WARN_NSUP_ATTR_STATE_WARNING;
    case VI_WARN_UNKNOWN_STATUS: return VI_WARN_UNKNOWN_STATUS_WARNING;
    case VI_WARN_NSUP_BUF: return VI_WARN_NSUP_BUF_WARNING;
    case VI_WARN_EXT_FUNC_NIMPL: return VI_WARN_EXT_FUNC_NIMPL_WARNING;
    /// ERROR
    case VI_ERROR_SYSTEM_ERROR: return VI_ERROR_SYSTEM_ERROR_EXCEPTION;
    case VI_ERROR_INV_OBJECT: return VI_ERROR_INV_OBJECT_EXCEPTION;
    case VI_ERROR_RSRC_LOCKED: return VI_ERROR_RSRC_LOCKED_EXCEPTION;
    case VI_ERROR_INV_EXPR: return VI_ERROR_INV_EXPR_EXCEPTION;
    case VI_ERROR_RSRC_NFOUND: return VI_ERROR_RSRC_NFOUND_EXCEPTION;
    case VI_ERROR_INV_RSRC_NAME: return VI_ERROR_INV_RSRC_NAME_EXCEPTION;
    case VI_ERROR_INV_ACC_MODE: return VI_ERROR_INV_ACC_MODE_EXCEPTION;
    case VI_ERROR_TMO: return VI_ERROR_TMO_EXCEPTION;
    case VI_ERROR_CLOSING_FAILED: return VI_ERROR_CLOSING_FAILED_EXCEPTION;
    case VI_ERROR_INV_DEGREE: return VI_ERROR_INV_DEGREE_EXCEPTION;
    case VI_ERROR_INV_JOB_ID: return VI_ERROR_INV_JOB_ID_EXCEPTION;
    case VI_ERROR_NSUP_ATTR: return VI_ERROR_NSUP_ATTR_EXCEPTION;
    case VI_ERROR_NSUP_ATTR_STATE: return VI_ERROR_NSUP_ATTR_STATE_EXCEPTION;
    case VI_ERROR_ATTR_READONLY: return VI_ERROR_ATTR_READONLY_EXCEPTION;
    case VI_ERROR_INV_LOCK_TYPE: return VI_ERROR_INV_LOCK_TYPE_EXCEPTION;
    case VI_ERROR_INV_ACCESS_KEY: return VI_ERROR_INV_ACCESS_KEY_EXCEPTION;
    case VI_ERROR_INV_EVENT: return VI_ERROR_INV_EVENT_EXCEPTION;
    case VI_ERROR_INV_MECH: return VI_ERROR_INV_MECH_EXCEPTION;
    case VI_ERROR_HNDLR_NINSTALLED: return VI_ERROR_HNDLR_NINSTALLED_EXCEPTION;
    case VI_ERROR_INV_HNDLR_REF: return VI_ERROR_INV_HNDLR_REF_EXCEPTION;
    case VI_ERROR_INV_CONTEXT: return VI_ERROR_INV_CONTEXT_EXCEPTION;
    case VI_ERROR_QUEUE_OVERFLOW: return VI_ERROR_QUEUE_OVERFLOW_EXCEPTION;
    case VI_ERROR_NENABLED: return VI_ERROR_NENABLED_EXCEPTION;
    case VI_ERROR_ABORT: return VI_ERROR_ABORT_EXCEPTION;
    case VI_ERROR_RAW_WR_PROT_VIOL: return VI_ERROR_RAW_WR_PROT_VIOL_EXCEPTION;
    case VI_ERROR_RAW_RD_PROT_VIOL: return VI_ERROR_RAW_RD_PROT_VIOL_EXCEPTION;
    case VI_ERROR_OUTP_PROT_VIOL: return VI_ERROR_OUTP_PROT_VIOL_EXCEPTION;
    case VI_ERROR_INP_PROT_VIOL: return VI_ERROR_INP_PROT_VIOL_EXCEPTION;
    case VI_ERROR_BERR: return VI_ERROR_BERR_EXCEPTION;
    case VI_ERROR_IN_PROGRESS: return VI_ERROR_IN_PROGRESS_EXCEPTION;
    case VI_ERROR_INV_SETUP: return VI_ERROR_INV_SETUP_EXCEPTION;
    case VI_ERROR_QUEUE_ERROR: return VI_ERROR_QUEUE_ERROR_EXCEPTION;
    case VI_ERROR_ALLOC: return VI_ERROR_ALLOC_EXCEPTION;
    case VI_ERROR_INV_MASK: return VI_ERROR_INV_MASK_EXCEPTION;
    case VI_ERROR_IO: return VI_ERROR_IO_EXCEPTION;
    case VI_ERROR_INV_FMT: return VI_ERROR_INV_FMT_EXCEPTION;
    case VI_ERROR_NSUP_FMT: return VI_ERROR_NSUP_FMT_EXCEPTION;
    case VI_ERROR_LINE_IN_USE: return VI_ERROR_LINE_IN_USE_EXCEPTION;
    case VI_ERROR_LINE_NRESERVED: return VI_ERROR_LINE_NRESERVED_EXCEPTION;
    case VI_ERROR_NSUP_MODE: return VI_ERROR_NSUP_MODE_EXCEPTION;
    case VI_ERROR_SRQ_NOCCURRED: return VI_ERROR_SRQ_NOCCURRED_EXCEPTION;
    case VI_ERROR_INV_SPACE: return VI_ERROR_INV_SPACE_EXCEPTION;
    case VI_ERROR_INV_OFFSET: return VI_ERROR_INV_OFFSET_EXCEPTION;
    case VI_ERROR_INV_WIDTH: return VI_ERROR_INV_WIDTH_EXCEPTION;
    case VI_ERROR_NSUP_OFFSET: return VI_ERROR_NSUP_OFFSET_EXCEPTION;
    case VI_ERROR_NSUP_VAR_WIDTH: return VI_ERROR_NSUP_VAR_WIDTH_EXCEPTION;
    case VI_ERROR_WINDOW_NMAPPED: return VI_ERROR_WINDOW_NMAPPED_EXCEPTION;
    case VI_ERROR_RESP_PENDING: return VI_ERROR_RESP_PENDING_EXCEPTION;
    case VI_ERROR_NLISTENERS: return VI_ERROR_NLISTENERS_EXCEPTION;
    case VI_ERROR_NCIC: return VI_ERROR_NCIC_EXCEPTION;
    case VI_ERROR_NSYS_CNTLR: return VI_ERROR_NSYS_CNTLR_EXCEPTION;
    case VI_ERROR_NSUP_OPER: return VI_ERROR_NSUP_OPER_EXCEPTION;
    case VI_ERROR_INTR_PENDING: return VI_ERROR_INTR_PENDING_EXCEPTION;
    case VI_ERROR_ASRL_PARITY: return VI_ERROR_ASRL_PARITY_EXCEPTION;
    case VI_ERROR_ASRL_FRAMING: return VI_ERROR_ASRL_FRAMING_EXCEPTION;
    case VI_ERROR_ASRL_OVERRUN: return VI_ERROR_ASRL_OVERRUN_EXCEPTION;
    case VI_ERROR_TRIG_NMAPPED: return VI_ERROR_TRIG_NMAPPED_EXCEPTION;
    case VI_ERROR_NSUP_ALIGN_OFFSET: return VI_ERROR_NSUP_ALIGN_OFFSET_EXCEPTION;
    case VI_ERROR_USER_BUF: return VI_ERROR_USER_BUF_EXCEPTION;
    case VI_ERROR_RSRC_BUSY: return VI_ERROR_RSRC_BUSY_EXCEPTION;
    case VI_ERROR_NSUP_WIDTH: return VI_ERROR_NSUP_WIDTH_EXCEPTION;
    case VI_ERROR_INV_PARAMETER: return VI_ERROR_INV_PARAMETER_EXCEPTION;
    case VI_ERROR_INV_PROT: return VI_ERROR_INV_PROT_EXCEPTION;
    case VI_ERROR_INV_SIZE: return VI_ERROR_INV_SIZE_EXCEPTION;
    case VI_ERROR_WINDOW_MAPPED: return VI_ERROR_WINDOW_MAPPED_EXCEPTION;
    case VI_ERROR_NIMPL_OPER: return VI_ERROR_NIMPL_OPER_EXCEPTION;
    case VI_ERROR_INV_LENGTH: return VI_ERROR_INV_LENGTH_EXCEPTION;
    case VI_ERROR_INV_MODE: return VI_ERROR_INV_MODE_EXCEPTION;
    case VI_ERROR_SESN_NLOCKED: return VI_ERROR_SESN_NLOCKED_EXCEPTION;
    case VI_ERROR_MEM_NSHARED: return VI_ERROR_MEM_NSHARED_EXCEPTION;
    case VI_ERROR_LIBRARY_NFOUND: return VI_ERROR_LIBRARY_NFOUND_EXCEPTION;
    case VI_ERROR_NSUP_INTR: return VI_ERROR_NSUP_INTR_EXCEPTION;
    case VI_ERROR_INV_LINE: return VI_ERROR_INV_LINE_EXCEPTION;
    case VI_ERROR_FILE_ACCESS: return VI_ERROR_FILE_ACCESS_EXCEPTION;
    case VI_ERROR_FILE_IO: return VI_ERROR_FILE_IO_EXCEPTION;
    case VI_ERROR_NSUP_LINE: return VI_ERROR_NSUP_LINE_EXCEPTION;
    case VI_ERROR_NSUP_MECH: return VI_ERROR_NSUP_MECH_EXCEPTION;
    case VI_ERROR_INTF_NUM_NCONFIG: return VI_ERROR_INTF_NUM_NCONFIG_EXCEPTION;
    case VI_ERROR_CONN_LOST: return VI_ERROR_CONN_LOST_EXCEPTION;
    case VI_ERROR_MACHINE_NAVAIL: return VI_ERROR_MACHINE_NAVAIL_EXCEPTION;
    case VI_ERROR_NPERMISSION: return VI_ERROR_NPERMISSION_EXCEPTION;

    default: return VISAError(code: status, identifier: "UNKNOWN", message: "Unknown error");
  }
}

