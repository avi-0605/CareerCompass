import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/assessment_provider.dart';
import '../../widgets/cards/assessment_card.dart';
import '../../app/routes.dart';

class AssessmentListScreen extends StatelessWidget {
  const AssessmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<AssessmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Assessments'),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Card
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Validate Your Expertise',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Take short technical quizzes to benchmark your skills and boost your job match score.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Icon(Icons.verified, color: Color(0xFF10B981), size: 42),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Available Assessments',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 12),

                  ...provider.assessments.map((assessment) {
                    return AssessmentCard(
                      assessment: assessment,
                      onStart: () {
                        provider.startQuiz(assessment);
                        Navigator.pushNamed(context, AppRoutes.assessmentQuestions);
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}
