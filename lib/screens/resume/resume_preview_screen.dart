import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/resume_provider.dart';

class ResumePreviewScreen extends StatelessWidget {
  const ResumePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final resume = resumeProvider.resume;

    if (resume == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Edit Resume',
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading Resume PDF (A4 format)...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'Download PDF',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resume Header (Name & Contact)
                Text(
                  resume.name.isNotEmpty ? resume.name : 'Your Name',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    if (resume.email.isNotEmpty) _buildContactItem(Icons.email_outlined, resume.email),
                    if (resume.phone.isNotEmpty) _buildContactItem(Icons.phone_outlined, resume.phone),
                    if (resume.location.isNotEmpty) _buildContactItem(Icons.location_on_outlined, resume.location),
                    if (resume.linkedIn.isNotEmpty) _buildContactItem(Icons.link, resume.linkedIn),
                    if (resume.gitHub.isNotEmpty) _buildContactItem(Icons.code, resume.gitHub),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF0F172A), thickness: 1.5),
                const SizedBox(height: 16),

                // Professional Summary
                if (resume.summary.isNotEmpty) ...[
                  _buildSectionHeader('PROFESSIONAL SUMMARY'),
                  const SizedBox(height: 8),
                  Text(
                    resume.summary,
                    style: const TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 18),
                ],

                // Experience
                if (resume.experience.isNotEmpty) ...[
                  _buildSectionHeader('WORK EXPERIENCE'),
                  const SizedBox(height: 10),
                  ...resume.experience.map((exp) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  exp.jobTitle,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                                ),
                                Text(
                                  '${exp.startDate} – ${exp.endDate}',
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              '${exp.company} • ${exp.location}',
                              style: const TextStyle(fontSize: 13, color: Color(0xFF2563EB), fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exp.description,
                              style: const TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF475569)),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 12),
                ],

                // Education
                if (resume.education.isNotEmpty) ...[
                  _buildSectionHeader('EDUCATION'),
                  const SizedBox(height: 10),
                  ...resume.education.map((edu) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  edu.institution,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                                ),
                                Text(
                                  '${edu.startYear} – ${edu.endYear}',
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                            Text(
                              '${edu.degree} in ${edu.fieldOfStudy} (${edu.grade})',
                              style: const TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 12),
                ],

                // Skills
                if (resume.skills.isNotEmpty) ...[
                  _buildSectionHeader('SKILLS & COMPETENCIES'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: resume.skills.map((s) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            '${s.name} (${s.level.label})',
                            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                          ),
                        )).toList(),
                  ),
                  const SizedBox(height: 18),
                ],

                // Projects
                if (resume.projects.isNotEmpty) ...[
                  _buildSectionHeader('KEY PROJECTS'),
                  const SizedBox(height: 10),
                  ...resume.projects.map((proj) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              proj.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: Color(0xFF0F172A)),
                            ),
                            Text(
                              'Tech Stack: ${proj.technologies}',
                              style: const TextStyle(fontSize: 12, color: Color(0xFF2563EB)),
                            ),
                            Text(
                              proj.description,
                              style: const TextStyle(fontSize: 12, color: Color(0xFF475569), height: 1.4),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 12),
                ],

                // Certifications
                if (resume.certifications.isNotEmpty) ...[
                  _buildSectionHeader('CERTIFICATIONS'),
                  const SizedBox(height: 10),
                  ...resume.certifications.map((cert) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '• ${cert.name} (${cert.issuingOrganization})',
                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: Color(0xFF334155)),
                            ),
                            Text(
                              cert.date,
                              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      )),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        const Divider(color: Color(0xFFCBD5E1), height: 1),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF64748B)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
      ],
    );
  }
}
