import '../models/job.dart';
import '../data/mock_data.dart';

class JobRepository {
  final List<Job> _jobs = List.from(MockData.mockJobs);

  Future<List<Job>> fetchJobs({
    String? searchQuery,
    String? workType,
    String? jobType,
    String? experience,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return _jobs.where((job) {
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        final matchTitle = job.title.toLowerCase().contains(query);
        final matchCompany = job.company.toLowerCase().contains(query);
        final matchLocation = job.location.toLowerCase().contains(query);
        final matchSkills = job.skills.any((s) => s.toLowerCase().contains(query));

        if (!matchTitle && !matchCompany && !matchLocation && !matchSkills) {
          return false;
        }
      }

      if (workType != null && workType != 'All' && workType.isNotEmpty) {
        if (job.workType.toLowerCase() != workType.toLowerCase()) {
          return false;
        }
      }

      if (jobType != null && jobType != 'All' && jobType.isNotEmpty) {
        if (job.jobType.toLowerCase() != jobType.toLowerCase()) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  Future<void> toggleBookmark(String jobId) async {
    final index = _jobs.indexWhere((j) => j.id == jobId);
    if (index != -1) {
      _jobs[index].isBookmarked = !_jobs[index].isBookmarked;
    }
  }
}
