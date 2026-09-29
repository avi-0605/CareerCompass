import 'package:flutter/material.dart';
import '../../models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  final VoidCallback onBookmarkToggle;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Company Logo, Title, Company, Bookmark
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      job.companyLogoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFF1E293B),
                        child: Center(
                          child: Text(
                            job.company.substring(0, 1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${job.company} • ${job.location}',
                          style: theme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onBookmarkToggle,
                    icon: Icon(
                      job.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: job.isBookmarked ? const Color(0xFF2563EB) : const Color(0xFF94A3B8),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Badges: Work Type, Salary, Experience
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildChip(
                    context,
                    label: job.workType,
                    color: const Color(0xFFEFF6FF),
                    textColor: const Color(0xFF2563EB),
                  ),
                  _buildChip(
                    context,
                    label: job.salary,
                    color: const Color(0xFFECFDF5),
                    textColor: const Color(0xFF059669),
                  ),
                  _buildChip(
                    context,
                    label: job.experience,
                    color: const Color(0xFFF8FAFC),
                    textColor: const Color(0xFF64748B),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Skills preview chips
              if (job.skills.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: job.skills.take(3).map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
