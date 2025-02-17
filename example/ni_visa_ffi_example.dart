import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:ni_visa_dart/ni_visa.dart';

void main() {
  NIVisaFFI niVisaFFI = NIVisaFFI(DynamicLibrary.open("dynamic_libs/macos/VISA.framework/VISA"));
  Pointer<UnsignedInt> vi = malloc<UnsignedInt>(1);
  int status = niVisaFFI.viOpenDefaultRM(vi);
  int session = vi.value;
  malloc.free(vi);

  print("status: $status" + ", session: $session");
}

