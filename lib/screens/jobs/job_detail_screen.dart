import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/job.dart';
import '../../providers/job_provider.dart';
import '../../widgets/dialogs/confirmation_dialog.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final jobProvider = Provider.of<JobProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(job.company),
        actions: [
          IconButton(
            icon: Icon(
              job.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: job.isBookmarked ? const Color(0xFF2563EB) : null,
            ),
            onPressed: () => jobProvider.toggleBookmark(job.id),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        job.companyLogoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(
                            job.company.substring(0, 1),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${job.company} • ${job.location}',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  job.workType,
                                  style: const TextStyle(
                                    color: Color(0xFF2563EB),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                job.salary,
                                style: const TextStyle(
                                  color: Color(0xFF059669),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // About Role
            _buildSectionTitle(theme, 'About the Role'),
            const SizedBox(height: 8),
            Text(
              job.description,
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Key Responsibilities
            _buildSectionTitle(theme, 'Key Responsibilities'),
            const SizedBox(height: 8),
            ...job.responsibilities.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Expanded(
                        child: Text(
                          r,
                          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),

            // Requirements
            _buildSectionTitle(theme, 'Requirements'),
            const SizedBox(height: 8),
            ...job.requirements.map((req) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Expanded(
                        child: Text(
                          req,
                          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),

            // Required Skills
            _buildSectionTitle(theme, 'Required Skills'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: job.skills.map((s) => Chip(
                    label: Text(s),
                    backgroundColor: const Color(0xFFEFF6FF),
                    labelStyle: const TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold),
                  )).toList(),
            ),
            const SizedBox(height: 20),

            // Benefits
            if (job.benefits.isNotEmpty) ...[
              _buildSectionTitle(theme, 'Perks & Benefits'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.benefits.map((b) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, size: 16, color: Color(0xFF10B981)),
                          const SizedBox(width: 6),
                          Text(b, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )).toList(),
              ),
              const SizedBox(height: 30),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => jobProvider.toggleBookmark(job.id),
                icon: Icon(
                  job.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: job.isBookmarked ? const Color(0xFF2563EB) : null,
                ),
                label: Text(job.isBookmarked ? 'Saved' : 'Save Job'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => ConfirmationDialog(
                      title: 'Confirm Application',
                      message: 'Submit your CareerCompass profile & resume for ${job.title} at ${job.company}?',
                      confirmText: 'Submit Application',
                      onConfirm: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Application submitted successfully for ${job.title}!'),
                            backgroundColor: const Color(0xFF10B981),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
