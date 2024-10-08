import 'constant.dart';
import 'model.dart';

/// SUCCESS but not good
final VISAException VI_SUCCESS_DEV_NPRESENT_EXCEPTION = VISAException(code: VI_SUCCESS_DEV_NPRESENT, identifier: "VI_SUCCESS_DEV_NPRESENT", message: "The given session reference is invalid. ");
final VISAException VI_SUCCESS_TERM_CHAR_EXCEPTION = VISAException(code: VI_SUCCESS_TERM_CHAR, identifier: "VI_SUCCESS_TERM_CHAR", message: "The specified termination character was read but no END indicator was received. This completion code is returned regardless of whether the number of bytes read is equal to count. ");
final VISAException VI_SUCCESS_MAX_CNT_EXCEPTION = VISAException(code: VI_SUCCESS_MAX_CNT, identifier: "VI_SUCCESS_MAX_CNT", message: "The number of bytes read is equal to count. No END indicator was received and no termination character was read. ");
final VISAException VI_WARN_EXT_FUNC_NIMPL_EXCEPTION = VISAException(code: VI_WARN_EXT_FUNC_NIMPL, identifier: "VI_WARN_EXT_FUNC_NIMPL", message: "The operation succeeded, but a lower level driver did not implement the extended functionality.");
final VISAException VI_SUCCESS_NESTED_EXCLUSIVE_EXCEPTION = VISAException(code: VI_SUCCESS_NESTED_EXCLUSIVE, identifier: "VI_SUCCESS_NESTED_EXCLUSIVE", message: "Specified access mode is successfully acquired, and this session has nested exclusive locks.");
final VISAException VI_SUCCESS_NESTED_SHARED_EXCEPTION = VISAException(code: VI_SUCCESS_NESTED_SHARED, identifier: "VI_SUCCESS_NESTED_SHARED", message: "Specified access mode is successfully acquired, and this session has nested shared locks.");
final VISAException VI_SUCCESS_EVENT_EN_EXCEPTION = VISAException(code: VI_SUCCESS_EVENT_EN, identifier: "VI_SUCCESS_EVENT_EN", message: "Specified event is already enabled for at least one of the specified mechanisms.");
final VISAException VI_SUCCESS_EVENT_DIS_EXCEPTION = VISAException(code: VI_SUCCESS_EVENT_DIS, identifier: "VI_SUCCESS_EVENT_DIS", message: "Specified event is already disabled for at least one of the specified mechanisms.");
final VISAException VI_SUCCESS_QUEUE_EMPTY_EXCEPTION = VISAException(code: VI_SUCCESS_EVENT_DIS, identifier: "VI_SUCCESS_EVENT_DIS", message: "Operation completed successfully, but queue was already empty.");
/// WARNING
final VISAException VI_WARN_CONFIG_NLOADED_EXCEPTION = VISAException(code: VI_WARN_CONFIG_NLOADED, identifier: "VI_WARN_CONFIG_NLOADED", message: "At least one configured Passport module could not be loaded.");
final VISAException VI_WARN_NULL_OBJECT_EXCEPTION = VISAException(code: VI_WARN_NULL_OBJECT, identifier: "VI_WARN_NULL_OBJECT", message: "The specified object reference is uninitialized. ");
final VISAException VI_WARN_NSUP_ATTR_STATE_EXCEPTION = VISAException(code: VI_WARN_NSUP_ATTR_STATE, identifier: "VI_WARN_NSUP_ATTR_STATE", message: "Although the specified attribute state is valid, it is not supported by this implementation.");
final VISAException VI_WARN_UNKNOWN_STATUS_EXCEPTION = VISAException(code: VI_WARN_UNKNOWN_STATUS, identifier: "VI_WARN_UNKNOWN_STATUS", message: "The status code passed to the operation could not be interpreted.");
/// ERROR
final VISAException VI_ERROR_SYSTEM_ERROR_EXCEPTION = VISAException(code: VI_ERROR_SYSTEM_ERROR, identifier: "VI_ERROR_SYSTEM_ERROR", message: "The VISA system failed to initialize.");
final VISAException VI_ERROR_ALLOC_EXCEPTION = VISAException(code: VI_ERROR_ALLOC, identifier: "VI_ERROR_ALLOC", message: "Insufficient system resources to perform necessary memory allocation. ");
final VISAException VI_ERROR_INV_SETUP_EXCEPTION = VISAException(code: VI_ERROR_INV_SETUP, identifier: "VI_ERROR_INV_SETUP", message: "Unable to start operation because setup is invalid. ");
final VISAException VI_ERROR_LIBRARY_NFOUND_EXCEPTION = VISAException(code: VI_ERROR_LIBRARY_NFOUND, identifier: "VI_ERROR_LIBRARY_NFOUND", message: "A code library required by VISA could not be located or loaded.");
final VISAException VI_ERROR_INV_OBJECT_EXCEPTION = VISAException(code: VI_ERROR_INV_OBJECT, identifier: "VI_ERROR_INV_OBJECT", message: "The given session reference is invalid. ");
final VISAException VI_ERROR_NSUP_OPER_EXCEPTION = VISAException(code: VI_ERROR_NSUP_OPER, identifier: "VI_ERROR_NSUP_OPER", message: "The given sesn does not support this operation. This operation is supported only by a Resource Manager session. ");
final VISAException VI_ERROR_INV_EXPR_EXCEPTION = VISAException(code: VI_ERROR_INV_EXPR, identifier: "VI_ERROR_INV_EXPR", message: "Some implementation-specific configuration file is corrupt or does not exist.");
final VISAException VI_ERROR_RSRC_NFOUND_EXCEPTION = VISAException(code: VI_ERROR_RSRC_NFOUND, identifier: "VI_ERROR_RSRC_NFOUND", message: "Specified expression does not match any devices. ");
final VISAException VI_ERROR_INV_RSRC_NAME_EXCEPTION = VISAException(code: VI_ERROR_INV_RSRC_NAME, identifier: "VI_ERROR_INV_RSRC_NAME", message: "Invalid resource reference specified. Parsing error. ");
final VISAException VI_ERROR_INV_ACC_MODE_EXCEPTION = VISAException(code: VI_ERROR_INV_ACC_MODE, identifier: "VI_ERROR_INV_ACC_MODE", message: "Invalid access mode. ");
final VISAException VI_ERROR_RSRC_BUSY_EXCEPTION = VISAException(code: VI_ERROR_RSRC_BUSY, identifier: "VI_ERROR_RSRC_BUSY", message: "The resource is valid, but VISA cannot currently access it. ");
final VISAException VI_ERROR_RSRC_LOCKED_EXCEPTION = VISAException(code: VI_ERROR_RSRC_LOCKED, identifier: "VI_ERROR_RSRC_LOCKED", message: "Specified type of lock cannot be obtained because the resource is already locked with a lock type incompatible with the lock requested. ");
final VISAException VI_ERROR_TMO_EXCEPTION = VISAException(code: VI_ERROR_TMO, identifier: "VI_ERROR_TMO", message: "A session to the resource could not be obtained within the specified openTimeout period. ");
final VISAException VI_ERROR_INTF_NUM_NCONFIG_EXCEPTION = VISAException(code: VI_ERROR_INTF_NUM_NCONFIG, identifier: "VI_ERROR_INTF_NUM_NCONFIG", message: "The interface type is valid, but the specified interface number is not configured. ");
final VISAException VI_ERROR_MACHINE_NAVAIL_EXCEPTION = VISAException(code: VI_ERROR_MACHINE_NAVAIL, identifier: "VI_ERROR_MACHINE_NAVAIL", message: "The remote machine does not exist or is not accepting any connections. If the NI-VISA server is installed and running on the remote machine, it may have an incompatible version or may be listening on a different port. ");
final VISAException VI_ERROR_NPERMISSION_EXCEPTION = VISAException(code: VI_ERROR_NPERMISSION, identifier: "VI_ERROR_NPERMISSION", message: "Access to the remote machine is denied. ");
final VISAException VI_ERROR_RAW_WR_PROT_VIOL_EXCEPTION = VISAException(code: VI_ERROR_RAW_WR_PROT_VIOL, identifier: "VI_ERROR_RAW_WR_PROT_VIOL", message: "Violation of raw write protocol occurred during transfer. ");
final VISAException VI_ERROR_RAW_RD_PROT_VIOL_EXCEPTION = VISAException(code: VI_ERROR_RAW_RD_PROT_VIOL, identifier: "VI_ERROR_RAW_RD_PROT_VIOL", message: "Violation of raw read protocol occurred during transfer. ");
final VISAException VI_ERROR_INP_PROT_VIOL_EXCEPTION = VISAException(code: VI_ERROR_INP_PROT_VIOL, identifier: "VI_ERROR_INP_PROT_VIOL", message: "Device reported an input protocol error during transfer. ");
final VISAException VI_ERROR_BERR_EXCEPTION = VISAException(code: VI_ERROR_BERR, identifier: "VI_ERROR_BERR", message: "Bus error occurred during transfer. ");
final VISAException VI_ERROR_NCIC_EXCEPTION = VISAException(code: VI_ERROR_NCIC, identifier: "VI_ERROR_NCIC", message: "Unable to start write operation because setup is invalid (due to attributes being set to an inconsistent state). ");
final VISAException VI_ERROR_NLISTENERS_EXCEPTION = VISAException(code: VI_ERROR_NLISTENERS, identifier: "VI_ERROR_NLISTENERS", message: "Access to the remote machine is denied. ");
final VISAException VI_ERROR_IO_EXCEPTION = VISAException(code: VI_ERROR_IO, identifier: "VI_ERROR_IO", message: "An unknown I/O error occurred during transfer. ");
final VISAException VI_ERROR_CONN_LOST_EXCEPTION = VISAException(code: VI_ERROR_CONN_LOST, identifier: "VI_ERROR_CONN_LOST", message: "The I/O connection for the given session has been lost. ");
final VISAException VI_ERROR_ASRL_PARITY_EXCEPTION = VISAException(code: VI_ERROR_ASRL_PARITY, identifier: "VI_ERROR_ASRL_PARITY", message: "A parity error occurred during transfer. ");
final VISAException VI_ERROR_ASRL_FRAMING_EXCEPTION = VISAException(code: VI_ERROR_ASRL_FRAMING, identifier: "VI_ERROR_ASRL_FRAMING", message: "A framing error occurred during transfer. ");
final VISAException VI_ERROR_ASRL_OVERRUN_EXCEPTION = VISAException(code: VI_ERROR_ASRL_OVERRUN, identifier: "VI_ERROR_ASRL_OVERRUN", message: "An overrun error occurred during transfer. A character was not read from the hardware before the next character arrived. ");
final VISAException VI_ERROR_CLOSING_FAILED_EXCEPTION = VISAException(code: VI_ERROR_CLOSING_FAILED, identifier: "VI_ERROR_CLOSING_FAILED", message: "Unable to deallocate the previously allocated data structures corresponding to this session or object reference. ");
final VISAException VI_ERROR_NSUP_ATTR_EXCEPTION = VISAException(code: VI_ERROR_NSUP_ATTR, identifier: "VI_ERROR_NSUP_ATTR", message: "The specified attribute is not defined by the referenced object.");
final VISAException VI_ERROR_NSUP_ATTR_STATE_EXCEPTION = VISAException(code: VI_ERROR_NSUP_ATTR_STATE, identifier: "VI_ERROR_NSUP_ATTR_STATE", message: "The specified state of the attribute is not valid, or is not supported as defined by the object.");
final VISAException VI_ERROR_ATTR_READONLY_EXCEPTION = VISAException(code: VI_ERROR_ATTR_READONLY, identifier: "VI_ERROR_ATTR_READONLY", message: "The specified attribute is Read Only.");
final VISAException VI_ERROR_INV_JOB_ID_EXCEPTION = VISAException(code: VI_ERROR_INV_JOB_ID, identifier: "VI_ERROR_INV_JOB_ID", message: "Specified job identifier is invalid.");
final VISAException VI_ERROR_INV_DEGREE_EXCEPTION = VISAException(code: VI_ERROR_INV_DEGREE, identifier: "VI_ERROR_INV_DEGREE", message: "Specified degree is invalid.");
final VISAException VI_ERROR_INV_LOCK_TYPE_EXCEPTION = VISAException(code: VI_ERROR_INV_LOCK_TYPE, identifier: "VI_ERROR_INV_LOCK_TYPE", message: "Specified lockType is not supported by this resource.");
final VISAException VI_ERROR_INV_ACCESS_KEY_EXCEPTION = VISAException(code: VI_ERROR_INV_ACCESS_KEY, identifier: "VI_ERROR_INV_ACCESS_KEY", message: "The requestedKey value passed in is not a valid accessKey to the specified resource.");
final VISAException VI_ERROR_WINDOW_NMAPPED_EXCEPTION = VISAException(code: VI_ERROR_WINDOW_NMAPPED, identifier: "VI_ERROR_WINDOW_NMAPPED", message: "The specified session is not currently mapped.");
final VISAException VI_ERROR_INV_EVENT_EXCEPTION = VISAException(code: VI_ERROR_INV_EVENT, identifier: "VI_ERROR_INV_EVENT", message: "Specified eventType is not supported by the resource.");
final VISAException VI_ERROR_INV_MECH_EXCEPTION = VISAException(code: VI_ERROR_INV_MECH, identifier: "VI_ERROR_INV_MECH", message: "Invalid mechanism specified for the event.");
final VISAException VI_ERROR_INV_CONTEXT_EXCEPTION = VISAException(code: VI_ERROR_INV_CONTEXT, identifier: "VI_ERROR_INV_CONTEXT", message: "Specified event context is invalid.");
final VISAException VI_ERROR_HNDLR_NINSTALLED_EXCEPTION = VISAException(code: VI_ERROR_HNDLR_NINSTALLED, identifier: "VI_ERROR_HNDLR_NINSTALLED", message: "A handler is not currently installed for the specified event. The session cannot be enabled for the VI_HNDLR mode of the callback mechanism.");
final VISAException VI_ERROR_NSUP_MECH_EXCEPTION = VISAException(code: VI_ERROR_NSUP_MECH, identifier: "VI_ERROR_NSUP_MECH", message: "The specified mechanism is not supported for the given eventType.");
final VISAException VI_ERROR_NENABLED_EXCEPTION = VISAException(code: VI_ERROR_NENABLED, identifier: "VI_ERROR_NENABLED", message: "The session must be enabled for events of the specified type in order to receive them.");
final VISAException VI_ERROR_QUEUE_OVERFLOW_EXCEPTION = VISAException(code: VI_ERROR_NSUP_MECH, identifier: "VI_ERROR_NSUP_MECH", message: "No new event is raised because there is no room available on the queue. This means you have already received all previous events but not closed them. You must call viClose on each event you receive from viWaitOnEvent.");
final VISAException VI_ERROR_INV_HNDLR_REF_EXCEPTION = VISAException(code: VI_ERROR_INV_HNDLR_REF, identifier: "VI_ERROR_INV_HNDLR_REF", message: "The given handler reference is invalid.");








