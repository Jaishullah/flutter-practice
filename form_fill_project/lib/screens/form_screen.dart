import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/form_widgets.dart';
import '../steps/step1_personal_info.dart';
import '../steps/step2_preferences.dart';
import '../steps/step3_settings.dart';
import 'review_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();
  final _step3Key = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  final List<String> _stepTitles = ['Personal', 'Preferences', 'Settings'];
  final List<String> _stepSubtitles = [
    'Basic information',
    'Your choices',
    'Configurations',
  ];

  GlobalKey<FormState> get _currentFormKey {
    switch (_currentStep) {
      case 0: return _step1Key;
      case 1: return _step2Key;
      default: return _step3Key;
    }
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      if (!_step1Key.currentState!.validate()) return false;
    } else if (_currentStep == 1) {
      if (!_step2Key.currentState!.validate()) return false;
    } else {
      if (!_step3Key.currentState!.validate()) return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(message),
        ],
      ),
      backgroundColor: AppColors.error,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16),
    ));
  }

  void _nextStep() {
    if (!_validateCurrentStep()) {
      if (_currentStep == 0) {
        _showError("Please fill all fields in Personal Info correctly");
      } else if (_currentStep == 1) {
        _showError("Please fill all fields in Preferences correctly");
      } else {
        _showError("Please fill all fields in Settings correctly");
      }
      return;
    }
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    } else {
      _submitForm();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    }
  }

  void _submitForm() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ReviewScreen(formData: Map.from(_formData)),
    ));
  }

  void _resetForm() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Text('Reset Form'),
          ],
        ),
        content: const Text(
            'All entered data will be cleared. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _formData.clear();
                _currentStep = 0;
              });
              _step1Key.currentState?.reset();
              _step2Key.currentState?.reset();
              _step3Key.currentState?.reset();
              _pageController.jumpToPage(0);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── App Bar + Step Indicator ──────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x336C63FF),
                  blurRadius: 20,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Professional Form',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Complete all steps to register',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: _resetForm,
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          tooltip: 'Reset Form',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  StepIndicator(
                    currentStep: _currentStep,
                    totalSteps: 3,
                    stepTitles: _stepTitles,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),

          // ── Subtitle ─────────────────────────────────────────────────
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Step ${_currentStep + 1}: ${_stepSubtitles[_currentStep]}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary),
                ),
                const Spacer(),
                Text(
                  '${_currentStep + 1} of 3',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),

          // ── Page Content ─────────────────────────────────────────────
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  child: PersonalInfoStep(
                      formKey: _step1Key, formData: _formData),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  child: PreferencesStep(
                      formKey: _step2Key, formData: _formData),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  child: SettingsStep(
                      formKey: _step3Key, formData: _formData),
                ),
              ],
            ),
          ),
        ],
      ),

      // ── Bottom Navigation Buttons ─────────────────────────────────────
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Back button
            if (_currentStep > 0)
              Expanded(
                flex: 1,
                child: OutlinedButton.icon(
                  onPressed: _prevStep,
                  icon: const Icon(Icons.arrow_back_ios, size: 16),
                  label: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(
                        color: AppColors.primary, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

            if (_currentStep > 0) const SizedBox(width: 12),

            // Next / Submit button
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: _nextStep,
                icon: Icon(
                  _currentStep == 2
                      ? Icons.check_circle_outline
                      : Icons.arrow_forward_ios,
                  size: 18,
                ),
                label: Text(
                  _currentStep == 2 ? 'Submit Form' : 'Next Step',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentStep == 2
                      ? AppColors.success
                      : AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  shadowColor: (_currentStep == 2
                      ? AppColors.success
                      : AppColors.primary)
                      .withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}