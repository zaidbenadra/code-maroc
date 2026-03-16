import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class SeriesResult {
  final String seriesId;
  final int score;
  final int total;
  final DateTime date;
  SeriesResult({required this.seriesId, required this.score, required this.total, required this.date});
}

class ProgressProvider extends ChangeNotifier {
  final _box = Hive.box('progress');

  void saveResult(String seriesId, int score, int total) {
    final existing = _box.get(seriesId, defaultValue: <dynamic>[]) as List;
    existing.add({'score': score, 'total': total, 'date': DateTime.now().toIso8601String()});
    _box.put(seriesId, existing);
    notifyListeners();
  }

  bool isSeriesCompleted(String seriesId) {
    final data = _box.get(seriesId, defaultValue: <dynamic>[]) as List;
    return data.isNotEmpty;
  }

  int? bestScore(String seriesId) {
    final data = _box.get(seriesId, defaultValue: <dynamic>[]) as List;
    if (data.isEmpty) return null;
    return data.map((e) => e['score'] as int).reduce((a, b) => a > b ? a : b);
  }

  double get overallProgress {
    if (_box.isEmpty) return 0.0;
    return (_box.length / 20).clamp(0.0, 1.0); // assume 20 series
  }
}
