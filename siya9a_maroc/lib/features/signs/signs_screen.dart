import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

const _categories = [
  {'label': 'علامات التحذير',   'color': 0xFFFFB545, 'icon': Icons.warning_amber_rounded},
  {'label': 'علامات المنع',     'color': 0xFFFF4D6A, 'icon': Icons.block},
  {'label': 'علامات الإلزام',   'color': 0xFF448AFF, 'icon': Icons.check_circle_outline},
  {'label': 'علامات الإرشاد',   'color': 0xFF00E5BE, 'icon': Icons.info_outline},
];

class SignsScreen extends StatelessWidget {
  const SignsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إشارات المرور')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.0,
        children: _categories.map((cat) {
          final color = Color(cat['color'] as int);
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: color.withOpacity(0.25)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
                    child: Icon(cat['icon'] as IconData, color: color, size: 30),
                  ),
                  const SizedBox(height: 12),
                  Text(cat['label'] as String,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
