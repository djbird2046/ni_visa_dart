import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import '../ffi/ni_visa_ffi.dart';

extension PointerUnsignedIntExtension on Pointer<UnsignedInt> {
  List<int> asTypedList(int length) {
    List<int> list = [];
    for (int i = 0; i < length; i++) {
      list.add(this[i]);
    }
    return list;
  }
}

extension StringToPointerChar on String {
  ViConstString toPointerCharMalloc() {
    final bytes = utf8.encode(this);
    final pointer = malloc<ViChar>(bytes.length + 1);

    for (int i = 0; i < bytes.length; i++) {
      pointer[i] = bytes[i];
    }

    pointer[bytes.length] = 0;

    return pointer;
  }
}

extension PointerCharToString on Pointer<Char> {
  String toStringFromPointerChar() {
    List<int> charList = [];
    int i = 0;

    while (this[i] != 0) {
      charList.add(this[i]);
      i++;
    }

    return utf8.decode(charList);
  }
}


extension PointerUnsignedCharToUint8List on Pointer<UnsignedChar> {
  Uint8List toUint8List(int length) {
    List<int> byteList = [];

    for (int i = 0; i < length; i++) {
      byteList.add(this[i]);
    }

    return Uint8List.fromList(byteList);
  }
}

extension Uint8ListToPointerUnsignedChar on Uint8List {

  Pointer<UnsignedChar> toPointerUnsignedCharMalloc() {
    int cnt = this.length;
    Pointer<UnsignedChar> buf = malloc<UnsignedChar>(cnt);
    for (int i = 0; i < cnt; i++) {
      buf[i] = this[i];
    }
    return buf;
  }
}