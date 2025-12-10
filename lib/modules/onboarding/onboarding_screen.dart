import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onboarding_controller.dart';
// Assuming OnboardingController is defined elsewhere
import 'dart:math' as math; // For background animation

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final isLastPage = onboardingState.currentPage == controller.totalPages - 1;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    // Show error message if any
    if (onboardingState.hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(onboardingState.errorMessage ?? "Unknown error"),
            backgroundColor: Colors.redAccent,
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 🚨 NEW: Animated Gradient Background
          Positioned.fill(
            child: _AnimatedGradientBackground(
              color1: primaryColor.withOpacity(0.1),
              color2: theme.colorScheme.secondary.withOpacity(0.1),
              duration: const Duration(seconds: 10),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // -------------------- Header and Close Button --------------------
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: controller.skip,
                        icon: Icon(
                          isLastPage ? Icons.check_circle_outline : Icons.close_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                        label: Text(
                          isLastPage ? "Finish" : "Close",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // -------------------- PageView with Hero Image & Animated Text --------------------
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.totalPages,
                    onPageChanged: controller.changePage,
                    itemBuilder: (context, index) {
                      final item = controller.onboardingData[index];
                      // The key ensures the widget rebuilds and animation restarts on page change
                      return _OnboardingContentLayer(
                        key: ValueKey(index), // Important for animation restarts
                        item: item,
                        theme: theme,
                        isActive: index == onboardingState.currentPage, // Pass active state for animation
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // -------------------- Floating Control Box --------------------
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.9), // Slightly transparent for background effect
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), // Rounded top
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Page Indicator (Subtle, professional dots)
                  SizedBox(
                    width: 100,
                    child: SmoothPageIndicator(
                      controller: controller.pageController,
                      count: controller.totalPages,
                      effect: ExpandingDotsEffect(
                        dotHeight: 6,
                        dotWidth: 8,
                        spacing: 5,
                        activeDotColor: primaryColor,
                        dotColor: Colors.grey.shade400.withOpacity(0.5),
                      ),
                    ),
                  ),

                  // 2. Navigation Button Group
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Previous Button (Animated icon and background)
                      AnimatedOpacity(
                        opacity: onboardingState.currentPage > 0 ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: onboardingState.currentPage > 0
                            ? IconButton(
                          onPressed: controller.previousPage,
                          icon: Icon(Icons.arrow_back_ios_rounded, color: primaryColor, size: 20),
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: primaryColor.withOpacity(0.1),
                          ),
                        )
                            : const SizedBox(width: 48), // Maintain space
                      ),
                      const SizedBox(width: 15),

                      // Next / Get Started Button (Animated icon and label)
                      ElevatedButton.icon(
                        onPressed: controller.nextPage,
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                          child: Icon(
                            isLastPage ? Icons.launch_rounded : Icons.arrow_forward_rounded,
                            key: ValueKey(isLastPage), // Key for AnimatedSwitcher
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        label: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                          child: Text(
                            isLastPage ? "Get Started" : "Continue",
                            key: ValueKey(isLastPage), // Key for AnimatedSwitcher
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ],
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

// =====================================================================
// === NEW WIDGET: ANIMATED GRADIENT BACKGROUND ===
// =====================================================================
class _AnimatedGradientBackground extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Duration duration;

  const _AnimatedGradientBackground({
    required this.color1,
    required this.color2,
    this.duration = const Duration(seconds: 10),
  });

  @override
  _AnimatedGradientBackgroundState createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<_AnimatedGradientBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true); // Loops back and forth
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                math.sin(_animation.value * math.pi * 2) * 0.5,
                math.cos(_animation.value * math.pi * 2) * 0.5,
              ),
              radius: 0.8 + (math.sin(_animation.value * math.pi) * 0.2), // Subtle pulsing effect
              colors: [
                widget.color1,
                widget.color2,
                widget.color1.withOpacity(0.0), // Fade to transparent
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

// =====================================================================
// === NEW WIDGET: LAYERED CONTENT WITH HERO ANIMATION AND ANIMATED TEXT ===
// =====================================================================

class _OnboardingContentLayer extends StatefulWidget {
  final Map<String, String> item;
  final ThemeData theme;
  final bool isActive; // To trigger animation on current page

  const _OnboardingContentLayer({
    super.key, // Using key for state management across page views
    required this.item,
    required this.theme,
    required this.isActive,
  });

  @override
  State<_OnboardingContentLayer> createState() => __OnboardingContentLayerState();
}

class __OnboardingContentLayerState extends State<_OnboardingContentLayer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _imageScaleAnimation;
  late Animation<double> _imageOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Image scales up from slightly smaller and fades in
    _imageScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _imageOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    if (widget.isActive) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant _OnboardingContentLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _animationController.forward(from: 0.0); // Restart animation when page becomes active
    } else if (!widget.isActive && oldWidget.isActive) {
      _animationController.reverse(); // Animate out when page becomes inactive
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),

          // -------- Image Layer with Scale & Fade Animation --------
          FadeTransition(
            opacity: _imageOpacityAnimation,
            child: ScaleTransition(
              scale: _imageScaleAnimation,
              child: Container(
                height: 320,
                margin: const EdgeInsets.only(bottom: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: widget.theme.primaryColor.withOpacity(0.15),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    widget.item['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // -------- Animated Title --------
          _AnimatedText(
            text: widget.item['title']!,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              color: widget.theme.textTheme.titleLarge?.color,
            ),
            animationDuration: const Duration(milliseconds: 800),
            delayOffset: const Duration(milliseconds: 100), // Delay each word slightly
          ),
          const SizedBox(height: 15),

          // -------- Animated Subtitle --------
          _AnimatedText(
            text: widget.item['subtitle']!,
            style: TextStyle(
              fontSize: 16,
              color: widget.theme.textTheme.bodyMedium?.color?.withOpacity(0.75) ?? Colors.grey.shade600,
              height: 1.6,
            ),
            animationDuration: const Duration(milliseconds: 1000),
            delayOffset: const Duration(milliseconds: 50),
          ),

          // Space for bottom controls
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}

// =====================================================================
// === NEW WIDGET: ANIMATED WORD-BY-WORD TEXT REVEAL ===
// =====================================================================

class _AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration animationDuration;
  final Duration delayOffset; // Delay between each word's animation

  const _AnimatedText({
    super.key,
    required this.text,
    this.style,
    this.animationDuration = const Duration(milliseconds: 500),
    this.delayOffset = const Duration(milliseconds: 30),
  });

  @override
  State<_AnimatedText> createState() => __AnimatedTextState();
}

class __AnimatedTextState extends State<_AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Animation<double>> _wordAnimations = [];
  List<String> _words = [];

  @override
  void initState() {
    super.initState();
    _words = widget.text.split(' ');
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration + (widget.delayOffset * _words.length),
    );

    _wordAnimations = List.generate(_words.length, (index) {
      final startTime = (widget.delayOffset * index).inMilliseconds / _controller.duration!.inMilliseconds;
      final endTime = (widget.animationDuration + (widget.delayOffset * index)).inMilliseconds / _controller.duration!.inMilliseconds;

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            math.min(startTime, 1.0),
            math.min(endTime, 1.0), // Ensure end time doesn't exceed 1.0
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      // Reinitialize animations if text changes (e.g., in a different context)
      _controller.reset();
      _words = widget.text.split(' ');
      _wordAnimations = List.generate(_words.length, (index) {
        final startTime = (widget.delayOffset * index).inMilliseconds / _controller.duration!.inMilliseconds;
        final endTime = (widget.animationDuration + (widget.delayOffset * index)).inMilliseconds / _controller.duration!.inMilliseconds;

        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              math.min(startTime, 1.0),
              math.min(endTime, 1.0),
              curve: Curves.easeOutCubic,
            ),
          ),
        );
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(_words.length, (index) {
            return FadeTransition(
              opacity: _wordAnimations[index],
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0), // Space between words
                child: Text(
                  _words[index],
                  style: widget.style,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}