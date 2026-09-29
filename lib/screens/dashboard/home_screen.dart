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

    // Dynamic readiness score calculation
    final overallReadiness = ((resumeCompletion * 0.4) + (skillCompletion * 0.3) + (80 * 0.3)).round();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF10B981)],
                ),
              ),
              child: const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFEEF2FF),
                child: Text(
                  'A',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F46E5),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Good morning, Aavani!',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('✨', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Text(
                  "Let's move your career forward.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notifications: 2 new high-matching Flutter jobs posted!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Stack(
                children: [
                  const Icon(Icons.notifications_outlined, size: 24, color: Color(0xFF0F172A)),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF43F5E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await resumeProvider.loadResume();
          await jobProvider.fetchJobs();
          await bookingProvider.loadBookings();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Career Progress Card
              CareerProgressCard(
                overallPercentage: overallReadiness,
                resumePercentage: resumeCompletion,
                skillsPercentage: skillCompletion,
                profilePercentage: 80,
                mentorStatus: upcomingSession != null ? 'Scheduled' : 'None',
              ),
              const SizedBox(height: 18),

              // Fun Streak Banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF7ED), Color(0xFFFEF3C7)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF59E0B),
                        shape: BoxShape.circle,
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
                              color: Color(0xFF78350F),
                            ),
                          ),
                          Text(
                            'Complete today\'s assessment to earn +150 Career XP.',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: const Color(0xFF92400E).withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Actions
              Text(
                'Quick Actions',
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.35,
                children: [
                  QuickActionCard(
                    title: 'Build Resume',
                    subtitle: 'Create or improve your professional resume',
                    icon: Icons.description_outlined,
                    iconColor: const Color(0xFF3B82F6),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.resumeBuilder);
                    },
                  ),
                  QuickActionCard(
                    title: 'Assess Skills',
                    subtitle: 'Test your technical & professional skills',
                    icon: Icons.quiz_outlined,
                    iconColor: const Color(0xFF10B981),
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
                    iconColor: const Color(0xFFF59E0B),
                    onTap: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(1); // Switch tab to Jobs
                      }
                    },
                  ),
                  QuickActionCard(
                    title: 'Find a Mentor',
                    subtitle: 'Connect with experienced tech leaders',
                    icon: Icons.people_outline,
                    iconColor: const Color(0xFF8B5CF6),
                    onTap: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(3); // Switch tab to Mentors
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Upcoming Mentor Session Card
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Mentor Session',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  if (upcomingSession != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.circle, color: Color(0xFF10B981), size: 8),
                          SizedBox(width: 5),
                          Text(
                            'CONFIRMED',
                            style: TextStyle(
                              color: Color(0xFF047857),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              if (upcomingSession != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(upcomingSession.mentorAvatar),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    upcomingSession.mentorName,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    upcomingSession.mentorRole,
                                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12.5),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                upcomingSession.sessionType.title,
                                style: const TextStyle(
                                  color: Color(0xFF4F46E5),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 15, color: Color(0xFF64748B)),
                                const SizedBox(width: 6),
                                Text(
                                  DateFormat('EEE, MMM d').format(upcomingSession.date),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                const SizedBox(width: 14),
                                const Icon(Icons.access_time, size: 15, color: Color(0xFF64748B)),
                                const SizedBox(width: 6),
                                Text(
                                  upcomingSession.timeSlot,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Connecting to live virtual session lounge...'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              ),
                              icon: const Icon(Icons.video_call, size: 18),
                              label: const Text('Join Lounge'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              else
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.event_available, color: Color(0xFF6366F1), size: 26),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No upcoming sessions',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Book 1-on-1 mentorship with Google & Microsoft engineers.',
                                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (onNavigateTab != null) {
                              onNavigateTab!(3); // Mentors
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          ),
                          child: const Text('Book Mentor'),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 26),

              // Recommended Jobs Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Jobs',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(1); // Jobs
                      }
                    },
                    icon: const Text('View All Jobs', style: TextStyle(fontWeight: FontWeight.bold)),
                    label: const Icon(Icons.arrow_forward, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Job Cards
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
