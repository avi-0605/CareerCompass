import '../models/mentor.dart';
import '../data/mock_data.dart';

class MentorRepository {
  final List<Mentor> _mentors = List.from(MockData.mockMentors);

  Future<List<Mentor>> getMentors({String? searchQuery, String? expertise}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _mentors.where((m) {
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        final matchName = m.name.toLowerCase().contains(q);
        final matchRole = m.role.toLowerCase().contains(q);
        final matchCompany = m.company.toLowerCase().contains(q);
        final matchExpertise = m.expertise.any((e) => e.toLowerCase().contains(q));
        if (!matchName && !matchRole && !matchCompany && !matchExpertise) {
          return false;
        }
      }

      if (expertise != null && expertise != 'All' && expertise.isNotEmpty) {
        if (!m.expertise.any((e) => e.toLowerCase() == expertise.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  Future<Mentor?> getMentorById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _mentors.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }
}
