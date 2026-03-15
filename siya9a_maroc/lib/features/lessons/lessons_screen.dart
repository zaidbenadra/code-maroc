import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

const _lessons = [
  {'icon': '🚦', 'title': 'إشارات المرور',      'desc': 'أنواع الإشارات، الألوان، والأولويات'},
  {'icon': '⚡', 'title': 'الأولوية في المرور',  'desc': 'قواعد التقاطعات ومن له الأولوية'},
  {'icon': '🏎️', 'title': 'حدود السرعة',         'desc': 'السرعات المسموح بها حسب نوع الطريق'},
  {'icon': '🅿️', 'title': 'قواعد الوقوف',        'desc': 'أماكن الوقوف المسموحة والممنوعة'},
  {'icon': '🌙', 'title': 'القيادة ليلاً',        'desc': 'استخدام الأضواء والأمان الليلي'},
  {'icon': '🛣️', 'title': 'الطريق السريع',        'desc': 'قواعد خاصة بالطرق السريعة والأوتوسترادات'},
  {'icon': '⚠️', 'title': 'حوادث المرور',         'desc': 'التصرف عند وقوع حادث والإسعاف الأولي'},
  {'icon': '🍺', 'title': 'الكحول والمخدرات',     'desc': 'قوانين القيادة تحت تأثير المواد المخدرة'},
];

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الدروس النظرية')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _lessons.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final l = _lessons[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                Text(l['icon']!, style: const TextStyle(fontSize: 30)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l['title']!, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(l['desc']!, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textSec),
              ],
            ),
          );
        },
      ),
    );
  }
}
