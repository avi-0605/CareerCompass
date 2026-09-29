import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/assessment_provider.dart';
import '../../app/routes.dart';

class AssessmentResultScreen extends StatelessWidget {
  const AssessmentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<AssessmentProvider>(context);
    final assessment = provider.activeAssessment;

    if (assessment == null || !assessment.isCompleted) {
      return Scaffold(
        appBar: AppBar(title: const Text('Results')),
        body: const Center(child: Text('No completed assessment results available.')),
      );
    }

    final percentage = assessment.percentage ?? 0.0;
    final totalQuestions = assessment.questions.length;
    final correct = assessment.correctAnswers ?? 0;
    final incorrect = assessment.incorrectAnswers ?? 0;
    final unanswered = assessment.unanswered ?? 0;
    final durationSecs = assessment.durationSeconds ?? 0;
    final perfLevel = assessment.performanceLevel;

    final String recommendationText = _generateRecommendation(percentage, assessment.title);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Results'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Assessment Complete!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              assessment.title,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15),
            ),
            const SizedBox(height: 24),

            // Large circular gauge
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 10,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: AlwaysStoppedAnimation<Color>(_getGaugeColor(percentage)),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${percentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: _getGaugeColor(percentage),
                        ),
                      ),
                      Text(
                        perfLevel.label,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$correct / $totalQuestions Correct',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 24),

            // Summary stats grid
            Row(
              children: [
                Expanded(child: _buildStatTile('Correct', '$correct', const Color(0xFF10B981))),
                const SizedBox(width: 12),
                Expanded(child: _buildStatTile('Incorrect', '$incorrect', const Color(0xFFEF4444))),
                const SizedBox(width: 12),
                Expanded(child: _buildStatTile('Unanswered', '$unanswered', const Color(0xFFF59E0B))),
                const SizedBox(width: 12),
                Expanded(child: _buildStatTile('Time Spent', '${durationSecs}s', const Color(0xFF3B82F6))),
              ],
            ),
            const SizedBox(height: 28),

            // Skill Analysis breakdown
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Skill Analysis Breakdown',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    _buildSkillBar(context, 'Flutter Fundamentals', percentage),
                    const SizedBox(height: 12),
                    _buildSkillBar(context, 'Dart Core Syntax', (percentage * 0.9).clamp(0, 100)),
                    const SizedBox(height: 12),
                    _buildSkillBar(context, 'Problem Solving & Logic', (percentage * 0.85).clamp(0, 100)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recommendations Card
            Card(
              color: const Color(0xFFEFF6FF),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Color(0xFF2563EB), size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personalized Recommendations',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            recommendationText,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF334155),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Action Buttons
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          provider.startQuiz(assessment);
                          Navigator.pushReplacementNamed(context, AppRoutes.assessmentQuestions);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retake Quiz'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.mainNav, arguments: 1); // Jobs tab
                        },
                        icon: const Icon(Icons.work),
                        label: const Text('Explore Jobs'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.mainNav, arguments: 3); // Mentors tab
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                    ),
                    icon: const Icon(Icons.people),
                    label: const Text('Find a Mentor for Guidance'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBar(BuildContext context, String skillName, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skillName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 6,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(_getGaugeColor(percentage)),
          ),
        ),
      ],
    );
  }

  Color _getGaugeColor(double pct) {
    if (pct >= 90) return const Color(0xFF10B981);
    if (pct >= 75) return const Color(0xFF2563EB);
    if (pct >= 60) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  String _generateRecommendation(double pct, String title) {
    if (pct >= 90) {
      return "Outstanding score! You have mastered key concepts in $title. We recommend exploring senior job openings or offering peer mentorship.";
    } else if (pct >= 75) {
      return "Strong performance! Your fundamentals in $title are solid. Consider refining state management and advanced architecture patterns.";
    } else if (pct >= 60) {
      return "Good effort. You have a fair understanding of $title, but reviewing lifecycle methods and async programming will boost your speed.";
    } else {
      return "Needs improvement. Spend time studying core $title concepts and book a session with a mentor to accelerate your learning.";
    }
  }
}
