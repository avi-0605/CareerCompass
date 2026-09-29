import 'question.dart';

enum PerformanceLevel {
  excellent('Excellent', '90-100%'),
  strong('Strong', '75-89%'),
  good('Good', '60-74%'),
  needsImprovement('Needs Improvement', 'Below 60%');

  final String label;
  final String range;
  const PerformanceLevel(this.label, this.range);

  static PerformanceLevel fromPercentage(double percentage) {
    if (percentage >= 90) return PerformanceLevel.excellent;
    if (percentage >= 75) return PerformanceLevel.strong;
    if (percentage >= 60) return PerformanceLevel.good;
    return PerformanceLevel.needsImprovement;
  }
}

class Assessment {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final int estimatedTimeMinutes;
  final List<Question> questions;
  
  // Results / completion state
  bool isCompleted;
  int? score;
  double? percentage;
  int? correctAnswers;
  int? incorrectAnswers;
  int? unanswered;
  int? durationSeconds;
  DateTime? completedAt;

  Assessment({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.estimatedTimeMinutes,
    required this.questions,
    this.isCompleted = false,
    this.score,
    this.percentage,
    this.correctAnswers,
    this.incorrectAnswers,
    this.unanswered,
    this.durationSeconds,
    this.completedAt,
  });

  PerformanceLevel get performanceLevel {
    if (percentage == null) return PerformanceLevel.needsImprovement;
    return PerformanceLevel.fromPercentage(percentage!);
  }
}
