import '../ni_visa_dart.dart' as vi;

class VISA {
  static  vi.Session _resourceManagerSession = vi.openDefaultRM();
  static vi.Resources listResource(String expression) => vi.findRsrc(_resourceManagerSession.id, expression);
  
  late vi.Session _session;

  VISA(String resourceName, {int? mode, int? timeout}) {
    _session = vi.open(_resourceManagerSession, resourceName, mode: mode, timeout: timeout);
  }
  
  write(String data) {
    vi.write(_session, data);
  }

  String read() {
    return vi.read(_session).data;
  }

  dispose() {
    vi.close(_session);
  }
}