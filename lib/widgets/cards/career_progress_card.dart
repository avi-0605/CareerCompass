import 'package:flutter/material.dart';

class CareerProgressCard extends StatelessWidget {
  final int overallPercentage;
  final int resumePercentage;
  final int skillsPercentage;
  final int profilePercentage;
  final String mentorStatus;

  const CareerProgressCard({
    super.key,
    this.overallPercentage = 84,
    this.resumePercentage = 100,
    this.skillsPercentage = 65,
    this.profilePercentage = 80,
    this.mentorStatus = 'Session Scheduled',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Circular Gauge Meter
              SizedBox(
                width: 82,
                height: 82,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: overallPercentage / 100,
                        strokeWidth: 8,
                        backgroundColor: const Color(0xFFF1F5F9),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF18181B)),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$overallPercentage%',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1917),
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),

              // Title and Growth Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Career Readiness Score',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1917),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Color(0xFF78716C), size: 20),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.trending_up, color: Color(0xFF059669), size: 14),
                          SizedBox(width: 4),
                          Text(
                            '+4% this week',
                            style: TextStyle(
                              color: Color(0xFF059669),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFF5F5F4)),
          const SizedBox(height: 16),

          // 3 Metric Breakdown Items
          Row(
            children: [
              Expanded(
                child: _buildMetricBox(
                  icon: Icons.description_outlined,
                  label: 'Resume',
                  value: '$resumePercentage%',
                  color: const Color(0xFFD97706),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricBox(
                  icon: Icons.bolt_outlined,
                  label: 'Skills',
                  value: '$skillsPercentage%',
                  color: const Color(0xFFD97706),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricBox(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  value: '$profilePercentage%',
                  color: const Color(0xFFD97706),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBox({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAF9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF5F5F4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: const Color(0xFFD97706)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF78716C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C1917),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
