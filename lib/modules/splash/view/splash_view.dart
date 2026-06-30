import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/alive_logo.dart';
import '../viewmodel/splash_viewmodel.dart';

/// Animated splash screen.
///
/// The logo fades + scales in with an elastic "pop", a tagline slides up, and a
/// soft pulsing ring breathes behind the mark — a smooth, branded intro.
class SplashView extends GetView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the view-model is instantiated so navigation kicks off.
    controller;
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: _SplashBody(),
    );
  }
}

class _SplashBody extends StatefulWidget {
  const _SplashBody();

  @override
  State<_SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<_SplashBody>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _pulseController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _logoScale = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.65, curve: Curves.elasticOut),
    );
    _logoFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    _textFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
    ));

    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Pulsing ring + popping logo.
          SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (BuildContext context, Widget? child) {
                    final double t = _pulseController.value;
                    return Container(
                      width: 130 + 40 * t,
                      height: 130 + 40 * t,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary
                            .withValues(alpha: 0.18 * (1 - t)),
                      ),
                    );
                  },
                ),
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: const AliveLogo(size: 104),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          // Brand name + tagline slide up.
          SlideTransition(
            position: _textSlide,
            child: FadeTransition(
              opacity: _textFade,
              child: Column(
                children: <Widget>[
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Go live. Stay alive.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
