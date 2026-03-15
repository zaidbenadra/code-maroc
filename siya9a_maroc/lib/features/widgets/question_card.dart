import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selected;
  final bool answered;
  final ValueChanged<int> onAnswer;
  const QuestionCard({super.key, required this.question, this.selected, required this.answered, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.imagePath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(question.imagePath!, height: 180, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink()),
          ),
        if (question.imagePath != null) const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Text(question.text,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.6)),
        ),
        const SizedBox(height: 20),
        ...List.generate(question.options.length, (i) => _OptionTile(
          index: i, text: question.options[i],
          selected: selected, answered: answered,
          correctIndex: question.correctIndex,
          onTap: () => onAnswer(i),
        )),
        if (answered) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.accent.withOpacity(0.25)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: AppColors.accent, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(question.explanation,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPri, height: 1.5)),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final int index, correctIndex;
  final String text;
  final int? selected;
  final bool answered;
  final VoidCallback onTap;
  const _OptionTile({required this.index, required this.text, this.selected, required this.answered, required this.correctIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color border = AppColors.divider;
    Color bg     = AppColors.card;
    Color textC  = AppColors.textPri;
    Icon? trailing;

    if (answered) {
      if (index == correctIndex) {
        border = AppColors.success; bg = AppColors.success.withOpacity(0.1); textC = AppColors.success;
        trailing = const Icon(Icons.check_circle, color: AppColors.success, size: 20);
      } else if (index == selected) {
        border = AppColors.error; bg = AppColors.error.withOpacity(0.1); textC = AppColors.error;
        trailing = const Icon(Icons.cancel, color: AppColors.error, size: 20);
      }
    } else if (index == selected) {
      border = AppColors.accent; bg = AppColors.accent.withOpacity(0.1); textC = AppColors.accent;
    }

    return GestureDetector(
      onTap: answered ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Row(
          children: [
            if (trailing != null) ...[trailing, const SizedBox(width: 10)],
            Expanded(child: Text(text, textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textC))),
          ],
        ),
      ),
    );
  }
}
