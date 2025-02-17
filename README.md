# NI VISA for Dart

A Dart SDK for NI-VISA(with C), NOT `NI` OFFICIAL

## Reference 
- Official Reference Docs: [ni-visa_api_reference.pdf](reference/ni-visa_api_reference.pdf)
- Official C header files: [visa.h](include/visa.h), [visatype.h](include/visatype.h) , [vpptype.h](include/vpptype.h)

## Feature
- Dart FFI wrapper for `NI-VISA`/C via ffigen
- model wrapper OUT data
- Convert operation status to throw `VISAStatus`

## Usage
1. Confirm your computer has installed `NI-VISA`. (If you don't know what is NI-VISA, it means do not need it).
2. Example(macOS by VISA.framework):
   ```dart
   void main() {
     try {
       NIVisaDart niVisaDart = NIVisaDart(File("dynamic_libs/macos/VISA.framework/VISA"));
       Session session = niVisaDart.viOpenDefaultRM();
       print("status: ${session.status}" + ", session: ${session.session}");
     } on VISAError catch (e) {
       print(e.toJson());
     }
   }
   ```