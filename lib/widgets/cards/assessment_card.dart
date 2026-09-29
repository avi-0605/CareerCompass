import 'package:flutter/material.dart';
import '../../models/assessment.dart';

class AssessmentCard extends StatelessWidget {
  final Assessment assessment;
  final VoidCallback onStart;

  const AssessmentCard({
    super.key,
    required this.assessment,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.quiz_outlined,
                color: Color(0xFF2563EB),
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assessment.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${assessment.questions.length} Questions',
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Color(0xFF94A3B8))),
                      const SizedBox(width: 8),
                      Text(
                        assessment.difficulty,
                        style: TextStyle(
                          color: _getDifficultyColor(assessment.difficulty),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Color(0xFF94A3B8))),
                      const SizedBox(width: 8),
                      Text(
                        '${assessment.estimatedTimeMinutes} min',
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  if (assessment.isCompleted) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Completed — ${assessment.percentage?.toStringAsFixed(0)}% Score',
                        style: const TextStyle(
                          color: Color(0xFF059669),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: assessment.isCompleted
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF1E293B),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
              child: Text(assessment.isCompleted ? 'Retake' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return const Color(0xFF10B981);
      case 'intermediate':
        return const Color(0xFF3B82F6);
      case 'advanced':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF64748B);
    }
  }
}
