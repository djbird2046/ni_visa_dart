import 'package:ni_visa_dart/ni_visa_dart.dart';

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
