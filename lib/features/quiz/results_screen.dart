import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> extra;
  const ResultsScreen({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    final int score   = extra['score'];
    final int total   = extra['total'];
    final String seriesId = extra['seriesId'];
    final double pct  = score / total;
    final passed      = pct >= 0.75;
    final color       = passed ? AppColors.success : AppColors.error;
    final questions   = extra['questions'] as List<Question>;
    final answers     = extra['answers'] as Map<int, int?>;

    return Scaffold(
      appBar: AppBar(title: const Text('نتيجتك')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 70, lineWidth: 9,
                      percent: pct,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score.toString() + '/' + total.toString(),
                            style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 22),
                          ),
                          Text(
                            (pct * 100).toInt().toString() + '%',
                            style: TextStyle(color: color.withOpacity(0.7), fontSize: 14),
                          ),
                        ],
                      ),
                      progressColor: color,
                      backgroundColor: AppColors.divider,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      passed ? '🎉 أحسنت! اجتزت السلسلة' : '💪 حاول مجدداً',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text('مراجعة الأجوبة', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              ...List.generate(questions.length, (i) {
                final q = questions[i];
                final userAns = answers[i];
                final correct = userAns == q.correctIndex;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: correct ? AppColors.success.withOpacity(0.3) : AppColors.error.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(correct ? Icons.check_circle : Icons.cancel,
                          color: correct ? AppColors.success : AppColors.error, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text(
                        'س' + (i + 1).toString() + ': ' + q.text,
                        textAlign: TextAlign.right,
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPri),
                      )),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('العودة للرئيسية'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.go('/quiz/' + seriesId),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
