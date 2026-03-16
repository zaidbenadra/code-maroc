import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../../data/providers/progress_provider.dart';
import '../../data/repositories/question_repository.dart';
import '../widgets/question_card.dart';
import 'dart:async';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});
  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  List<Question> _questions = [];
  int _current = 0;
  final Map<int, int?> _answers = {};
  int? _selected;
  bool _answered = false;
  bool _loading = true;
  late Timer _timer;
  int _secondsLeft = 40 * 60;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final qs = await QuestionRepository.loadExamQuestions();
    setState(() { _questions = qs; _loading = false; });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft > 0) setState(() => _secondsLeft--);
      else _finish();
    });
  }

  String get _timerText {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return m.toString().padLeft(2, '0') + ':' + s.toString().padLeft(2, '0');
  }

  void _finish() {
    _timer.cancel();
    final score = _answers.entries
        .where((e) => e.value == _questions[e.key].correctIndex).length;
    context.read<ProgressProvider>().saveResult('exam', score, _questions.length);
    context.go('/results', extra: {
      'score': score, 'total': _questions.length,
      'seriesId': 'exam', 'answers': _answers, 'questions': _questions,
    });
  }

  @override
  void dispose() { _timer.cancel(); super.dispose(); }

  void _onAnswer(int idx) {
    if (_answered) return;
    setState(() { _selected = idx; _answered = true; _answers[_current] = idx; });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() { _current++; _selected = _answers[_current]; _answered = _answers.containsKey(_current); });
    } else { _finish(); }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.accent)));
    final pct = (_current + 1) / _questions.length;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.timer_outlined, color: AppColors.warning, size: 18),
            const SizedBox(width: 6),
            Text(_timerText, style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.w700)),
            const SizedBox(width: 14),
            Text('س' + (_current + 1).toString() + '/' + _questions.length.toString()),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: pct, backgroundColor: AppColors.divider, color: AppColors.warning, minHeight: 4),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: QuestionCard(
                  question: _questions[_current],
                  selected: _selected,
                  answered: _answered,
                  onAnswer: _onAnswer,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ElevatedButton(
                onPressed: _answered ? _next : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _answered ? AppColors.warning : AppColors.divider,
                  foregroundColor: AppColors.bg,
                ),
                child: Text(_current < _questions.length - 1 ? 'التالي' : 'إنهاء الامتحان'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
