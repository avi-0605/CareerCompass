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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onStart,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Category Icon Badge Box
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(assessment.title),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      assessment.title.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assessment.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                          color: Color(0xFF1C1917),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${assessment.questions.length} qs  •  ${assessment.difficulty}  •  ${assessment.estimatedTimeMinutes} min',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF78716C),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Color(0xFFA8A29E),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String title) {
    if (title.contains('Flutter')) return const Color(0xFF02569B);
    if (title.contains('Dart')) return const Color(0xFF0175C2);
    if (title.contains('Web')) return const Color(0xFF38BDF8);
    if (title.contains('Data Structures')) return const Color(0xFFD97706);
    if (title.contains('UI/UX')) return const Color(0xFF7C3AED);
    return const Color(0xFF18181B);
  }
}
