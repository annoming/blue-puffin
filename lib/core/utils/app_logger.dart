class AppLogger {
  const AppLogger._();

  static void info(String message) {
    // Debug logging placeholder
    print('[INFO] $message');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    print('[ERROR] $message');
    if (error != null) print(error);
    if (stackTrace != null) print(stackTrace);
  }
}
