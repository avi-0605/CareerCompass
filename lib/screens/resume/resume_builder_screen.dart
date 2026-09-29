import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/resume_provider.dart';
import '../../models/resume.dart';
import '../../app/routes.dart';

class ResumeBuilderScreen extends StatefulWidget {
  const ResumeBuilderScreen({super.key});

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _linkedInController;
  late TextEditingController _gitHubController;
  late TextEditingController _portfolioController;
  late TextEditingController _summaryController;

  // New item controllers for dynamic add forms
  final _skillNameController = TextEditingController();
  SkillLevel _selectedSkillLevel = SkillLevel.intermediate;

  @override
  void initState() {
    super.initState();
    final resume = Provider.of<ResumeProvider>(context, listen: false).resume;
    _nameController = TextEditingController(text: resume?.name ?? '');
    _emailController = TextEditingController(text: resume?.email ?? '');
    _phoneController = TextEditingController(text: resume?.phone ?? '');
    _locationController = TextEditingController(text: resume?.location ?? '');
    _linkedInController = TextEditingController(text: resume?.linkedIn ?? '');
    _gitHubController = TextEditingController(text: resume?.gitHub ?? '');
    _portfolioController = TextEditingController(text: resume?.portfolio ?? '');
    _summaryController = TextEditingController(text: resume?.summary ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _linkedInController.dispose();
    _gitHubController.dispose();
    _portfolioController.dispose();
    _summaryController.dispose();
    _skillNameController.dispose();
    super.dispose();
  }

  void _savePersonalInfo() {
    if (_formKey.currentState!.validate()) {
      Provider.of<ResumeProvider>(context, listen: false).updatePersonalInfo(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        location: _locationController.text.trim(),
        linkedIn: _linkedInController.text.trim(),
        gitHub: _gitHubController.text.trim(),
        portfolio: _portfolioController.text.trim(),
        summary: _summaryController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final resume = resumeProvider.resume;
    final completionPct = resumeProvider.completionPercentage;

    if (resume == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your Resume'),
        actions: [
          TextButton.icon(
            onPressed: () {
              _savePersonalInfo();
              Navigator.pushNamed(context, AppRoutes.resumePreview);
            },
            icon: const Icon(Icons.remove_red_eye, size: 18),
            label: const Text('Preview'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header description & progress bar
              Text(
                "Create a professional resume that highlights your strengths.",
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Resume Completion',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '$completionPct%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: completionPct / 100,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFF1F5F9),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Expansion Panels for Resume Sections
              _buildSectionTile(
                title: 'Personal Information',
                icon: Icons.person_outline,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Full Name *'),
                    validator: (v) => v == null || v.isEmpty ? 'Please enter your full name' : null,
                    onChanged: (_) => _savePersonalInfo(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email *'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null,
                          onChanged: (_) => _savePersonalInfo(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Phone *'),
                          keyboardType: TextInputType.phone,
                          onChanged: (_) => _savePersonalInfo(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Location (City, Country)'),
                    onChanged: (_) => _savePersonalInfo(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _linkedInController,
                          decoration: const InputDecoration(labelText: 'LinkedIn URL'),
                          onChanged: (_) => _savePersonalInfo(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _gitHubController,
                          decoration: const InputDecoration(labelText: 'GitHub URL'),
                          onChanged: (_) => _savePersonalInfo(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _portfolioController,
                    decoration: const InputDecoration(labelText: 'Portfolio Website URL'),
                    onChanged: (_) => _savePersonalInfo(),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              _buildSectionTile(
                title: 'Professional Summary',
                icon: Icons.article_outlined,
                children: [
                  TextFormField(
                    controller: _summaryController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Write a compelling 2-3 sentence overview of your career, key skills, and goals...',
                    ),
                    onChanged: (_) => _savePersonalInfo(),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Skills Section with Level selection
              _buildSectionTile(
                title: 'Skills & Proficiency',
                icon: Icons.star_outline,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: resume.skills.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final skill = entry.value;
                      return Chip(
                        label: Text('${skill.name} (${skill.level.label})'),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => resumeProvider.removeSkill(idx),
                        backgroundColor: const Color(0xFFEFF6FF),
                        labelStyle: const TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _skillNameController,
                          decoration: const InputDecoration(
                            labelText: 'Add Skill (e.g. Flutter)',
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<SkillLevel>(
                          initialValue: _selectedSkillLevel,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                          items: SkillLevel.values.map((lvl) {
                            return DropdownMenuItem(
                              value: lvl,
                              child: Text(lvl.label, style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedSkillLevel = val);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: () {
                          if (_skillNameController.text.trim().isNotEmpty) {
                            resumeProvider.addSkill(_skillNameController.text, _selectedSkillLevel);
                            _skillNameController.clear();
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Education Section
              _buildSectionTile(
                title: 'Education History',
                icon: Icons.school_outlined,
                children: [
                  ...resume.education.map((edu) {
                    return Card(
                      color: const Color(0xFFF8FAFC),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(edu.degree, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${edu.institution} • ${edu.startYear}-${edu.endYear} (${edu.grade})'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => resumeProvider.removeEducation(edu.id),
                        ),
                      ),
                    );
                  }).toList(),
                  OutlinedButton.icon(
                    onPressed: () => _showAddEducationDialog(context, resumeProvider),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Education Entry'),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Experience Section
              _buildSectionTile(
                title: 'Work Experience',
                icon: Icons.work_history_outlined,
                children: [
                  ...resume.experience.map((exp) {
                    return Card(
                      color: const Color(0xFFF8FAFC),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(exp.jobTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${exp.company} (${exp.startDate} - ${exp.endDate})'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => resumeProvider.removeExperience(exp.id),
                        ),
                      ),
                    );
                  }).toList(),
                  OutlinedButton.icon(
                    onPressed: () => _showAddExperienceDialog(context, resumeProvider),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Experience Entry'),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Projects Section
              _buildSectionTile(
                title: 'Key Projects',
                icon: Icons.folder_open_outlined,
                children: [
                  ...resume.projects.map((proj) {
                    return Card(
                      color: const Color(0xFFF8FAFC),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(proj.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${proj.technologies}\n${proj.description}'),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => resumeProvider.removeProject(proj.id),
                        ),
                      ),
                    );
                  }).toList(),
                  OutlinedButton.icon(
                    onPressed: () => _showAddProjectDialog(context, resumeProvider),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Project Entry'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _savePersonalInfo();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Resume draft saved successfully!')),
                        );
                      },
                      child: const Text('Save Draft'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _savePersonalInfo();
                        Navigator.pushNamed(context, AppRoutes.resumePreview);
                      },
                      child: const Text('Preview Resume'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _savePersonalInfo();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Downloading Resume PDF (A4 format)...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                  ),
                  icon: const Icon(Icons.download),
                  label: const Text('Download Resume PDF'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTile({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: Icon(icon, color: const Color(0xFF2563EB)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: children,
      ),
    );
  }

  void _showAddEducationDialog(BuildContext context, ResumeProvider provider) {
    final instCtrl = TextEditingController();
    final degreeCtrl = TextEditingController();
    final fieldCtrl = TextEditingController();
    final startCtrl = TextEditingController();
    final endCtrl = TextEditingController();
    final gradeCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Education'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: instCtrl, decoration: const InputDecoration(labelText: 'Institution')),
              const SizedBox(height: 8),
              TextField(controller: degreeCtrl, decoration: const InputDecoration(labelText: 'Degree')),
              const SizedBox(height: 8),
              TextField(controller: fieldCtrl, decoration: const InputDecoration(labelText: 'Field of Study')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: TextField(controller: startCtrl, decoration: const InputDecoration(labelText: 'Start Year'))),
                  const SizedBox(width: 8),
                  Expanded(child: TextField(controller: endCtrl, decoration: const InputDecoration(labelText: 'End Year'))),
                ],
              ),
              const SizedBox(height: 8),
              TextField(controller: gradeCtrl, decoration: const InputDecoration(labelText: 'Grade / CGPA')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (instCtrl.text.isNotEmpty && degreeCtrl.text.isNotEmpty) {
                provider.addEducation(
                  Education(
                    id: 'edu_${DateTime.now().millisecondsSinceEpoch}',
                    institution: instCtrl.text,
                    degree: degreeCtrl.text,
                    fieldOfStudy: fieldCtrl.text,
                    startYear: startCtrl.text,
                    endYear: endCtrl.text,
                    grade: gradeCtrl.text,
                  ),
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddExperienceDialog(BuildContext context, ResumeProvider provider) {
    final titleCtrl = TextEditingController();
    final compCtrl = TextEditingController();
    final locCtrl = TextEditingController();
    final startCtrl = TextEditingController();
    final endCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Experience'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Job Title')),
              const SizedBox(height: 8),
              TextField(controller: compCtrl, decoration: const InputDecoration(labelText: 'Company')),
              const SizedBox(height: 8),
              TextField(controller: locCtrl, decoration: const InputDecoration(labelText: 'Location')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: TextField(controller: startCtrl, decoration: const InputDecoration(labelText: 'Start Date'))),
                  const SizedBox(width: 8),
                  Expanded(child: TextField(controller: endCtrl, decoration: const InputDecoration(labelText: 'End Date'))),
                ],
              ),
              const SizedBox(height: 8),
              TextField(controller: descCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.isNotEmpty && compCtrl.text.isNotEmpty) {
                provider.addExperience(
                  Experience(
                    id: 'exp_${DateTime.now().millisecondsSinceEpoch}',
                    jobTitle: titleCtrl.text,
                    company: compCtrl.text,
                    location: locCtrl.text,
                    startDate: startCtrl.text,
                    endDate: endCtrl.text,
                    description: descCtrl.text,
                  ),
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context, ResumeProvider provider) {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final techCtrl = TextEditingController();
    final linkCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Project'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Project Name')),
              const SizedBox(height: 8),
              TextField(controller: techCtrl, decoration: const InputDecoration(labelText: 'Technologies Used')),
              const SizedBox(height: 8),
              TextField(controller: linkCtrl, decoration: const InputDecoration(labelText: 'Project Link')),
              const SizedBox(height: 8),
              TextField(controller: descCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                provider.addProject(
                  Project(
                    id: 'proj_${DateTime.now().millisecondsSinceEpoch}',
                    name: nameCtrl.text,
                    description: descCtrl.text,
                    technologies: techCtrl.text,
                    projectLink: linkCtrl.text,
                  ),
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
