import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/routes/app_routes.dart';

/// State class for Onboarding
class OnboardingState {
  final int currentPage;
  final bool hasError;
  final String? errorMessage;

  OnboardingState({
    required this.currentPage,
    this.hasError = false,
    this.errorMessage,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? hasError,
    String? errorMessage,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Controller for Onboarding using Riverpod
class OnboardingController extends StateNotifier<OnboardingState> {
  final PageController pageController;
  final List<Map<String, String>> onboardingData;

  OnboardingController({
    required this.onboardingData,
  })  : pageController = PageController(),
        super(OnboardingState(currentPage: 0)) {
    if (onboardingData.isEmpty) {
      state = state.copyWith(
        hasError: true,
        errorMessage: "Onboarding data is empty!",
      );
    }
  }

  int get totalPages => onboardingData.length;

  /// Go to next page
  void nextPage() {
    try {
      if (state.currentPage < totalPages - 1) {
        final nextIndex = state.currentPage + 1;
        state = state.copyWith(currentPage: nextIndex);
        pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        goToHome();
      }
    } catch (e, st) {
      state = state.copyWith(hasError: true, errorMessage: e.toString());
      debugPrintStack(stackTrace: st);
    }
  }

  /// Go to previous page
  void previousPage() {
    try {
      if (state.currentPage > 0) {
        final prevIndex = state.currentPage - 1;
        state = state.copyWith(currentPage: prevIndex);
        pageController.animateToPage(
          prevIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    } catch (e, st) {
      state = state.copyWith(hasError: true, errorMessage: e.toString());
      debugPrintStack(stackTrace: st);
    }
  }

  /// Skip onboarding
  void skip() {
    goToHome();
  }

  /// Navigate to Home
  void goToHome() {
    try {
      AppRoutes.navigatorKey.currentState?.pushReplacementNamed(AppRoutes.home);
    } catch (e) {
      state = state.copyWith(hasError: true, errorMessage: "Navigation failed: $e");
    }
  }

  /// Update page manually
  void changePage(int index) {
    if (index >= 0 && index < totalPages) {
      state = state.copyWith(currentPage: index);
    } else {
      debugPrint("❌ Invalid page index: $index");
    }
  }
}

/// Riverpod provider for OnboardingController
final onboardingControllerProvider = StateNotifierProvider<
    OnboardingController, OnboardingState>((ref) {
  // Example onboarding data
  final onboardingData = [
    {
      "title": "Welcome to Boolmont",
      "subtitle": "A future-ready IT startup for Development & Cybersecurity.",
      "image": "assets/images/onboard1.png"
    },
    {
      "title": "Secure Digital Solutions",
      "subtitle": "We build secure, modern and high-performance applications.",
      "image": "assets/images/onboard2.png"
    },
    {
      "title": "Grow With Innovation",
      "subtitle": "Join our journey towards a smarter and secure digital world.",
      "image": "assets/images/onboard3.png"
    },
  ];

  return OnboardingController(onboardingData: onboardingData);
});
