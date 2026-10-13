import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../theme/app_theme.dart';
import '../widgets/form_widgets.dart';

class SettingsStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  const SettingsStep({
    super.key,
    required this.formKey,
    required this.formData,
  });

  @override
  State<SettingsStep> createState() => _SettingsStepState();
}

class _SettingsStepState extends State<SettingsStep> {
  // ── Switch values ────────────────────────────────────────────────────────
  bool _notificationsEnabled = true;
  bool _darkModeEnabled      = false;
  bool _twoFactorEnabled     = false;
  bool _locationEnabled      = false;
  bool _analyticsEnabled     = true;

  // ── Slider values ────────────────────────────────────────────────────────
  double _ageValue         = 25;
  double _experienceYears  = 3;
  RangeValues _salaryRange = const RangeValues(50000, 150000);

  // ── Date / Time ──────────────────────────────────────────────────────────
  DateTime?  _selectedDate;
  TimeOfDay? _selectedTime;

  // ── File Picker ───────────────────────────────────────────────────────────
  String? _profileImageName;
  String? _resumeFileName;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.formData['notifications'] ?? true;
    _darkModeEnabled      = widget.formData['darkMode']      ?? false;
    _twoFactorEnabled     = widget.formData['twoFactor']     ?? false;
    _locationEnabled      = widget.formData['location']      ?? false;
    _analyticsEnabled     = widget.formData['analytics']     ?? true;
    _ageValue             = (widget.formData['age']          ?? 25).toDouble();
    _experienceYears      = (widget.formData['expYears']     ?? 3).toDouble();
    _salaryRange = RangeValues(
      (widget.formData['salaryMin'] ?? 50000).toDouble(),
      (widget.formData['salaryMax'] ?? 150000).toDouble(),
    );
  }

  // ── Pick Profile Image ────────────────────────────────────────────────────
  Future<void> _pickProfileImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() => _profileImageName = result.files.first.name);
      widget.formData['profileImageName'] = result.files.first.name;
      widget.formData['profileImagePath'] = result.files.first.path;
    }
  }

  // ── Pick Resume ───────────────────────────────────────────────────────────
  Future<void> _pickResumeFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() => _resumeFileName = result.files.first.name);
      widget.formData['resumeName'] = result.files.first.name;
      widget.formData['resumePath'] = result.files.first.path;
    }
  }

  // ── Pick Date ─────────────────────────────────────────────────────────────
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      widget.formData['dateOfBirth'] = picked.toIso8601String();
    }
  }

  // ── Pick Time ─────────────────────────────────────────────────────────────
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
      widget.formData['preferredTime'] = picked.format(context);
    }
  }

  String get _formattedDate => _selectedDate == null
      ? 'Select date of birth'
      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';

  String get _formattedTime => _selectedTime == null
      ? 'Select preferred time'
      : _selectedTime!.format(context);

  String _formatSalary(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000)    return '${(v / 1000).toStringAsFixed(0)}K';
    return v.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Profile Photo & Resume ────────────────────────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                    title: 'Profile Photo & Resume',
                    icon: Icons.cloud_upload_outlined),

                // ── Profile Image ─────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      // Avatar circle
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.1),
                          border: Border.all(
                            color: _profileImageName != null
                                ? AppColors.primary
                                : AppColors.border,
                            width: 2,
                          ),
                        ),
                        child: _profileImageName != null
                            ? const Icon(Icons.check_circle,
                            color: AppColors.primary, size: 52)
                            : const Icon(Icons.person,
                            color: AppColors.primary, size: 52),
                      ),

                      const SizedBox(height: 12),

                      // Selected file name badge
                      if (_profileImageName != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.success.withOpacity(0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.image,
                                  color: AppColors.success, size: 14),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  _profileImageName!,
                                  style: const TextStyle(
                                      color: AppColors.success,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Pick button
                      ElevatedButton.icon(
                        onPressed: _pickProfileImage,
                        icon: const Icon(Icons.photo_library_outlined,
                            size: 18),
                        label: Text(_profileImageName != null
                            ? 'Change Photo'
                            : 'Select Profile Photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),

                      const SizedBox(height: 6),
                      const Text('JPG, PNG, GIF supported',
                          style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Resume Picker ─────────────────────────────────────
                const FieldLabel(label: 'Resume / CV'),
                GestureDetector(
                  onTap: _pickResumeFile,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _resumeFileName != null
                          ? AppColors.success.withOpacity(0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _resumeFileName != null
                            ? AppColors.success
                            : AppColors.border,
                        width: _resumeFileName != null ? 2 : 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (_resumeFileName != null
                                ? AppColors.success
                                : AppColors.primary)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            _resumeFileName != null
                                ? Icons.check_circle_outline
                                : Icons.upload_file_outlined,
                            color: _resumeFileName != null
                                ? AppColors.success
                                : AppColors.primary,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _resumeFileName ?? 'Tap to upload resume',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _resumeFileName != null
                                      ? AppColors.success
                                      : AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _resumeFileName != null
                                    ? 'File selected ✓'
                                    : 'PDF, DOC, DOCX — Max 5MB',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _resumeFileName != null
                                      ? AppColors.success
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_resumeFileName != null)
                          IconButton(
                            icon: const Icon(Icons.close,
                                color: AppColors.textSecondary, size: 20),
                            onPressed: () => setState(() {
                              _resumeFileName = null;
                              widget.formData.remove('resumeName');
                              widget.formData.remove('resumePath');
                            }),
                          )
                        else
                          const Icon(Icons.arrow_forward_ios,
                              color: AppColors.textSecondary, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Date & Time Pickers ───────────────────────────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                    title: 'Date & Time Pickers',
                    icon: Icons.calendar_today),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(
                              label: 'Date of Birth', required: true),
                          GestureDetector(
                            onTap: _pickDate,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedDate != null
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: _selectedDate != null ? 2 : 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: _selectedDate != null
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                      size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _formattedDate,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _selectedDate != null
                                            ? AppColors.textPrimary
                                            : AppColors.textSecondary,
                                        fontWeight: _selectedDate != null
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FieldLabel(label: 'Preferred Time'),
                          GestureDetector(
                            onTap: _pickTime,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedTime != null
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: _selectedTime != null ? 2 : 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: _selectedTime != null
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                      size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _formattedTime,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _selectedTime != null
                                            ? AppColors.textPrimary
                                            : AppColors.textSecondary,
                                        fontWeight: _selectedTime != null
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Sliders ───────────────────────────────────────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                    title: 'Sliders & Range', icon: Icons.tune),

                // Age
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FieldLabel(label: 'Age'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('${_ageValue.round()} yrs',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: AppColors.primary.withOpacity(0.2),
                    thumbColor: AppColors.primary,
                    overlayColor: AppColors.primary.withOpacity(0.15),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 10),
                  ),
                  child: Slider(
                    value: _ageValue,
                    min: 16,
                    max: 70,
                    divisions: 54,
                    onChanged: (v) {
                      setState(() => _ageValue = v);
                      widget.formData['age'] = v.round();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('16',
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary)),
                    Text('70',
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary)),
                  ],
                ),

                const SizedBox(height: 20),

                // Experience
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FieldLabel(label: 'Years of Experience'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('${_experienceYears.round()} yrs',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.secondary,
                    inactiveTrackColor:
                    AppColors.secondary.withOpacity(0.2),
                    thumbColor: AppColors.secondary,
                    overlayColor: AppColors.secondary.withOpacity(0.15),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: _experienceYears,
                    min: 0,
                    max: 20,
                    divisions: 20,
                    onChanged: (v) {
                      setState(() => _experienceYears = v);
                      widget.formData['expYears'] = v.round();
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Salary Range
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FieldLabel(label: 'Expected Salary Range'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        '${_formatSalary(_salaryRange.start)} – ${_formatSalary(_salaryRange.end)} PKR',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.primaryDark,
                    inactiveTrackColor:
                    AppColors.primaryDark.withOpacity(0.2),
                    thumbColor: AppColors.primaryDark,
                    overlayColor: AppColors.primaryDark.withOpacity(0.15),
                    rangeThumbShape: const RoundRangeSliderThumbShape(
                        enabledThumbRadius: 10),
                    trackHeight: 4,
                  ),
                  child: RangeSlider(
                    values: _salaryRange,
                    min: 0,
                    max: 500000,
                    divisions: 50,
                    onChanged: (v) {
                      setState(() => _salaryRange = v);
                      widget.formData['salaryMin'] = v.start.round();
                      widget.formData['salaryMax'] = v.end.round();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Switch / SwitchListTile ────────────────────────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                    title: 'Settings Toggles',
                    icon: Icons.toggle_on_outlined),

                _buildSwitchTile(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Receive alerts and reminders',
                  value: _notificationsEnabled,
                  onChanged: (v) {
                    setState(() => _notificationsEnabled = v);
                    widget.formData['notifications'] = v;
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Switch to dark theme',
                  value: _darkModeEnabled,
                  onChanged: (v) {
                    setState(() => _darkModeEnabled = v);
                    widget.formData['darkMode'] = v;
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.security_outlined,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Extra layer of security',
                  value: _twoFactorEnabled,
                  color: AppColors.success,
                  onChanged: (v) {
                    setState(() => _twoFactorEnabled = v);
                    widget.formData['twoFactor'] = v;
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.location_on_outlined,
                  title: 'Location Access',
                  subtitle: 'Allow location-based services',
                  value: _locationEnabled,
                  color: Colors.orange,
                  onChanged: (v) {
                    setState(() => _locationEnabled = v);
                    widget.formData['location'] = v;
                  },
                ),

                // Raw Switch widget
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _analyticsEnabled
                        ? AppColors.primary.withOpacity(0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _analyticsEnabled
                          ? AppColors.primary.withOpacity(0.3)
                          : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.bar_chart,
                            color: AppColors.secondary, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Analytics (raw Switch widget)',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary)),
                            Text('Share usage data to improve app',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      Switch(
                        value: _analyticsEnabled,
                        activeColor: AppColors.secondary,
                        onChanged: (v) {
                          setState(() => _analyticsEnabled = v);
                          widget.formData['analytics'] = v;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? color,
  }) {
    final activeColor = color ?? AppColors.primary;
    return SwitchListTile(
      value: value,
      activeColor: activeColor,
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: activeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: activeColor, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary)),
      subtitle: Text(subtitle,
          style: const TextStyle(
              fontSize: 12, color: AppColors.textSecondary)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      tileColor: value ? activeColor.withOpacity(0.04) : null,
      onChanged: onChanged,
    );
  }
}