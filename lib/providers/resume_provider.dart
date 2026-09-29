import 'package:flutter/material.dart';
import '../models/resume.dart';
import '../repositories/resume_repository.dart';

class ResumeProvider extends ChangeNotifier {
  final ResumeRepository _repository;

  Resume? _resume;
  bool _isLoading = false;
  String? _error;

  ResumeProvider(this._repository) {
    loadResume();
  }

  Resume? get resume => _resume;
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get completionPercentage => _resume?.calculateCompletionPercentage() ?? 0;

  Future<void> loadResume() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _resume = await _repository.getResume();
    } catch (e) {
      _error = 'Failed to load resume details.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePersonalInfo({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String linkedIn,
    required String gitHub,
    required String portfolio,
    required String summary,
  }) async {
    if (_resume == null) return;

    _resume!.name = name;
    _resume!.email = email;
    _resume!.phone = phone;
    _resume!.location = location;
    _resume!.linkedIn = linkedIn;
    _resume!.gitHub = gitHub;
    _resume!.portfolio = portfolio;
    _resume!.summary = summary;

    await _repository.saveResume(_resume!);
    notifyListeners();
  }

  void addSkill(String name, SkillLevel level) {
    if (_resume == null) return;
    if (name.trim().isEmpty) return;

    // Avoid duplicate skill names
    if (!_resume!.skills.any((s) => s.name.toLowerCase() == name.trim().toLowerCase())) {
      _resume!.skills.add(Skill(name: name.trim(), level: level));
      _repository.saveResume(_resume!);
      notifyListeners();
    }
  }

  void removeSkill(int index) {
    if (_resume == null) return;
    if (index >= 0 && index < _resume!.skills.length) {
      _resume!.skills.removeAt(index);
      _repository.saveResume(_resume!);
      notifyListeners();
    }
  }

  void addEducation(Education edu) {
    if (_resume == null) return;
    _resume!.education.add(edu);
    _repository.saveResume(_resume!);
    notifyListeners();
  }

  void removeEducation(String id) {
    if (_resume == null) return;
    _resume!.education.removeWhere((e) => e.id == id);
    _repository.saveResume(_resume!);
    notifyListeners();
  }

  void addExperience(Experience exp) {
    if (_resume == null) return;
    _resume!.experience.add(exp);
    _repository.saveResume(_resume!);
    notifyListeners();
  }

  void removeExperience(String id) {
    if (_resume == null) return;
    _resume!.experience.removeWhere((e) => e.id == id);
    _repository.saveResume(_resume!);
    notifyListeners();
  }

  void addProject(Project proj) {
    if (_resume == null) return;
    _resume!.projects.add(proj);
    _repository.saveResume(_resume!);
    notifyListeners();
  }

  void removeProject(String id) {
    if (_resume == null) return;
    _resume!.projects.removeWhere((p) => p.id == id);
    _repository.saveResume(_resume!);
    notifyListeners();
  }

  void addCertification(Certification cert) {
    if (_resume == null) return;
    _resume!.certifications.add(cert);
    _repository.saveResume(_resume!);
    notifyListeners();
  }

  void removeCertification(String id) {
    if (_resume == null) return;
    _resume!.certifications.removeWhere((c) => c.id == id);
    _repository.saveResume(_resume!);
    notifyListeners();
  }
}
