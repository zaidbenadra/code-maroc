import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionTitle('اللغة'),
          _RadioTile(label: 'العربية / الدارجة', value: 'ar', groupValue: settings.language, onChanged: settings.setLanguage),
          _RadioTile(label: 'Français', value: 'fr', groupValue: settings.language, onChanged: settings.setLanguage),
          const SizedBox(height: 20),
          _SectionTitle('الصوت'),
          _SwitchTile(label: 'تشغيل الأصوات', value: settings.soundOn, onChanged: (_) => settings.toggleSound()),
          const SizedBox(height: 20),
          _SectionTitle('التطبيق'),
          _InfoTile(label: 'الإصدار', value: '1.0.0'),
          _InfoTile(label: 'المطور', value: 'Your Name'),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.8)),
  );
}

class _RadioTile extends StatelessWidget {
  final String label, value, groupValue;
  final ValueChanged<String> onChanged;
  const _RadioTile({required this.label, required this.value, required this.groupValue, required this.onChanged});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: AppColors.card, borderRadius: BorderRadius.circular(12),
      border: Border.all(color: value == groupValue ? AppColors.accent.withOpacity(0.4) : AppColors.divider),
    ),
    child: RadioListTile<String>(
      value: value, groupValue: groupValue, onChanged: (v) => onChanged(v!),
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      activeColor: AppColors.accent,
    ),
  );
}

class _SwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile({required this.label, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12)),
    child: SwitchListTile(
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      value: value, onChanged: onChanged,
      activeColor: AppColors.accent,
    ),
  );
}

class _InfoTile extends StatelessWidget {
  final String label, value;
  const _InfoTile({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}
