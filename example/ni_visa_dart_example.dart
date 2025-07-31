import 'dart:io';
import 'package:ni_visa_dart/ni_visa_dart.dart';

void main() {
  try {
    NIVisaDart niVisaDart = NIVisaDart(File("dynamic_libs/macos/VISA.framework/VISA"));
    Session session = niVisaDart.viOpenDefaultRM();
    print("status: ${session.status}" + ", session: ${session.session}");
  } on VISAError catch (e) {
    print(e.toJson());
  }
}