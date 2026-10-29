import 'package:flutter_test/flutter_test.dart';
import 'package:blue_puffin/features/run/presentation/utils/run_formatters.dart';

void main() {
  group('RunFormatters', () {
    test('formatDuration formats correctly', () {
      expect(RunFormatters.formatDuration(0), '0:00');
      expect(RunFormatters.formatDuration(65), '1:05');
      expect(RunFormatters.formatDuration(3665), '1:01:05');
    });

    test('formatDistanceKm formats to 1 decimal', () {
      expect(RunFormatters.formatDistanceKm(5000), '5.0');
      expect(RunFormatters.formatDistanceKm(1234), '1.2');
    });

    test('formatPace handles zero distance', () {
      expect(RunFormatters.formatPace(0, 2100), '--');
    });

    test('formatPace formats 5:00/km', () {
      expect(RunFormatters.formatPace(1000, 300), "5'00\"");
    });
  });
}
