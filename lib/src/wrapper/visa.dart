import '../../ni_visa.dart' as vi;

class VISA {
  static  int _resourceManagerSession = vi.openDefaultRM();
  static vi.Resources listResource(String expression) => vi.findRsrc(_resourceManagerSession, expression);
  
  late int _session;

  VISA(String resourceName, {int? mode, int? timeout}) {
    _session = vi.open(_resourceManagerSession, resourceName, mode: mode, timeout: timeout);
  }
  
  write(String data) {
    vi.write(_session, data);
  }

  String read() {
    return vi.read(_session);
  }

  dispose() {
    vi.close(_session);
  }
}