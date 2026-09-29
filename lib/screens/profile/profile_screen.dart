import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/resume_provider.dart';
import '../../widgets/dialogs/confirmation_dialog.dart';
import '../../app/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final resume = resumeProvider.resume;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.resumeBuilder);
            },
          ),
          const SizedBox(width: 8),
        ],
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
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: const Color(0xFFEFF6FF),
                      child: Text(
                        resume?.name.isNotEmpty == true ? resume!.name.substring(0, 1) : 'A',
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resume?.name ?? 'Aavani Sharma',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            resume?.email ?? 'aavani.sharma@example.com',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            resume?.location ?? 'Bengaluru, India',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Profile Completion Progress Bar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Profile Completion',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const Text(
                          '80%',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2563EB)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: const LinearProgressIndicator(
                        value: 0.8,
                        minHeight: 8,
                        backgroundColor: Color(0xFFF1F5F9),
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Career Interests & Target Role
            _buildSectionHeader(theme, 'Career Interests'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Flutter Development', 'Mobile Architecture', 'UI/UX Prototyping', 'Cloud Backend'].map((interest) {
                return Chip(
                  label: Text(interest),
                  backgroundColor: const Color(0xFFEFF6FF),
                  labelStyle: const TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.w600, fontSize: 12),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Education & Skills Summary
            _buildSectionHeader(theme, 'Education & Skills'),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Education', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(
                      resume?.education.isNotEmpty == true
                          ? '${resume!.education.first.degree} (${resume.education.first.institution})'
                          : 'B.Tech in Computer Science',
                      style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
                    ),
                    const SizedBox(height: 12),
                    const Text('Verified Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: (resume?.skills ?? []).take(5).map((s) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(s.name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                          )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Settings Section
            _buildSectionHeader(theme, 'Settings & Preferences'),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_note, color: Color(0xFF2563EB)),
                    title: const Text('Edit Resume & Profile'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.resumeBuilder),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_outlined, color: Color(0xFF10B981)),
                    title: const Text('Job & Session Alerts'),
                    value: _notificationsEnabled,
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.palette_outlined, color: Color(0xFFF59E0B)),
                    title: const Text('Dark Mode Appearance'),
                    value: _darkMode,
                    onChanged: (val) => setState(() => _darkMode = val),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.shield_outlined, color: Color(0xFF8B5CF6)),
                    title: const Text('Privacy & Security'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy settings: Account data is encrypted.')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Color(0xFFEF4444)),
                    title: const Text('Logout', style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => ConfirmationDialog(
                          title: 'Logout of CareerCompass?',
                          message: 'Are you sure you want to log out of your account?',
                          confirmText: 'Logout',
                          cancelText: 'Cancel',
                          icon: Icons.logout,
                          iconColor: const Color(0xFFEF4444),
                          onConfirm: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged out successfully.')),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
