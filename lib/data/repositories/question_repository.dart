import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question.dart';
import '../models/series.dart';

class QuestionRepository {
  static Future<List<Series>> loadSeries() async {
    final raw = await rootBundle.loadString('assets/questions/series.json');
    final list = jsonDecode(raw) as List;
    return list.map((e) => Series.fromJson(e)).toList();
  }

  static Future<List<Question>> loadSeriesQuestions(String seriesId) async {
    final raw = await rootBundle.loadString('assets/questions/series_$seriesId.json');
    final list = jsonDecode(raw) as List;
    return list.map((e) => Question.fromJson(e)).toList();
  }

  static Future<List<Question>> loadExamQuestions() async {
    // Load all series and pick 40 random questions
    final raw = await rootBundle.loadString('assets/questions/series.json');
    final seriesList = (jsonDecode(raw) as List).map((e) => Series.fromJson(e)).toList();
    final all = <Question>[];
    for (final s in seriesList) {
      all.addAll(await loadSeriesQuestions(s.id));
    }
    all.shuffle();
    return all.take(40).toList();
  }
}
