import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../app/routes/app_routes.dart';

/// ----------------- Splash State -----------------
class SplashState {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  SplashState({
    required this.isLoading,
    this.hasError = false,
    this.errorMessage,
  });

  SplashState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// ----------------- Splash Controller -----------------
class SplashController extends StateNotifier<SplashState> {
  final Ref ref;
  final int splashDuration;

  SplashController(this.ref, {this.splashDuration = 2})
      : super(SplashState(isLoading: true)) {
    _initializeApp();
  }

  /// ---------------------------------
  /// Initialize App
  /// ---------------------------------
  Future<void> _initializeApp() async {
    try {
      await Future.delayed(Duration(seconds: splashDuration));

      // Load sample data
      // final user = SampleData.sampleUser;
      // final company = SampleData.company;

      // debugPrint("✅ User Loaded: ${user.fullName}");
      // debugPrint("✅ Company Loaded: ${company.name}");

      // Update state
      state = state.copyWith(isLoading: false);

      // Navigate to Onboarding
      _navigateTo(AppRoutes.onboarding);
    } catch (e, stackTrace) {
      debugPrint("❌ Error initializing app: $e");
      debugPrintStack(stackTrace: stackTrace);

      // Update state with error info
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// ---------------------------------
  /// Navigation Helpers
  /// ---------------------------------
  void _navigateTo(String route) {
    try {
      final navigatorKey = ref.read(navigatorKeyProvider);
      navigatorKey.currentState?.pushReplacementNamed(route);
    } catch (e) {
      debugPrint("❌ Navigation error: $e");
    }
  }

  void retryInitialization() {
    state = state.copyWith(isLoading: true, hasError: false, errorMessage: null);
    _initializeApp();
  }

  /// ---------------------------------
  /// Optional: Fetch additional data
  /// ---------------------------------
  Future<void> preloadData(List<Future<void>> tasks) async {
    try {
      await Future.wait(tasks);
      debugPrint("✅ Preloaded ${tasks.length} tasks successfully");
    } catch (e, stackTrace) {
      debugPrint("❌ Error preloading data: $e");
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}

/// ----------------- Providers -----------------
final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
      (ref) => GlobalKey<NavigatorState>(),
);

final splashControllerProvider =
StateNotifierProvider<SplashController, SplashState>(
      (ref) => SplashController(ref),
);
