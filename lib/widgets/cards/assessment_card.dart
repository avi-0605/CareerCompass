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

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFC7D2FE)),
              ),
              child: const Icon(
                Icons.quiz_outlined,
                color: Color(0xFF4F46E5),
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          assessment.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '+150 XP',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB45309),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${assessment.questions.length} Qs',
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      const Text('•', style: TextStyle(color: Color(0xFFCBD5E1))),
                      const SizedBox(width: 6),
                      Text(
                        assessment.difficulty,
                        style: TextStyle(
                          color: _getDifficultyColor(assessment.difficulty),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('•', style: TextStyle(color: Color(0xFFCBD5E1))),
                      const SizedBox(width: 6),
                      Text(
                        '⏱️ ${assessment.estimatedTimeMinutes} min',
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  if (assessment.isCompleted) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFA7F3D0)),
                      ),
                      child: Text(
                        '🏆 Score: ${assessment.percentage?.toStringAsFixed(0)}% (${assessment.performanceLevel.label})',
                        style: const TextStyle(
                          color: Color(0xFF047857),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: assessment.isCompleted
                    ? const Color(0xFF4F46E5)
                    : const Color(0xFF0F172A),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
