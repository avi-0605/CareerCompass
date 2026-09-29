import 'package:flutter/material.dart';
import '../../models/mentor.dart';
import '../../app/routes.dart';

class MentorProfileScreen extends StatelessWidget {
  final Mentor mentor;

  const MentorProfileScreen({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(mentor.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundImage: NetworkImage(mentor.avatarUrl),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      mentor.name,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${mentor.role} at ${mentor.company}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF2563EB),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.stars, color: Color(0xFFF59E0B), size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${mentor.rating}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          ' (${mentor.totalReviews} reviews) • ${mentor.experienceYears} yrs experience',
                          style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // About Mentor
            _buildTitle(theme, 'About Mentor'),
            const SizedBox(height: 8),
            Text(
              mentor.bio,
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Key Expertise
            _buildTitle(theme, 'Areas of Expertise'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: mentor.expertise.map((e) => Chip(
                    label: Text(e),
                    backgroundColor: const Color(0xFFEFF6FF),
                    labelStyle: const TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold),
                  )).toList(),
            ),
            const SizedBox(height: 20),

            // Languages & Background
            _buildTitle(theme, 'Languages'),
            const SizedBox(height: 6),
            Text(mentor.languages.join(', '), style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),

            _buildTitle(theme, 'Career Background'),
            const SizedBox(height: 8),
            Text(mentor.background, style: const TextStyle(fontSize: 14, height: 1.4)),
            const SizedBox(height: 24),

            // Reviews Section
            _buildTitle(theme, 'Mentees Reviews (${mentor.reviews.length})'),
            const SizedBox(height: 12),
            if (mentor.reviews.isEmpty)
              const Text('No reviews written yet.', style: TextStyle(color: Color(0xFF64748B)))
            else
              ...mentor.reviews.map((rev) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(rev.userAvatar),
                              ),
                              const SizedBox(width: 10),
                              Text(rev.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const Spacer(),
                              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 14),
                              const SizedBox(width: 4),
                              Text('${rev.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(rev.comment, style: const TextStyle(fontSize: 12.5, color: Color(0xFF334155))),
                        ],
                      ),
                    ),
                  )),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Session Fee', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                Text(
                  '₹${mentor.pricePerSession} / session',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.mentorBooking, arguments: mentor);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: const Text('Book Session'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(ThemeData theme, String text) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
