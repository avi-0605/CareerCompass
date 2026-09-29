import 'package:flutter/material.dart';

import '../screens/main_navigation_screen.dart';
import '../screens/resume/resume_builder_screen.dart';
import '../screens/resume/resume_preview_screen.dart';
import '../screens/jobs/job_detail_screen.dart';
import '../screens/assessment/assessment_question_screen.dart';
import '../screens/assessment/assessment_result_screen.dart';
import '../screens/mentors/mentor_profile_screen.dart';
import '../screens/booking/mentor_booking_screen.dart';
import '../models/job.dart';
import '../models/mentor.dart';

class AppRoutes {
  static const String mainNav = '/';
  static const String resumeBuilder = '/resume-builder';
  static const String resumePreview = '/resume-preview';
  static const String jobDetail = '/job-detail';
  static const String assessmentQuestions = '/assessment-questions';
  static const String assessmentResult = '/assessment-result';
  static const String mentorProfile = '/mentor-profile';
  static const String mentorBooking = '/mentor-booking';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainNav:
        final initialIndex = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => MainNavigationScreen(initialIndex: initialIndex),
        );

      case resumeBuilder:
        return MaterialPageRoute(builder: (_) => const ResumeBuilderScreen());

      case resumePreview:
        return MaterialPageRoute(builder: (_) => const ResumePreviewScreen());

      case jobDetail:
        final job = settings.arguments as Job;
        return MaterialPageRoute(
          builder: (_) => JobDetailScreen(job: job),
        );

      case assessmentQuestions:
        return MaterialPageRoute(builder: (_) => const AssessmentQuestionScreen());

      case assessmentResult:
        return MaterialPageRoute(builder: (_) => const AssessmentResultScreen());

      case mentorProfile:
        final mentor = settings.arguments as Mentor;
        return MaterialPageRoute(
          builder: (_) => MentorProfileScreen(mentor: mentor),
        );

      case mentorBooking:
        final mentor = settings.arguments as Mentor;
        return MaterialPageRoute(
          builder: (_) => MentorBookingScreen(mentor: mentor),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
