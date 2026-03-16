import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class SiyaqaAppBar extends StatelessWidget {
  const SiyaqaAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('مرحباً 👋', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 2),
            Text('تعليم السياقة بالمغرب',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.accent)),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: AppColors.textSec),
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }
}
