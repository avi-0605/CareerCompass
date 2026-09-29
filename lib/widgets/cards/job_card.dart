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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Logo Avatar Box
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _getCompanyBgColor(job.company),
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.5,
                              color: Color(0xFF1C1917),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${job.company}  •  ${job.location}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF78716C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Color(0xFFA8A29E),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Badges: Salary Tag (Green pill) & Experience
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.payments_outlined, size: 13, color: Color(0xFF059669)),
                          const SizedBox(width: 4),
                          Text(
                            job.salary,
                            style: const TextStyle(
                              color: Color(0xFF059669),
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.work_outline, size: 13, color: Color(0xFF78716C)),
                          const SizedBox(width: 4),
                          Text(
                            job.experience,
                            style: const TextStyle(
                              color: Color(0xFF78716C),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Skills chips
                if (job.skills.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: job.skills.take(3).map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
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
      ),
    );
  }

  Color _getCompanyBgColor(String company) {
    switch (company.toLowerCase()) {
      case 'google':
        return const Color(0xFFEA4335);
      case 'swiggy':
        return const Color(0xFFFC8019);
      case 'razorpay':
        return const Color(0xFF0C2340);
      case 'cred':
        return const Color(0xFF18181B);
      case 'zomato':
        return const Color(0xFFE23744);
      default:
        return const Color(0xFF18181B);
    }
  }
}
