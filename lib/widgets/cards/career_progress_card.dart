import 'package:flutter/material.dart';

class CareerProgressCard extends StatelessWidget {
  final int overallPercentage;
  final int resumePercentage;
  final int skillsPercentage;
  final int profilePercentage;
  final String mentorStatus;

  const CareerProgressCard({
    super.key,
    this.overallPercentage = 72,
    this.resumePercentage = 90,
    this.skillsPercentage = 65,
    this.profilePercentage = 80,
    this.mentorStatus = 'Session Scheduled',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Career Readiness',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$overallPercentage%',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                      ),
                    ),
                  ],
                ),
                // Circular Progress Ring
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: overallPercentage / 100,
                        strokeWidth: 8,
                        backgroundColor: Colors.white12,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                      ),
                      Icon(
                        Icons.trending_up,
                        color: Colors.white.withOpacity(0.9),
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 16),
            // Metrics Breakdown Grid
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    context,
                    label: 'Resume',
                    value: '$resumePercentage%',
                    progress: resumePercentage / 100,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricItem(
                    context,
                    label: 'Skills',
                    value: '$skillsPercentage%',
                    progress: skillsPercentage / 100,
                    color: const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricItem(
                    context,
                    label: 'Profile',
                    value: '$profilePercentage%',
                    progress: profilePercentage / 100,
                    color: const Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(
    BuildContext context, {
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
