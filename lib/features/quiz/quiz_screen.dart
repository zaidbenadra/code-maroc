import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../../data/providers/progress_provider.dart';
import '../../data/repositories/question_repository.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  final String seriesId;
  const QuizScreen({super.key, required this.seriesId});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _current = 0;
  int? _selected;
  bool _answered = false;
  final Map<int, int?> _answers = {};
  bool _loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final qs = await QuestionRepository.loadSeriesQuestions(widget.seriesId);
    setState(() { _questions = qs; _loading = false; });
  }

  void _onAnswer(int idx) {
    if (_answered) return;
    setState(() { _selected = idx; _answered = true; _answers[_current] = idx; });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() { _current++; _selected = _answers[_current]; _answered = _answers.containsKey(_current); });
    } else {
      final score = _answers.entries
          .where((e) => e.value == _questions[e.key].correctIndex).length;
      context.read<ProgressProvider>().saveResult(widget.seriesId, score, _questions.length);
      context.go('/results', extra: {
        'score': score, 'total': _questions.length,
        'seriesId': widget.seriesId, 'answers': _answers,
        'questions': _questions,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.accent)));
    final q = _questions[_current];
    final pct = (_current + 1) / _questions.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('السؤال ' + (_current + 1).toString() + ' / ' + _questions.length.toString()),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: pct,
            backgroundColor: AppColors.divider,
            color: AppColors.accent,
            minHeight: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: QuestionCard(
                  question: q,
                  selected: _selected,
                  answered: _answered,
                  onAnswer: _onAnswer,
                ).animate().fadeIn(duration: 300.ms),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ElevatedButton(
                onPressed: _answered ? _next : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _answered ? AppColors.accent : AppColors.divider,
                  foregroundColor: _answered ? AppColors.bg : AppColors.textSec,
                ),
                child: Text(_current < _questions.length - 1 ? 'السؤال التالي' : 'إنهاء السلسلة'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
