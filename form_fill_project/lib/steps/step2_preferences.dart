import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/form_widgets.dart';

class PreferencesStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  const PreferencesStep({
    super.key,
    required this.formKey,
    required this.formData,
  });

  @override
  State<PreferencesStep> createState() => _PreferencesStepState();
}

class _PreferencesStepState extends State<PreferencesStep> {
  // ── Dropdown values ──────────────────────────────────────────────────────
  String? _selectedCountry;
  String? _selectedRole;
  String? _selectedDropdownMenuValue;

  // ── Radio value ──────────────────────────────────────────────────────────
  String _selectedGender = '';
  String _selectedExperience = '';

  // ── Checkbox values ──────────────────────────────────────────────────────
  final Set<String> _interests = {};
  bool _termsAccepted = false;
  bool _newsletterSubscribed = false;

  // ── Data lists ───────────────────────────────────────────────────────────
  static const List<String> _countries = [
    'Pakistan', 'Saudi Arabia', 'UAE', 'USA', 'UK',
    'Canada', 'Germany', 'Australia', 'Turkey', 'Malaysia',
  ];

  static const List<String> _roles = [
    'Flutter Developer', 'Backend Developer', 'UI/UX Designer',
    'Product Manager', 'Data Scientist', 'DevOps Engineer',
    'Freelancer', 'Student',
  ];

  static const List<String> _departments = [
    'Engineering', 'Marketing', 'Sales', 'Design',
    'HR', 'Finance', 'Support',
  ];

  static const List<Map<String, dynamic>> _interestOptions = [
    {'label': 'Mobile Development', 'icon': Icons.phone_android},
    {'label': 'Web Development',    'icon': Icons.web},
    {'label': 'AI / ML',            'icon': Icons.psychology},
    {'label': 'Cybersecurity',      'icon': Icons.security},
    {'label': 'Cloud Computing',    'icon': Icons.cloud},
    {'label': 'Blockchain',         'icon': Icons.link},
  ];

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.formData['country'];
    _selectedRole    = widget.formData['role'];
    _selectedGender  = widget.formData['gender'] ?? '';
    _selectedExperience = widget.formData['experience'] ?? '';
    _interests.addAll(List<String>.from(widget.formData['interests'] ?? []));
    _termsAccepted   = widget.formData['termsAccepted'] ?? false;
    _newsletterSubscribed = widget.formData['newsletter'] ?? false;
    _selectedDropdownMenuValue = widget.formData['department'];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. DropdownButtonFormField (inside Form) ──────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'DropdownButtonFormField',
                  icon: Icons.arrow_drop_down_circle_outlined,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.primary, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Best for forms — supports validation',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                const FieldLabel(label: 'Country', required: true),
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  validator: (v) => v == null ? 'Please select a country' : null,
                  decoration: InputDecoration(
                    hintText: 'Select your country',
                    prefixIcon:
                        const Icon(Icons.flag_outlined, color: AppColors.primary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.error, width: 2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.disabled, width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  items: _countries.map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c, style: const TextStyle(fontSize: 14)),
                  )).toList(),
                  onChanged: (v) {
                    setState(() => _selectedCountry = v);
                    widget.formData['country'] = v;
                  },
                ),

                const SizedBox(height: 16),

                const FieldLabel(label: 'Role / Profession', required: true),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  validator: (v) => v == null ? 'Please select your role' : null,
                  decoration: InputDecoration(
                    hintText: 'Select your role',
                    prefixIcon:
                        const Icon(Icons.work_outline, color: AppColors.primary),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.error, width: 2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.disabled, width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  items: _roles.map((r) => DropdownMenuItem(
                    value: r,
                    child: Text(r, style: const TextStyle(fontSize: 14)),
                  )).toList(),
                  onChanged: (v) {
                    setState(() => _selectedRole = v);
                    widget.formData['role'] = v;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── 2. DropdownButton (standalone) ───────────────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'DropdownButton (Standalone)',
                  icon: Icons.arrow_drop_down,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Outside Form — no built-in validation',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const FieldLabel(label: 'Sort Order (Standalone Usage)'),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: DropdownButton<String>(
                    value: widget.formData['sortOrder'] ?? 'Newest First',
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    items: ['Newest First', 'Oldest First', 'A-Z', 'Z-A', 'Most Popular']
                        .map((v) => DropdownMenuItem(
                              value: v,
                              child: Row(
                                children: [
                                  const Icon(Icons.sort, color: AppColors.primary, size: 18),
                                  const SizedBox(width: 10),
                                  Text(v, style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => widget.formData['sortOrder'] = v),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── 3. DropdownMenu (Material 3 / searchable) ─────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'DropdownMenu (Material 3)',
                  icon: Icons.menu_open,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.secondary, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Searchable, Material 3 — best for long lists',
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const FieldLabel(label: 'Department (Searchable)'),
                DropdownMenu<String>(
                  initialSelection: _selectedDropdownMenuValue,
                  width: double.infinity,
                  enableFilter: true,
                  enableSearch: true,
                  hintText: 'Search department...',
                  leadingIcon: const Icon(Icons.business_center_outlined,
                      color: AppColors.primary),
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                  ),
                  dropdownMenuEntries: _departments
                      .map((d) => DropdownMenuEntry(
                            value: d,
                            label: d,
                            leadingIcon: const Icon(Icons.arrow_right,
                                color: AppColors.primary, size: 16),
                          ))
                      .toList(),
                  onSelected: (v) {
                    setState(() => _selectedDropdownMenuValue = v);
                    widget.formData['department'] = v;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Radio Buttons ────────────────────────────────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Radio Buttons', icon: Icons.radio_button_checked),

                // Radio (custom styled)
                const FieldLabel(label: 'Gender', required: true),
                Row(
                  children: ['Male', 'Female', 'Other'].map((g) {
                    final selected = _selectedGender == g;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedGender = g);
                          widget.formData['gender'] = g;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary.withOpacity(0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected ? AppColors.primary : AppColors.border,
                              width: selected ? 2 : 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                g == 'Male'
                                    ? Icons.male
                                    : g == 'Female'
                                        ? Icons.female
                                        : Icons.transgender,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                size: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                g,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: selected
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (_selectedGender.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      'Please select gender',
                      style: TextStyle(color: AppColors.error, fontSize: 12),
                    ),
                  ),

                const SizedBox(height: 20),

                // RadioListTile
                const FieldLabel(label: 'Experience Level', required: true),
                ...['Beginner (0-1 yr)', 'Intermediate (2-4 yr)',
                    'Senior (5-8 yr)', 'Expert (8+ yr)']
                    .map((exp) => RadioListTile<String>(
                          value: exp,
                          groupValue: _selectedExperience,
                          title: Text(exp,
                              style: const TextStyle(
                                  fontSize: 14, color: AppColors.textPrimary)),
                          activeColor: AppColors.primary,
                          dense: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          tileColor: _selectedExperience == exp
                              ? Colors.yellow.withOpacity(0.05)
                              : null,
                          onChanged: (v) {
                            setState(() => _selectedExperience = v!);
                            widget.formData['experience'] = v;
                          },
                        )),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Checkboxes ───────────────────────────────────────────────
          FormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Checkboxes', icon: Icons.check_box_outlined),

                const FieldLabel(label: 'Areas of Interest (select all that apply)'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _interestOptions.map((opt) {
                    final label = opt['label'] as String;
                    final icon  = opt['icon'] as IconData;
                    final selected = _interests.contains(label);
                    return FilterChip(
                      label: Text(label,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected ? AppColors.primary : AppColors.textSecondary,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          )),
                      avatar: Icon(icon,
                          size: 16,
                          color: selected
                              ? AppColors.primary
                              : AppColors.textSecondary),
                      selected: selected,
                      selectedColor: AppColors.primary.withOpacity(0.1),
                      checkmarkColor: AppColors.primary,
                      side: BorderSide(
                        color: selected ? AppColors.primary : AppColors.border,
                        width: selected ? 1.5 : 1,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onSelected: (v) {
                        setState(() {
                          v ? _interests.add(label) : _interests.remove(label);
                          widget.formData['interests'] = _interests.toList();
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // CheckboxListTile
                CheckboxListTile(
                  value: _newsletterSubscribed,
                  activeColor: AppColors.primary,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  tileColor: _newsletterSubscribed
                      ? AppColors.primary.withOpacity(0.05)
                      : null,
                  title: const Text('Subscribe to newsletter',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textPrimary)),
                  subtitle: const Text('Get weekly tips and tutorials',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary)),
                  secondary:
                      const Icon(Icons.mail_outline, color: AppColors.primary),
                  onChanged: (v) {
                    setState(() => _newsletterSubscribed = v!);
                    widget.formData['newsletter'] = v;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                CheckboxListTile(
                  value: _termsAccepted,
                  activeColor: AppColors.primary,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  tileColor: _termsAccepted
                      ? AppColors.primary.withOpacity(0.05)
                      : null,
                  title: RichText(
                    text: const TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textPrimary),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  secondary:
                      const Icon(Icons.gavel, color: AppColors.primary),
                  onChanged: (v) {
                    setState(() => _termsAccepted = v!);
                    widget.formData['termsAccepted'] = v;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
