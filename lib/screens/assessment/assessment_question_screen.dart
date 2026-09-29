import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/assessment_provider.dart';
import '../../widgets/dialogs/confirmation_dialog.dart';
import '../../app/routes.dart';

class AssessmentQuestionScreen extends StatelessWidget {
  const AssessmentQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<AssessmentProvider>(context);
    final assessment = provider.activeAssessment;

    if (assessment == null) {
      return const Scaffold(
        body: Center(child: Text('No active assessment.')),
      );
    }

    final currentIndex = provider.currentQuestionIndex;
    final totalQuestions = assessment.questions.length;
    final currentQuestion = assessment.questions[currentIndex];
    final selectedOption = provider.userAnswers[currentIndex];
    final isLastQuestion = currentIndex == totalQuestions - 1;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final leave = await showDialog<bool>(
          context: context,
          builder: (ctx) => ConfirmationDialog(
            title: 'Quit Assessment?',
            message: 'Your progress for this assessment will be lost.',
            confirmText: 'Quit',
            cancelText: 'Continue',
            icon: Icons.warning_amber_rounded,
            iconColor: const Color(0xFFEF4444),
            onConfirm: () {
              Navigator.of(context).pop();
            },
          ),
        );
        if (leave == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(assessment.title),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  'Question ${currentIndex + 1} of $totalQuestions',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Linear Progress Indicator
            LinearProgressIndicator(
              value: (currentIndex + 1) / totalQuestions,
              minHeight: 6,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'QUESTION ${currentIndex + 1}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      currentQuestion.text,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Options List
                    ...currentQuestion.options.asMap().entries.map((entry) {
                      final optionIdx = entry.key;
                      final optionText = entry.value;
                      final isSelected = selectedOption == optionIdx;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => provider.selectAnswer(currentIndex, optionIdx),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected ? const Color(0xFF2563EB) : Colors.white,
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFCBD5E1),
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    optionText,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF334155),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (currentIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => provider.previousQuestion(),
                        child: const Text('Previous'),
                      ),
                    )
                  else
                    const Spacer(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLastQuestion) {
                          showDialog(
                            context: context,
                            builder: (ctx) => ConfirmationDialog(
                              title: 'Submit Assessment?',
                              message: 'You have answered ${provider.userAnswers.length} of $totalQuestions questions.',
                              confirmText: 'Submit Now',
                              onConfirm: () async {
                                await provider.submitQuiz();
                                if (context.mounted) {
                                  Navigator.pushReplacementNamed(context, AppRoutes.assessmentResult);
                                }
                              },
                            ),
                          );
                        } else {
                          provider.nextQuestion();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLastQuestion ? const Color(0xFF10B981) : const Color(0xFF1E293B),
                      ),
                      child: Text(isLastQuestion ? 'Submit Quiz' : 'Next Question'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
