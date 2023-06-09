import 'dart:developer' as dev;

bool _enabled = true;

class LoggerConfig {
  LoggerConfig._();

  static void disableLogs() {
    _enabled = false;
  }
}

class Logger {
  Logger(this.type);

  final Type type;

  void log(Object? message) {
    if (_enabled) dev.log("$type: $message");
  }
}
