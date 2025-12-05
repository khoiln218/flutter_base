abstract class LogService {
  void d(
    dynamic data, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  });
  void i(
    dynamic data, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  });
  void w(
    dynamic data, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  });
  void e(
    Object error, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  });
}
