import 'package:flutter/material.dart';

// Screens
import '../../modules/splash/splash_screen.dart';
import '../../modules/onboarding/onboarding_screen.dart';
import '../../modules/services/services_screen.dart';
import '../../modules/projects/projects_screen.dart';
import '../constants/custom_app_bar.dart'; // PortfolioLayout

class AppRoutes {
  // ----------------- Route Names -----------------
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String about = '/about';
  static const String company = '/company';
  static const String services = '/services';
  static const String projects = '/projects';
  static const String contact = '/contact';
  static const String resume = '/resume';

  // ----------------- Global Navigator Key -----------------
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Queue for early navigation attempts
  static final List<String> _queuedNavigation = [];

  // ----------------- Route Map -----------------
  static final Map<String, WidgetBuilder> _routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),

    // PortfolioLayout handles mobile/desktop internally
    home: (context) => const PortfolioLayout(initialPage: "home"),
    about: (context) => const PortfolioLayout(initialPage: "about"),
    company: (context) => const PortfolioLayout(initialPage: "company"),
    resume: (context) => const PortfolioLayout(initialPage: "resume"),
    contact: (context) => const PortfolioLayout(initialPage: "contact"),

    // Standalone screens
    services: (_) => const ServiceScreen(),
    projects: (_) => const ProjectsScreen(),
  };

  // ---- PUBLIC GETTER (For main.dart) ----
  static Map<String, WidgetBuilder> get routes => _routes;

  // ----------------- Route Generator (With Animation) -----------------
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final builder = _routes[settings.name];

    if (builder == null) {
      debugPrint("⚠ Route not found: ${settings.name}");
      return _errorRoute();
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.08, 0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            "❌ Route Not Found",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ----------------- Navigation Helpers -----------------
  static Future<void> navigateTo(String routeName) async {
    final nav = navigatorKey.currentState;
    if (nav != null) {
      await nav.pushNamed(routeName);
    } else {
      _queuedNavigation.add(routeName);
      WidgetsBinding.instance.addPostFrameCallback((_) => _processQueue());
    }
  }

  static Future<void> navigateReplace(String routeName) async {
    final nav = navigatorKey.currentState;
    if (nav != null) {
      await nav.pushReplacementNamed(routeName);
    } else {
      _queuedNavigation.add(routeName);
      WidgetsBinding.instance.addPostFrameCallback((_) => _processQueue(replace: true));
    }
  }

  static void goBack() {
    final nav = navigatorKey.currentState;
    if (nav != null && nav.canPop()) {
      nav.pop();
    }
  }

  static void _processQueue({bool replace = false}) {
    final nav = navigatorKey.currentState;
    if (nav == null || _queuedNavigation.isEmpty) return;

    final route = _queuedNavigation.removeAt(0);
    if (replace) {
      nav.pushReplacementNamed(route);
    } else {
      nav.pushNamed(route);
    }

    if (_queuedNavigation.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _processQueue(replace: replace));
    }
  }
}
