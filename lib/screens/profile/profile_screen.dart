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
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final resume = resumeProvider.resume;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFFF7F5F0),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account Settings')),
              );
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
            // Profile Header
            Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: const Color(0xFFFED7AA),
                  child: Text(
                    resume?.name.isNotEmpty == true ? resume!.name.substring(0, 1) : 'A',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF9A3412)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resume?.name ?? 'Aavani Sharma',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1917),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 13, color: Color(0xFF78716C)),
                          const SizedBox(width: 4),
                          Text(
                            resume?.email ?? 'aavani.sharma@example.com',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF78716C)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF78716C)),
                          const SizedBox(width: 4),
                          Text(
                            resume?.location ?? 'Bengaluru, Karnataka',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF78716C)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Profile Completion Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile Completion',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: Color(0xFF1C1917)),
                      ),
                      Text(
                        '80%',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: Color(0xFF18181B)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: const LinearProgressIndicator(
                      value: 0.8,
                      minHeight: 7,
                      backgroundColor: Color(0xFFF5F5F4),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF18181B)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Hero Dark Progress Banner (Matching Reference Screen 8)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF18181B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your progress,\nYour future.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Build skills. Earn XP. Unlock opportunities.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildStatBox('5', 'Assessments\nCompleted', Icons.workspace_premium)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatBox('3', 'Mentors\nConnected', Icons.bolt)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatBox('12', 'Jobs\nApplied', Icons.work)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Career Interests
            const Text('Career Interests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1C1917))),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Flutter Development', 'Mobile Architecture', 'UI/UX Prototyping', 'Cloud Backend'].map((interest) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    interest,
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF44403C)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Education & Skills Summary Card
            const Text('Education & Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1C1917))),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.school_outlined, size: 18, color: Color(0xFF1C1917)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resume?.education.isNotEmpty == true
                                  ? resume!.education.first.degree
                                  : 'B.Tech - Computer Science',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: Color(0xFF1C1917)),
                            ),
                            Text(
                              resume?.education.isNotEmpty == true
                                  ? resume!.education.first.institution
                                  : 'Indian Institute of Technology, Bangalore',
                              style: const TextStyle(fontSize: 11.5, color: Color(0xFF78716C)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFFA8A29E), size: 18),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text('Verified Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF78716C))),
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
                          child: Text(s.name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                        )).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Recent Activity Section (Matching Reference Screen 8)
            const Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1C1917))),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
              ),
              child: Column(
                children: [
                  _buildActivityRow('Completed Flutter Development Assessment', '+150 XP • 2 hours ago', Icons.quiz_outlined, const Color(0xFF059669)),
                  const Divider(height: 16, color: Color(0xFFF5F5F4)),
                  _buildActivityRow('Updated your profile details', '+50 XP • 5 hours ago', Icons.person_outline, const Color(0xFF2563EB)),
                  const Divider(height: 16, color: Color(0xFFF5F5F4)),
                  _buildActivityRow('Connected with Rahul Sharma', '+100 XP • 1 day ago', Icons.people_outline, const Color(0xFFD97706)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings Section
            const Text('Settings & Preferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1C1917))),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7E5E4), width: 1.2),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_note, color: Color(0xFF1C1917)),
                    title: const Text('Edit Resume & Profile', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.chevron_right, color: Color(0xFFA8A29E)),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.resumeBuilder),
                  ),
                  const Divider(height: 1, color: Color(0xFFF5F5F4)),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_outlined, color: Color(0xFF059669)),
                    title: const Text('Notifications', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    value: _notificationsEnabled,
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                  ),
                  const Divider(height: 1, color: Color(0xFFF5F5F4)),
                  SwitchListTile(
                    secondary: const Icon(Icons.palette_outlined, color: Color(0xFFD97706)),
                    title: const Text('Dark Mode', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                    value: _darkMode,
                    onChanged: (val) => setState(() => _darkMode = val),
                  ),
                  const Divider(height: 1, color: Color(0xFFF5F5F4)),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Color(0xFFE11D48)),
                    title: const Text('Logout', style: TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.bold, fontSize: 13.5)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => ConfirmationDialog(
                          title: 'Logout of CareerCompass?',
                          message: 'Are you sure you want to log out of your account?',
                          confirmText: 'Logout',
                          cancelText: 'Cancel',
                          icon: Icons.logout,
                          iconColor: const Color(0xFFE11D48),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String count, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: Colors.white70),
              const SizedBox(width: 4),
              Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 9.5, color: Colors.white.withValues(alpha: 0.8), height: 1.2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(String title, String subtitle, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5, color: Color(0xFF1C1917))),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF78716C))),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Color(0xFFA8A29E), size: 18),
      ],
    );
  }
}
