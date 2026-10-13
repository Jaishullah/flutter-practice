import '../theme/app_theme.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  final Map<String, dynamic> formData;

  const ReviewScreen({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Submission Summary'),
        backgroundColor: AppColors.success,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Success Banner ────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.success, Color(0xFF66BB6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.success.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 64),
                  SizedBox(height: 12),
                  Text(
                    'Form Submitted!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'All your information has been saved',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Data Summary ──────────────────────────────────────────
            _buildSection('👤 Personal Info', [
              _row('First Name', formData['firstName']),
              _row('Last Name', formData['lastName']),
              _row('Email', formData['email']),
              _row('Phone', formData['phone']),
              _row('City', formData['city']),
              _row('Bio', formData['bio']),
            ]),

            _buildSection('🎯 Preferences', [
              _row('Country', formData['country']),
              _row('Role', formData['role']),
              _row('Department', formData['department']),
              _row('Sort Order', formData['sortOrder']),
              _row('Gender', formData['gender']),
              _row('Experience', formData['experience']),
              _row('Interests',
                  (formData['interests'] as List?)?.join(', ')),
            ]),

            _buildSection('⚙️ Settings', [
              _row('Date of Birth', formData['dateOfBirth']),
              _row('Preferred Time', formData['preferredTime']),
              _row('Age', formData['age']?.toString()),
              _row('Exp Years', formData['expYears']?.toString()),
              _row('Salary Range',
                  '${formData['salaryMin'] ?? ''} – ${formData['salaryMax'] ?? ''} PKR'),
              _row('Notifications',
                  (formData['notifications'] ?? false) ? 'Enabled' : 'Disabled'),
              _row('Dark Mode',
                  (formData['darkMode'] ?? false) ? 'On' : 'Off'),
              _row('2FA',
                  (formData['twoFactor'] ?? false) ? 'Enabled' : 'Disabled'),
              _row('Newsletter',
                  (formData['newsletter'] ?? false) ? 'Subscribed' : 'Not subscribed'),
            ]),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () =>
                    Navigator.of(context).popUntil((r) => r.isFirst),
                icon: const Icon(Icons.home_outlined),
                label: const Text('Back to Start'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> rows) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
          ),
          const Divider(height: 1),
          ...rows,
        ],
      ),
    );
  }

  Widget _row(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
