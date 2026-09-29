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

    // Overall career readiness dynamic calculation
    final overallReadiness = ((resumeCompletion * 0.4) + (skillCompletion * 0.3) + (80 * 0.3)).round();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFFEFF6FF),
              child: const Icon(Icons.person, color: Color(0xFF2563EB)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning, Aavani!',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Let's move your career forward.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications: You have 2 new job matches!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, size: 26),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
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
                    iconColor: const Color(0xFF2563EB),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.resumeBuilder);
                    },
                  ),
                  QuickActionCard(
                    title: 'Assess Skills',
                    subtitle: 'Test your technical and professional skills',
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
                    subtitle: 'Connect with experienced professionals',
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
              Text(
                'Upcoming Mentor Session',
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 12),
              if (upcomingSession != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
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
                                    ),
                                  ),
                                  Text(
                                    upcomingSession.mentorRole,
                                    style: theme.textTheme.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                upcomingSession.sessionType.title,
                                style: const TextStyle(
                                  color: Color(0xFF059669),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Divider(height: 1),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16, color: Color(0xFF64748B)),
                                const SizedBox(width: 6),
                                Text(
                                  DateFormat('EEE, MMM d').format(upcomingSession.date),
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.access_time, size: 16, color: Color(0xFF64748B)),
                                const SizedBox(width: 6),
                                Text(
                                  upcomingSession.timeSlot,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Joining virtual room for session...'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2563EB),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: const Text('Join Session'),
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
                          child: const Icon(Icons.event_busy, color: Color(0xFF64748B)),
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
                                'Book a session with top industry mentors to get tailored advice.',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            if (onNavigateTab != null) {
                              onNavigateTab!(3); // Mentors
                            }
                          },
                          child: const Text('Book Mentor'),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // Recommended Jobs Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Jobs',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      if (onNavigateTab != null) {
                        onNavigateTab!(1); // Jobs
                      }
                    },
                    child: const Text('View All Jobs'),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // 2–3 Job Cards
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
              }).toList(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
