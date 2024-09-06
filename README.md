# NI VISA for Dart

A Dart SDK for NI-VISA(with C), NOT `NI` OFFICIAL

## Reference 
- Official Reference Docs: [ni-visa_api_reference.pdf](reference/ni-visa_api_reference.pdf)
- Official C header files: [visa.h](reference/visa.h), [visatype.h](reference/visatype.h) , [vpptype.h](reference/vpptype.h)

## Feature
- Dart FFI wrapper for `NI-VISA`/C
- Convert operation status to throw `VISAException` when NOT `VI_SUCCESS` 
- Only support 64bits

## Usage
1. Confirm your computer has installed `NI-VISA`. (If you don't know what is NI-VISA, it means do not need it).
2. Example:
    ```dart
    void main() {
      // Initial VISA Resource Manager
      Session resourceManagerSession = openDefaultRM();
    
      // Open VISA session for special instrument
      Session session = open(resourceManagerSession, "ASRL1::INSTR");
    
      // Send "*IDN?" to instrument. Query instrument id.
      ReturnCount returnCount = write(session, "*IDN?\n");
    
      // Read data from instrument
      ReturnData returnData = read(session);
    
      // Close VISA session
      close(session);
    }
    ```

## Planning
| Functions            | Done |
|----------------------|------|
| viOpenDefaultRM      | ✅    |
| viFindRsrc           | ✅    |
| viFindNext           | ✅    |
| viParseRsrc          | ✅    |
| viParseRsrcEx        | ✅    |
| viOpen               | ✅    |
| viClose              | ✅    |
| viSetAttribute       | ✅    |
| viGetAttribute       | ✅    |
| viStatusDesc         | ✅    |
| viTerminate          | ✅    |
| viLock               | TODO |
| viUnLock             | TODO |
| viEnableEvent        | TODO |
| viDisableEvent       | TODO |
| viDiscardEvents      | TODO |
| viWaitOnEvent        | TODO |
| viInstallHandler     | TODO |
| viUninstallHandler   | TODO |
| viRead               | ✅    |
| viReadAsync          | TODO |
| viReadToFile         | TODO |
| viWrite              | ✅    |
| viWriteAsync         | TODO |
| viWriteFromFile      | TODO |
| viAssertTrigger      | TODO |
| viReadSTB            | TODO |
| viClear              | TODO |
| viSetBuf             | TODO |
| viFlush              | TODO |
| viBufWrite           | TODO |
| viBufRead            | TODO |
| viPrintf             | TODO |
| viVPrintf            | TODO |
| viSPrintf            | TODO |
| viVSPrintf           | TODO |
| viScanf              | TODO |
| viVScanf             | TODO |
| viSScanf             | TODO |
| viVSScanf            | TODO |
| viQueryf             | TODO |
| viVQueryf            | TODO |
| viIn8                | TODO |
| viOut8               | TODO |
| viIn16               | TODO |
| viOut16              | TODO |
| viIn32               | TODO |
| viOut32              | TODO |
| viIn64               | TODO |
| viOut64              | TODO |
| viIn8Ex              | TODO |
| viOut8Ex             | TODO |
| viIn16Ex             | TODO |
| viOut16Ex            | TODO |
| viIn32Ex             | TODO |
| viOut32Ex            | TODO |
| viIn64Ex             | TODO |
| viOut64Ex            | TODO |
| viMoveIn8            | TODO |
| viMoveOut8           | TODO |
| viMoveIn16           | TODO |
| viMoveOut16          | TODO |
| viMoveIn32           | TODO |
| viMoveOut32          | TODO |
| viMoveIn64           | TODO |
| viMoveOut64          | TODO |
| viMoveEx             | TODO |
| viMoveAsync          | TODO |
| viMoveAsyncEx        | TODO |
| viMapAddress         | TODO |
| viUnmapAddress       | TODO |
| viMapAddressEx       | TODO |
| viPeek8              | TODO |
| viPoke8              | TODO |
| viPeek16             | TODO |
| viPoke16             | TODO |
| viPeek32             | TODO |
| viPoke32             | TODO |
| viPeek64             | TODO |
| viPoke64             | TODO |
| viMemAlloc           | TODO |
| viMemFree            | TODO |
| viMemAllocEx         | TODO |
| viMemFreeEx          | TODO |
| viGpibControlRE      | TODO |
| viGpibControlATN     | TODO |
| viGpibSendIFC        | TODO |
| viGpibCommand        | TODO |
| viGpibPassControl    | TODO |
| viVxiCommandQuery    | TODO |
| viAssertUtilSignal   | TODO |
| viAssertIntrSignal   | TODO |
| viMapTrigger         | TODO |
| viUnmapTrigger       | TODO |
| viUsbControlOut      | TODO |
| viUsbControlIn       | TODO |
| viPxiReserveTriggers | TODO |