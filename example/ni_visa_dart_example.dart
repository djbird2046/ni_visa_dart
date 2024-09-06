import 'package:ni_visa_dart/ni_visa.dart';

void main() {
  // Initial VISA Resource Manager
  int resourceManagerSession = openDefaultRM();

  // Open VISA session for special instrument
  int session = open(resourceManagerSession, "ASRL1::INSTR");

  // Send "*IDN?" to instrument. Query instrument id.
  int returnCount = write(session, "*IDN?\n");
  print("returnCount: $returnCount");

  // Read data from instrument
  String returnData = read(session);
  print("returnData: $returnData");

  // Close VISA session
  close(session);
}

