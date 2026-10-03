import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';
import 'routes.dart';

import '../repositories/auth_repository.dart';
import '../repositories/resume_repository.dart';
import '../repositories/job_repository.dart';
import '../repositories/assessment_repository.dart';
import '../repositories/mentor_repository.dart';
import '../repositories/booking_repository.dart';

import '../providers/auth_provider.dart';
import '../providers/resume_provider.dart';
import '../providers/job_provider.dart';
import '../providers/assessment_provider.dart';
import '../providers/mentor_provider.dart';
import '../providers/booking_provider.dart';

class CareerCompassApp extends StatelessWidget {
  const CareerCompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => ResumeProvider(ResumeRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => JobProvider(JobRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => AssessmentProvider(AssessmentRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => MentorProvider(MentorRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingProvider(BookingRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'CareerCompass',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
