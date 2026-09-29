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

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Logo, Title, Company, Bookmark
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        job.companyLogoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF1E1B4B),
                          child: Center(
                            child: Text(
                              job.company.substring(0, 1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
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
                              fontSize: 16,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                job.company,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4F46E5),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text('•', style: TextStyle(color: Color(0xFFCBD5E1))),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  job.location,
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12.5),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onBookmarkToggle,
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: job.isBookmarked
                              ? const Color(0xFFEEF2FF)
                              : const Color(0xFFF8FAFC),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: job.isBookmarked
                                ? const Color(0xFF6366F1)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Icon(
                          job.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          size: 18,
                          color: job.isBookmarked
                              ? const Color(0xFF4F46E5)
                              : const Color(0xFF94A3B8),
                        ),
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
                    _buildPillTag(
                      context,
                      label: job.workType == 'Remote'
                          ? '🌐 ${job.workType}'
                          : job.workType == 'Hybrid'
                              ? '⚡ ${job.workType}'
                              : '🏢 ${job.workType}',
                      color: const Color(0xFFEEF2FF),
                      textColor: const Color(0xFF4F46E5),
                    ),
                    _buildPillTag(
                      context,
                      label: '💰 ${job.salary}',
                      color: const Color(0xFFECFDF5),
                      textColor: const Color(0xFF047857),
                    ),
                    _buildPillTag(
                      context,
                      label: '💼 ${job.experience}',
                      color: const Color(0xFFF8FAFC),
                      textColor: const Color(0xFF475569),
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
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          skill,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF334155),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPillTag(
    BuildContext context, {
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
