import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers/progress_provider.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/menu_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SiyaqaAppBar(),
              const SizedBox(height: 28),
              _HeroBanner(progress: progress.overallProgress),
              const SizedBox(height: 28),
              Text('ابدأ التعلم', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.1,
                children: const [
                  MenuCard(icon: Icons.format_list_numbered_rtl, label: 'السلاسل', route: '/series', color: AppColors.accent),
                  MenuCard(icon: Icons.school_outlined,           label: 'الدروس',  route: '/lessons', color: Color(0xFF7C4DFF)),
                  MenuCard(icon: Icons.sign_language_outlined,    label: 'الإشارات',route: '/signs',  color: Color(0xFFFF6D00)),
                  MenuCard(icon: Icons.timer_outlined,            label: 'الامتحان', route: '/exam',  color: Color(0xFFFF4D6A)),
                ],
              ),
            ].animate(interval: 80.ms).fadeIn(duration: 350.ms).slideY(begin: 0.15),
          ),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final double progress;
  const _HeroBanner({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00E5BE22), Color(0xFF00E5BE08)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.25), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تقدّمك العام', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text('${(progress * 100).toInt()}% مكتمل',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () => context.push('/series'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(160, 44)),
                  child: const Text('تابع التدريب'),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 52,
            lineWidth: 7,
            percent: progress,
            center: Text('${(progress * 100).toInt()}%',
                style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 16)),
            progressColor: AppColors.accent,
            backgroundColor: AppColors.divider,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
