import '../models/assessment.dart';
import '../data/mock_data.dart';

class AssessmentRepository {
  final List<Assessment> _assessments = List.from(MockData.mockAssessments);

  Future<List<Assessment>> getAssessments() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _assessments;
  }

  Future<void> updateAssessmentResult(Assessment updated) async {
    final index = _assessments.indexWhere((a) => a.id == updated.id);
    if (index != -1) {
      _assessments[index] = updated;
    }
  }
}
