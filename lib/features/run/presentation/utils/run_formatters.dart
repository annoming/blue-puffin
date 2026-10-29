class RunFormatters {
  static String formatDuration(int seconds) {
    if (seconds < 0) seconds = 0;
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    final mm = minutes.toString().padLeft(2, '0');
    final ss = secs.toString().padLeft(2, '0');
    if (hours > 0) {
      return '$hours:$mm:$ss';
    }
    return '$minutes:$ss';
  }

  static String formatDistanceKm(double meters) {
    return (meters / 1000.0).toStringAsFixed(1);
  }

  static String formatPace(double meters, int seconds) {
    if (meters <= 0 || seconds <= 0) return '--';
    final paceSeconds = seconds / (meters / 1000.0);
    if (paceSeconds.isNaN || !paceSeconds.isFinite || paceSeconds <= 0) return '--';
    final total = paceSeconds.round();
    return "${total ~/ 60}'${(total % 60).toString().padLeft(2, '0')}\"";
  }
}
