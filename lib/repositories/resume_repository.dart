import '../models/resume.dart';
import '../data/mock_data.dart';

class ResumeRepository {
  Resume _currentResume = MockData.initialResume;

  Future<Resume> getResume() async {
    // Simulate slight async network/database delay
    await Future.delayed(const Duration(milliseconds: 150));
    return _currentResume;
  }

  Future<void> saveResume(Resume updatedResume) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentResume = updatedResume;
  }
}
