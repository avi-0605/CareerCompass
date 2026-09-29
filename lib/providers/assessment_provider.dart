import 'package:flutter/material.dart';
import '../models/assessment.dart';
import '../repositories/assessment_repository.dart';

class AssessmentProvider extends ChangeNotifier {
  final AssessmentRepository _repository;

  List<Assessment> _assessments = [];
  bool _isLoading = false;
  String? _error;

  // Active quiz session state
  Assessment? _activeAssessment;
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {}; // QuestionIndex -> SelectedOptionIndex
  DateTime? _quizStartTime;

  AssessmentProvider(this._repository) {
    loadAssessments();
  }

  List<Assessment> get assessments => _assessments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Assessment? get activeAssessment => _activeAssessment;
  int get currentQuestionIndex => _currentQuestionIndex;
  Map<int, int> get userAnswers => _userAnswers;

  int get overallSkillCompletionPercentage {
    if (_assessments.isEmpty) return 65;
    final completedCount = _assessments.where((a) => a.isCompleted).length;
    if (completedCount == 0) return 65; // base level from profile
    return ((completedCount / _assessments.length) * 100).round();
  }

  Future<void> loadAssessments() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _assessments = await _repository.getAssessments();
    } catch (e) {
      _error = 'Failed to load skill assessments.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void startQuiz(Assessment assessment) {
    _activeAssessment = assessment;
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _quizStartTime = DateTime.now();
    notifyListeners();
  }

  void selectAnswer(int questionIndex, int optionIndex) {
    _userAnswers[questionIndex] = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_activeAssessment != null && _currentQuestionIndex < _activeAssessment!.questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  Future<Assessment> submitQuiz() async {
    if (_activeAssessment == null) throw Exception("No active quiz");

    final questions = _activeAssessment!.questions;
    final totalQuestions = questions.length;
    int correctCount = 0;
    int incorrectCount = 0;
    int unansweredCount = 0;

    for (int i = 0; i < totalQuestions; i++) {
      if (!_userAnswers.containsKey(i)) {
        unansweredCount++;
      } else if (_userAnswers[i] == questions[i].correctAnswerIndex) {
        correctCount++;
      } else {
        incorrectCount++;
      }
    }

    final double percentage = (correctCount / totalQuestions) * 100;
    final durationSecs = _quizStartTime != null
        ? DateTime.now().difference(_quizStartTime!).inSeconds
        : 60;

    _activeAssessment!.isCompleted = true;
    _activeAssessment!.score = correctCount;
    _activeAssessment!.percentage = double.parse(percentage.toStringAsFixed(1));
    _activeAssessment!.correctAnswers = correctCount;
    _activeAssessment!.incorrectAnswers = incorrectCount;
    _activeAssessment!.unanswered = unansweredCount;
    _activeAssessment!.durationSeconds = durationSecs;
    _activeAssessment!.completedAt = DateTime.now();

    await _repository.updateAssessmentResult(_activeAssessment!);
    notifyListeners();

    return _activeAssessment!;
  }
}
