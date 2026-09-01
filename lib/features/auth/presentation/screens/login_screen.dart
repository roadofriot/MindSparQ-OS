import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/design_system/design_system.dart';
import '../controllers/auth_controller.dart';

/// MindSparQ OS Login Screen
/// Faithfully matching Stitch Screen 2442742cd6c54a28a09a9909bbcf3952
/// Supports responsive layout across Mobile (Android/iOS) and Desktop (Windows/Linux/macOS)
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    final success = await ref
        .read(authControllerProvider.notifier)
        .signInWithEmailPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

    if (mounted) {
      if (success) {
        context.go(RouteConstants.dashboard);
      } else {
        final authState = ref.read(authControllerProvider);
        authState.whenOrNull(
          error: (error, _) {
            setState(() {
              _errorMessage = error.toString().replaceFirst('AuthException: ', '').replaceFirst('Exception: ', '');
            });
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;
    final isMobile = AppBreakpoints.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. Ambient Background Atmosphere (Stitch Decorative Elements)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 280,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryFixedDim.withAlpha(50),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            right: -120,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryContainer.withAlpha(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: const SizedBox.expand(),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -120,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tertiaryContainer.withAlpha(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: const SizedBox.expand(),
              ),
            ),
          ),

          // 2. Main Scrollable Container
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 40.0,
                  vertical: 24.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Centered Card
                      Container(
                        padding: EdgeInsets.all(isMobile ? 24.0 : 48.0),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: AppColors.outlineVariant.withAlpha(60),
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08000000),
                              blurRadius: 24,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Brand Logo Header
                              Center(
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x1A004E9F),
                                        blurRadius: 12,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.all_inclusive,
                                    color: AppColors.onPrimary,
                                    size: 34,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // App Title
                              Text(
                                'MindSparQ OS',
                                style: AppTypography.headlineLg.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.01 * 30,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),

                              // Subtitle
                              Text(
                                'तपाईंको खातामा प्रवेश गर्नुहोस्',
                                style: AppTypography.bodyMd.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 28),

                              // Error Banner
                              if (_errorMessage != null) ...[
                                AppBannerCard(
                                  title: 'प्रमाणीकरण त्रुटि (Auth Error)',
                                  message: _errorMessage,
                                  variant: AppBannerVariant.error,
                                ),
                                const SizedBox(height: 16),
                              ],

                              // Email Input
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: AppTypography.bodyMd.copyWith(
                                  color: AppColors.onSurface,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'इमेल ठेगाना',
                                  hintStyle: AppTypography.bodyMd.copyWith(
                                    color: AppColors.onSurfaceVariant.withAlpha(150),
                                    fontSize: 15,
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(left: 16, right: 12),
                                    child: Icon(
                                      Icons.mail_outline,
                                      size: 22,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.surfaceContainerLow,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: AppRadii.roundedXl,
                                    borderSide: BorderSide(
                                      color: AppColors.outlineVariant.withAlpha(120),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: AppRadii.roundedXl,
                                    borderSide: BorderSide(
                                      color: AppColors.outlineVariant.withAlpha(120),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: AppRadii.roundedXl,
                                    borderSide: const BorderSide(
                                      color: AppColors.primaryContainer,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'इमेल आवश्यक छ (Email required)';
                                  }
                                  if (!value.contains('@')) {
                                    return 'मान्य इमेल प्रविष्ट गर्नुहोस् (Invalid email)';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Password Input
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                style: AppTypography.bodyMd.copyWith(
                                  color: AppColors.onSurface,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'पासवर्ड',
                                  hintStyle: AppTypography.bodyMd.copyWith(
                                    color: AppColors.onSurfaceVariant.withAlpha(150),
                                    fontSize: 15,
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(left: 16, right: 12),
                                    child: Icon(
                                      Icons.lock_outline,
                                      size: 22,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 20,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  filled: true,
                                  fillColor: AppColors.surfaceContainerLow,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: AppRadii.roundedXl,
                                    borderSide: BorderSide(
                                      color: AppColors.outlineVariant.withAlpha(120),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: AppRadii.roundedXl,
                                    borderSide: BorderSide(
                                      color: AppColors.outlineVariant.withAlpha(120),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: AppRadii.roundedXl,
                                    borderSide: const BorderSide(
                                      color: AppColors.primaryContainer,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'पासवर्ड आवश्यक छ (Password required)';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),

                              // Forgot Password Link
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('पासवर्ड पुनःप्राप्ति (Password Recovery)'),
                                        content: const Text(
                                          'MindSparQ OS is an institutional operating system. Please contact your campus system administrator to issue a secure password reset credential.',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text('ठीक छ (OK)'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'पासवर्ड बिर्सनुभयो?',
                                    style: AppTypography.labelMd.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Primary Submit Button with Trailing Arrow
                              AppButton(
                                label: 'लगइन गर्नुहोस्',
                                trailingIcon: Icons.arrow_forward,
                                variant: AppButtonVariant.primary,
                                borderRadius: AppRadii.roundedXl,
                                isFullWidth: true,
                                height: 48,
                                isLoading: isLoading,
                                onPressed: isLoading ? null : _handleLogin,
                              ),
                              const SizedBox(height: 24),

                              // "वा (OR)" Divider
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: AppColors.outlineVariant.withAlpha(90),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'वा',
                                      style: AppTypography.labelSm.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        letterSpacing: 0.03 * 11,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: AppColors.outlineVariant.withAlpha(90),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Biometrics CTA
                              Center(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      borderRadius: AppRadii.roundedFull,
                                      child: Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.surface,
                                          border: Border.all(
                                            color: AppColors.outlineVariant.withAlpha(140),
                                            width: 1.0,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x06000000),
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.fingerprint,
                                          size: 34,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      'बायोमेट्रिक प्रयोग गर्नुहोस्',
                                      style: AppTypography.labelSm.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.03 * 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Footer Sign Up Prompt
                      Text.rich(
                        TextSpan(
                          text: 'खाता छैन? ',
                          style: AppTypography.bodyMd.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 14,
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('खाता दर्ता (Account Provisioning)'),
                                      content: const Text(
                                        'MindSparQ OS accounts are provisioned by institutional authority. Please reach out to your school coordinator for onboarding credentials.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('ठीक छ (OK)'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  'साइन अप गर्नुहोस्',
                                  style: AppTypography.labelMd.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
