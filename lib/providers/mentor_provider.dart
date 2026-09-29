import 'package:flutter/material.dart';
import '../models/mentor.dart';
import '../repositories/mentor_repository.dart';

class MentorProvider extends ChangeNotifier {
  final MentorRepository _repository;

  List<Mentor> _mentors = [];
  bool _isLoading = false;
  String? _error;

  String _searchQuery = '';
  String _selectedExpertise = 'All';

  MentorProvider(this._repository) {
    loadMentors();
  }

  List<Mentor> get mentors => _mentors;
  bool get isLoading => _isLoading;
  String? get error => _error;

  String get searchQuery => _searchQuery;
  String get selectedExpertise => _selectedExpertise;

  Future<void> loadMentors() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _mentors = await _repository.getMentors(
        searchQuery: _searchQuery,
        expertise: _selectedExpertise,
      );
    } catch (e) {
      _error = 'Failed to load mentors.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    loadMentors();
  }

  void setExpertiseFilter(String expertise) {
    _selectedExpertise = expertise;
    loadMentors();
  }
}
