import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/series.dart';
import '../../data/providers/progress_provider.dart';
import '../../data/repositories/question_repository.dart';

class SeriesListScreen extends StatefulWidget {
  const SeriesListScreen({super.key});
  @override
  State<SeriesListScreen> createState() => _SeriesListScreenState();
}

class _SeriesListScreenState extends State<SeriesListScreen> {
  late Future<List<Series>> _future;
  @override
  void initState() { super.initState(); _future = QuestionRepository.loadSeries(); }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('السلاسل')),
      body: FutureBuilder<List<Series>>(
        future: _future,
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: AppColors.accent));
          final series = snap.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: series.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final s = series[i];
              final done = progress.isSeriesCompleted(s.id);
              final best = progress.bestScore(s.id);
              return _SeriesCard(series: s, done: done, best: best);
            },
          );
        },
      ),
    );
  }
}

class _SeriesCard extends StatelessWidget {
  final Series series;
  final bool done;
  final int? best;
  const _SeriesCard({required this.series, required this.done, this.best});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/quiz/\${series.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: done ? AppColors.success.withOpacity(0.4) : AppColors.divider,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46, height: 46,
              decoration: BoxDecoration(
                color: (done ? AppColors.success : AppColors.accent).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                done ? Icons.check_circle_outline : Icons.play_circle_outline,
                color: done ? AppColors.success : AppColors.accent,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(series.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 3),
                  Text('\${series.questionCount} سؤال · \${series.subtitle}',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            if (best != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('\$best/\${series.questionCount}',
                    style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.textSec),
          ],
        ),
      ),
    );
  }
}
