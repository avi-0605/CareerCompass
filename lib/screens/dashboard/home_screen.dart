import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/resume_provider.dart';
import '../../providers/job_provider.dart';
import '../../providers/booking_provider.dart';
import '../../providers/assessment_provider.dart';
import '../../widgets/cards/career_progress_card.dart';
import '../../widgets/cards/quick_action_card.dart';
import '../../widgets/cards/job_card.dart';
import '../../app/routes.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onNavigateTab;

  const HomeScreen({super.key, this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final jobProvider = Provider.of<JobProvider>(context);
    final bookingProvider = Provider.of<BookingProvider>(context);
    final assessmentProvider = Provider.of<AssessmentProvider>(context);

    final upcomingSession = bookingProvider.upcomingSession;
    final resumeCompletion = resumeProvider.completionPercentage;
    final skillCompletion = assessmentProvider.overallSkillCompletionPercentage;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        toolbarHeight: 74,
        titleSpacing: 20,
        backgroundColor: const Color(0xFFF7F5F0),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Good morning,',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          color: const Color(0xFF78716C),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Aavani',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1C1917),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('✨', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Keep building the career you want.",
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF78716C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE7E5E4)),
            ),
            child: const Icon(Icons.notifications_outlined, size: 20, color: Color(0xFF1C1917)),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFFED7AA),
            child: const Text(
              'A',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF9A3412),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await resumeProvider.loadResume();
          await jobProvider.fetchJobs();
          await bookingProvider.loadBookings();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Career Progress Card
              CareerProgressCard(
                overallPercentage: 84,
                resumePercentage: resumeCompletion,
                skillsPercentage: skillCompletion,
                profilePercentage: 80,
                mentorStatus: upcomingSession != null ? 'Scheduled' : 'None',
              ),
              const SizedBox(height: 16),

              // 5-Day Career Growth Streak Banner (Matching reference)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('🔥', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '5-Day Career Growth Streak!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF1C1917),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Complete today\'s assessment to earn +150 XP.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF78716C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFFA8A29E), size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Quick Actions
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C1917),
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.8,
                children: [
                  QuickActionCard(
                    title: 'Build Resume',
                    subtitle: 'Create or improve your resume',
                    icon: Icons.description_outlined,
                    iconColor: const Color(0xFF2563EB),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.resumeBuilder);
                    },
                  ),
                  QuickActionCard(
                    title: 'Assess Skills',
                    subtitle: 'Test your technical & professional skills',
                    icon: Icons.bolt_outlined,
                    iconColor: const Color(0xFF059669),
                    onTap: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(2); // Switch tab to Assessment
                      }
                    },
                  ),
                  QuickActionCard(
                    title: 'Explore Jobs',
                    subtitle: 'Find jobs matching your skills',
                    icon: Icons.work_outline,
                    iconColor: const Color(0xFFD97706),
                    onTap: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(1); // Switch tab to Jobs
                      }
                    },
                  ),
                  QuickActionCard(
                    title: 'Find a Mentor',
                    subtitle: 'Connect with experienced tech leaders',
                    icon: Icons.person_outline,
                    iconColor: const Color(0xFF7C3AED),
                    onTap: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(3); // Switch tab to Mentors
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Upcoming Mentor Session Card
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Mentor Session',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1917),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(3);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('View All >', style: TextStyle(fontSize: 12, color: Color(0xFF78716C))),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (upcomingSession != null)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(upcomingSession.mentorAvatar),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              upcomingSession.mentorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                                color: Color(0xFF1C1917),
                              ),
                            ),
                            Text(
                              upcomingSession.mentorRole,
                              style: const TextStyle(fontSize: 11, color: Color(0xFF78716C)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${DateFormat('EEE, MMM d').format(upcomingSession.date)}  •  ${upcomingSession.timeSlot}',
                              style: const TextStyle(fontSize: 10.5, color: Color(0xFF059669), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Connecting to live virtual session...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF18181B),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Join Lounge', style: TextStyle(fontSize: 11.5)),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFFF5F5F4),
                        child: Icon(Icons.person_outline, color: Color(0xFF78716C), size: 18),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'No upcoming sessions booked.',
                          style: TextStyle(fontSize: 12, color: Color(0xFF78716C)),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (onNavigateTab != null) onNavigateTab!(3);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: const Text('Book Mentor', style: TextStyle(fontSize: 11.5)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              // Recommended Jobs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommended for you',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1917),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (onNavigateTab != null) onNavigateTab!(1);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('View All >', style: TextStyle(fontSize: 12, color: Color(0xFF78716C))),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Job Cards list
              ...jobProvider.jobs.take(3).map((job) {
                return JobCard(
                  job: job,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.jobDetail, arguments: job);
                  },
                  onBookmarkToggle: () {
                    jobProvider.toggleBookmark(job.id);
                  },
                );
              }),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
