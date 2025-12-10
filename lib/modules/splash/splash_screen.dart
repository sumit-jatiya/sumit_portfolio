// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:async';
// import 'dart:math' as math;
//
// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   ConsumerState<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends ConsumerState<SplashScreen>
//     with TickerProviderStateMixin {
//
//   // --- Animation Controllers and Tweens ---
//   late AnimationController _shimmerController;      // Controls the logo/text shimmer
//   late AnimationController _codeFlowController;     // Controls the continuous background code movement
//
//   late Animation<double> _shimmerAnimation;         // 0.0 to 1.0 for shimmer position
//   late Animation<double> _entranceAnimation;        // Logo and text initial scale/fade
//   late Animation<Offset> _flowAnimation;            // Background code flow
//
//   // Define durations
//   static const Duration _shimmerDuration = Duration(milliseconds: 1500);
//   static const Duration _entranceDuration = Duration(milliseconds: 1000);
//   static const Duration _flowDuration = Duration(seconds: 8); // Slow, continuous flow
//   static const Duration _navigationDelay = Duration(milliseconds: 3000);
//
//   // Hardcoded futuristic colors for this UI concept
//   static const Color _neonGreen = Color(0xFF00FF41);
//   static const Color _darkBackground = Color(0xFF0A0A0A);
//
//   @override
//   void initState() {
//     super.initState();
//
//     // 1. Shimmer Controller: Runs continuously
//     _shimmerController = AnimationController(
//       vsync: this,
//       duration: _shimmerDuration,
//     )..repeat(reverse: true);
//
//     _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(_shimmerController);
//
//     // 2. Entrance Controller: Runs once for logo/text entry
//     _codeFlowController = AnimationController(
//       vsync: this,
//       duration: _flowDuration,
//     )..repeat(); // Loop continuous background movement
//
//     _entranceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _shimmerController, // Use shimmer controller to time the entrance
//         curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
//       ),
//     );
//
//     // Continuous vertical translation for the background code flow
//     _flowAnimation = Tween<Offset>(
//       begin: const Offset(0, -0.5),
//       end: const Offset(0, 0.5),
//     ).animate(_codeFlowController);
//
//     // Start initial entrance and navigation timer
//     _shimmerController.forward();
//     _startNavigationTimer();
//   }
//
//   void _startNavigationTimer() {
//     Future.delayed(_navigationDelay, () {
//       if (mounted) {
//         _shimmerController.stop();
//         _codeFlowController.stop();
//
//         Navigator.of(context).pushReplacement(
//           PageRouteBuilder(
//             transitionDuration: const Duration(milliseconds: 1400),
//             pageBuilder: (context, animation, secondaryAnimation) => const Text("Home Screen"),
//             transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               return FadeTransition(opacity: animation, child: child);
//             },
//           ),
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _shimmerController.dispose();
//     _codeFlowController.dispose();
//     super.dispose();
//   }
//
//   // --- WIDGET BUILDERS ---
//
//   Widget _buildCodeFlowBackground(BuildContext context) {
//     // Generate a long string of repeating, technical characters
//     const String codeBlock = "01101001 01101110 01101110 01101111 01110110 01100001 01110100 01101001 01101110 01100111 00100000 01100100 01101001 01100111 01101001 01110100 01100001 01101100 00100000 01100110 01110101 01110100 01110101 01110010 01100101 ";
//     final size = MediaQuery.of(context).size;
//
//     return AnimatedBuilder(
//       animation: _codeFlowController,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: _flowAnimation.value * size.height, // Continuous vertical scroll
//           child: Opacity(
//             opacity: 0.1, // Very subtle background text
//             child: Text(
//               codeBlock * 50, // Repeat the string many times to fill the space
//               style: const TextStyle(
//                 fontFamily: 'monospace',
//                 fontSize: 16,
//                 color: _neonGreen,
//                 height: 1.0,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildBrandingWithShimmer(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _shimmerAnimation,
//       builder: (context, child) {
//         // Create a LinearGradient that moves across the text for the shimmer effect
//         final gradient = LinearGradient(
//           colors: [
//             _neonGreen.withOpacity(0.2), // Dark edge
//             _neonGreen.withOpacity(1.0), // Bright center (the shimmer)
//             _neonGreen.withOpacity(0.2), // Dark edge
//           ],
//           stops: const [0.4, 0.5, 0.6],
//           begin: Alignment(_shimmerAnimation.value, 0.0),
//           end: Alignment(_shimmerAnimation.value + 1.0, 0.0),
//         ).createShader(
//           Rect.fromLTWH(0, 0, 300, 100), // Approximate size for shader creation
//         );
//
//         return ScaleTransition(
//           scale: _entranceAnimation,
//           child: FadeTransition(
//             opacity: _entranceAnimation,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // 1. Logo (Your "Bolo")
//                 Image.asset(
//                   'assets/images/boolmont_logo2.png',
//                   height: 120,
//                   color: _neonGreen.withOpacity(0.8), // Slightly dimmed logo
//                 ),
//                 const SizedBox(height: 20),
//
//                 // 2. Company Name (Uses the gradient shader)
//                 ShaderMask(
//                   shaderCallback: (bounds) => gradient,
//                   child: const Text(
//                     "BOOLMONT",
//                     style: TextStyle(
//                       fontSize: 48,
//                       fontWeight: FontWeight.w900,
//                       letterSpacing: 8.0,
//                       color: Colors.white, // Fallback color
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // 3. Tagline (Simple neon glow)
//                 Text(
//                   "// Innovating Digital Future",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: _neonGreen.withOpacity(0.7),
//                     letterSpacing: 2.0,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'monospace',
//                     shadows: [
//                       BoxShadow(
//                         color: _neonGreen.withOpacity(0.5),
//                         blurRadius: 5,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // Helper for bottom loading indicator (Updated to match Matrix theme)
//   Widget _buildLoadingIndicator(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 60, left: 100, right: 100),
//         child: FadeTransition(
//           opacity: _entranceAnimation,
//           child: SizedBox(
//             height: 4,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(2),
//               child: LinearProgressIndicator(
//                 backgroundColor: _neonGreen.withOpacity(0.1),
//                 valueColor: const AlwaysStoppedAnimation<Color>(_neonGreen),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Dummy state for demonstration
//     const bool isLoading = true;
//     const bool hasError = false;
//
//     return Scaffold(
//       backgroundColor: _darkBackground, // Set to dark background
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           // 1. Code Flow Background (Unique, continuously moving)
//           _buildCodeFlowBackground(context),
//
//           // 2. Logo and Text with Shimmer Effect (Highly attractive)
//           if (!hasError) _buildBrandingWithShimmer(context),
//
//           // 3. Loading Indicator
//           if (isLoading && !hasError) _buildLoadingIndicator(context),
//
//           // 4. Error Message (Fallback) - uses primary theme colors for visibility
//           if (hasError) _buildErrorView(context, "Connection failed. Retrying..."),
//         ],
//       ),
//     );
//   }
//
//   // Error view placeholder (uses red/white for clear error state)
//   Widget _buildErrorView(BuildContext context, String? errorMessage) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
//             const SizedBox(height: 16),
//             Text(
//               errorMessage ?? "SYSTEM FAILURE: Initialization error.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.red.shade400,
//                   fontFamily: 'monospace',
//                   shadows: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 5)]),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton.icon(
//               onPressed: () => debugPrint("Retry initialization triggered."),
//               icon: const Icon(Icons.refresh),
//               label: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//                 child: Text("RESTART SEQUENCE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.redAccent,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                 elevation: 0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/modules/home/home_screen.dart';
import 'dart:async';
import 'dart:math' as math;

import '../../app/routes/app_routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {

  // --- Animation Controllers and Tweens ---
  late AnimationController _shimmerController;
  late AnimationController _codeFlowController;
  late AnimationController _glitchController;       // NEW: Controls the random glitch effect

  late Animation<double> _shimmerAnimation;
  late Animation<double> _entranceAnimation;
  late Animation<Offset> _flowAnimation;

  // Glitch Effect variables
  double _randomX = 0.0;
  double _randomY = 0.0;

  // Define durations
  static const Duration _shimmerDuration = Duration(milliseconds: 1500);
  static const Duration _entranceDuration = Duration(milliseconds: 1000);
  static const Duration _flowDuration = Duration(seconds: 8);
  static const Duration _glitchDuration = Duration(milliseconds: 50); // Fast flicker time
  static const Duration _navigationDelay = Duration(milliseconds: 3000);

  // Hardcoded futuristic colors for this UI concept
  static const Color _neonGreen = Color(0xFF00FF41);
  static const Color _darkBackground = Color(0xFF0A0A0A);

  @override
  void initState() {
    super.initState();

    // 1. Shimmer Controller: Runs continuously
    _shimmerController = AnimationController(
      vsync: this,
      duration: _shimmerDuration,
    )..repeat(reverse: true);
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(_shimmerController);

    // 2. Entrance/Code Flow Controller: Runs continuously
    _codeFlowController = AnimationController(
      vsync: this,
      duration: _flowDuration,
    )..repeat();
    _entranceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _flowAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: const Offset(0, 0.5),
    ).animate(_codeFlowController);

    // 3. Glitch Controller: Runs continuously and triggers random offsets
    _glitchController = AnimationController(
      vsync: this,
      duration: _glitchDuration,
    )..addListener(_updateGlitch);

    // Start initial sequence
    _shimmerController.forward();
    _glitchController.repeat();
    _startNavigationTimer();
  }

  void _updateGlitch() {
    // Only apply random offset briefly during the glitch duration
    if (_glitchController.value < 0.1) {
      final random = math.Random();
      // Apply a small, random shift (e.g., 2 pixels max)
      _randomX = (random.nextDouble() - 0.5) * 4;
      _randomY = (random.nextDouble() - 0.5) * 4;
    } else {
      // Return to zero position quickly
      _randomX = 0;
      _randomY = 0;
    }
    setState(() {}); // Update the random translation
  }
  //
  // RECOMMENDED FIX

  void _startNavigationTimer() {
    Future.delayed(_navigationDelay, () {
      if (mounted) {
        _shimmerController.stop();
        _codeFlowController.stop();
        _glitchController.stop();


        // Future.delayed(Duration(milliseconds: 800));
        // AppRoutes.navigateReplace(AppRoutes.home);
        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> HomeScreen()));

        // NOTE: Adjusted page transition duration to a reasonable value (e.g., 600ms)
        // The original 13000ms transition delay was likely a typo and would cause a long freeze.

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 80),
            pageBuilder: (context, animation, secondary) =>
                AppRoutes.routes[AppRoutes.home]!(context),
            transitionsBuilder: (context, animation, secondary, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );


      }
    });
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _codeFlowController.dispose();
    _glitchController.dispose();
    super.dispose();
  }

  // --- WIDGET BUILDERS ---

  Widget _buildCodeFlowBackground(BuildContext context) {
    // Generate a long string of repeating, technical characters
    const String codeBlock = "01101001 01101110 01101110 01101111 01110110 01100001 01110100 01101001 01101110 01100111 00100000 01100100 01101001 01100111 01101001 01110100 01100001 01101100 00100000 01100110 01110101 01110100 01110101 01110010 01100101 ";
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _codeFlowController,
      builder: (context, child) {
        return Transform.translate(
          offset: _flowAnimation.value * size.height,
          child: Opacity(
            opacity: 0.1,
            child: Text(
              codeBlock * 50,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                color: _neonGreen,
                height: 1.0,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandingWithShimmer(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        final gradient = LinearGradient(
          colors: [
            _neonGreen.withOpacity(0.2),
            _neonGreen.withOpacity(1.0),
            _neonGreen.withOpacity(0.2),
          ],
          stops: const [0.4, 0.5, 0.6],
          begin: Alignment(_shimmerAnimation.value, 0.0),
          end: Alignment(_shimmerAnimation.value + 1.0, 0.0),
        ).createShader(
          Rect.fromLTWH(0, 0, 300, 100),
        );

        return ScaleTransition(
          scale: _entranceAnimation,
          child: FadeTransition(
            opacity: _entranceAnimation,
            // 🚨 Wrap branding elements in the Glitch Effect Widget
            child: _GlitchEffectWidget(
              randomX: _randomX,
              randomY: _randomY,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1. Logo (Your "Bolo")
                  Image.asset(
                    'assets/images/boolmont_logo2.png',
                    height: 200,
                    // color: ,
                  ),
                  const SizedBox(height: 20),

                  // 2. Company Name (Uses the gradient shader)
                  ShaderMask(
                    shaderCallback: (bounds) => gradient,
                    child: const Text(
                      "BOOLMONT",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 3. Tagline (Simple neon glow)
                  Text(
                   'Deploying Secure Logic. Continuously.',
                    style: TextStyle(
                      fontSize: 18,
                      color: _neonGreen.withOpacity(0.7),
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'monospace',
                      shadows: [
                        BoxShadow(
                          color: _neonGreen.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
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

  Widget _buildLoadingIndicator(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60, left: 100, right: 100),
        child: FadeTransition(
          opacity: _entranceAnimation,
          child: SizedBox(
            height: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                backgroundColor: _neonGreen.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(_neonGreen),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bool isLoading = true;
    const bool hasError = false;

    return Scaffold(
      backgroundColor: _darkBackground,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Code Flow Background
          _buildCodeFlowBackground(context),

          // 2. Logo and Text with Shimmer and Glitch Effect
          if (!hasError) Center(child: _buildBrandingWithShimmer(context)),

          // 3. Loading Indicator
          if (isLoading && !hasError) _buildLoadingIndicator(context),

          // 4. Error Message
          if (hasError) _buildErrorView(context, "Connection failed. Retrying..."),
        ],
      ),
    );
  }

  // Error view placeholder (same as before)
  Widget _buildErrorView(BuildContext context, String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? "SYSTEM FAILURE: Initialization error.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade400,
                  fontFamily: 'monospace',
                  shadows: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 5)]),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => debugPrint("Retry initialization triggered."),
              icon: const Icon(Icons.refresh),
              label: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Text("RESTART SEQUENCE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// === NEW WIDGET: GLITCH EFFECT WIDGET ===
// =====================================================================
// Applies a random, subtle translation effect for the holographic flicker.

class _GlitchEffectWidget extends StatelessWidget {
  final Widget child;
  final double randomX;
  final double randomY;

  const _GlitchEffectWidget({
    required this.child,
    required this.randomX,
    required this.randomY,
  });

  @override
  Widget build(BuildContext context) {
    // We use AnimatedContainer for a tiny bit of smoothing when returning to zero,
    // but the main effect comes from the rapid state changes in the parent.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50), // Ultra-fast transition
      transform: Matrix4.translationValues(randomX, randomY, 0),
      child: child,
    );
  }
}