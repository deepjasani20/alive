import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/alive_logo.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/google_g_logo.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/social_button.dart';
import '../../../widgets/wave_clipper.dart';
import '../viewmodel/login_viewmodel.dart';

/// Pixel-matched Login screen.
///
/// White upper half holds the brand + sign-in form; a clipped green wave anchors
/// the social providers at the bottom. Everything fades and slides in via a
/// single staggered controller.
class LoginView extends GetView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: _LoginBody(),
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Builds a fade + slide-up transition over [child] for the given stagger
  /// window [begin]‥[end] within the shared controller's timeline.
  Widget _staggered({
    required double begin,
    required double end,
    required Widget child,
  }) {
    final Animation<double> fade = CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOut),
    );
    final Animation<Offset> slide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    ));
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel vm = controllerOf(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double screenH = constraints.maxHeight;

        // The green panel sizes to a fraction of the screen but is clamped so
        // it never gets too short (content would clip) on small phones or too
        // tall on large tablets.
        final double panelHeight = (screenH * 0.40).clamp(320.0, 460.0);

        // Vertical overlap of the Login button onto the green wave crest.
        const double buttonLift = 30;

        // On tablets / large screens, keep the form a comfortable phone width
        // and centre it instead of stretching edge-to-edge.
        const double maxContentWidth = 520;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: SizedBox(
              height: screenH,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  // ---- Bottom green wave (background) + social providers ----
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: panelHeight,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: AppColors.waveGradient,
                          ),
                        ),
                        // Reserve room at the top for the Login button (which is
                        // drawn in a separate, un-clipped layer above), then keep
                        // the providers vertically centred in what's left.
                        child: SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 58, 24, 12),
                            child: Center(
                              child: SingleChildScrollView(
                                child: _staggered(
                                  begin: 0.45,
                                  end: 1.0,
                                  child: _SocialSection(vm: vm),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ---- Foreground: brand + form (scrolls if space is tight) --
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: panelHeight + (58 - buttonLift) + 8,
                    child: SafeArea(
                      bottom: false,
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints formC) {
                          final double topPad = context.h(18);
                          return SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(28, topPad, 28, 8),
                            child: ConstrainedBox(
                              // Centre the form when there's spare height (tablets)
                              // while still scrolling when space is tight (small
                              // phones).
                              constraints: BoxConstraints(
                                minHeight: formC.maxHeight - topPad - 8,
                              ),
                              child: Center(child: _buildForm(vm)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // ---- Login button straddling the crest (un-clipped, on top) -
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: panelHeight - buttonLift,
                    child: _staggered(
                      begin: 0.4,
                      end: 0.85,
                      child: PrimaryButton(
                        label: AppStrings.login,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// The brand mark, greeting and the email / password fields.
  Widget _buildForm(LoginViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _staggered(
          begin: 0.0,
          end: 0.45,
          child: const Center(child: AliveLogo(size: 60)),
        ),
        SizedBox(height: context.h(14)),
        _staggered(
          begin: 0.1,
          end: 0.55,
          child: Column(
            children: <Widget>[
              Text(
                '${AppStrings.welcomeBack} 👋',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.loginSubtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),
            ],
          ),
        ),
        SizedBox(height: context.h(20)),
        _staggered(
          begin: 0.2,
          end: 0.65,
          child: AppTextField(
            label: AppStrings.emailLabel,
            hint: AppStrings.emailHint,
            controller: vm.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: context.h(14)),
        _staggered(
          begin: 0.28,
          end: 0.73,
          child: Obx(
            () => AppTextField(
              label: AppStrings.passwordLabel,
              hint: AppStrings.passwordHint,
              controller: vm.passwordController,
              obscureText: vm.obscurePassword.value,
              suffix: IconButton(
                onPressed: vm.togglePasswordVisibility,
                icon: Icon(
                  vm.obscurePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.hint,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: context.h(12)),
        _staggered(
          begin: 0.34,
          end: 0.78,
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                AppStrings.forgotPassword,
                style: AppTextStyles.link,
              ),
            ),
          ),
        ),
      ],
    );
  }

  LoginViewModel controllerOf(BuildContext context) => Get.find();
}

/// The "or continue with" divider plus the Google / Facebook buttons and the
/// sign-up prompt, all rendered in white over the green wave.
class _SocialSection extends StatelessWidget {
  const _SocialSection({required this.vm});

  final LoginViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(child: _FadedDivider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                AppStrings.orContinueWith,
                style: AppTextStyles.socialButton
                    .copyWith(color: AppColors.white, fontSize: 13),
              ),
            ),
            const Expanded(child: _FadedDivider(reversed: true)),
          ],
        ),
        SizedBox(height: context.h(16)),
        Obx(
          () => SocialButton(
            label: AppStrings.continueWithGoogle,
            icon: const GoogleGLogo(size: 22),
            isLoading: vm.isGoogleLoading.value,
            onPressed: vm.signInWithGoogle,
          ),
        ),
        SizedBox(height: context.h(14)),
        SocialButton(
          label: AppStrings.continueWithFacebook,
          icon: const Icon(
            Icons.facebook,
            color: AppColors.facebookBlue,
            size: 24,
          ),
          onPressed: vm.signInWithFacebook,
        ),
        SizedBox(height: context.h(14)),
        Text.rich(
          TextSpan(
            text: AppStrings.noAccount,
            style: AppTextStyles.socialButton
                .copyWith(color: AppColors.white, fontWeight: FontWeight.w500),
            children: <InlineSpan>[
              TextSpan(
                text: AppStrings.signUp,
                style: AppTextStyles.socialButton.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A thin horizontal line that fades toward the centre text.
class _FadedDivider extends StatelessWidget {
  const _FadedDivider({this.reversed = false});

  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: reversed ? Alignment.centerRight : Alignment.centerLeft,
          end: reversed ? Alignment.centerLeft : Alignment.centerRight,
          colors: <Color>[
            AppColors.white.withValues(alpha: 0.0),
            AppColors.white.withValues(alpha: 0.7),
          ],
        ),
      ),
    );
  }
}
