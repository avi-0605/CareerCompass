import 'package:flutter/material.dart';
import '../models/job.dart';
import '../repositories/job_repository.dart';

class JobProvider extends ChangeNotifier {
  final JobRepository _repository;

  List<Job> _jobs = [];
  bool _isLoading = false;
  String? _error;

  String _searchQuery = '';
  String _selectedWorkType = 'All';
  String _selectedJobType = 'All';

  JobProvider(this._repository) {
    fetchJobs();
  }

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  String get searchQuery => _searchQuery;
  String get selectedWorkType => _selectedWorkType;
  String get selectedJobType => _selectedJobType;

  Future<void> fetchJobs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _jobs = await _repository.fetchJobs(
        searchQuery: _searchQuery,
        workType: _selectedWorkType,
        jobType: _selectedJobType,
      );
    } catch (e) {
      _error = 'Failed to load jobs.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    fetchJobs();
  }

  void setWorkTypeFilter(String workType) {
    _selectedWorkType = workType;
    fetchJobs();
  }

  void setJobTypeFilter(String jobType) {
    _selectedJobType = jobType;
    fetchJobs();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedWorkType = 'All';
    _selectedJobType = 'All';
    fetchJobs();
  }

  Future<void> toggleBookmark(String jobId) async {
    await _repository.toggleBookmark(jobId);
    final index = _jobs.indexWhere((j) => j.id == jobId);
    if (index != -1) {
      _jobs[index].isBookmarked = !_jobs[index].isBookmarked;
      notifyListeners();
    }
  }
}
