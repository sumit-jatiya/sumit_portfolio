import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/constants/custom_app_bar.dart';
import '../../app/theme/app_theme.dart';
import '../../core/data/sample_data.dart';
import '../../firebase_options.dart';
import '../../widgets/custom_widgets.dart';
import 'home_controller.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controller and State setup (assumed to be correct)
    final homeState = ref.watch(homeControllerProvider);
    final homeController = ref.read(homeControllerProvider.notifier);

    // Fallbacks (Loading/Error state)
    if (homeState.isLoading) {
      return Scaffold(
        backgroundColor: darkBackground,
        body: Center(child: CircularProgressIndicator(color: darkPrimaryAccent)),
      );
    }

    if (homeState.errorMessage != null) {
      return Scaffold(
        backgroundColor: darkBackground,
        body: Center(
          child: Text(
            "Error: ${homeState.errorMessage}",
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return _ThemeWrapper(
      homeState: homeState,
      homeController: homeController,
    );
    return MockDataScreen();
  }
}
class _ThemeWrapper extends ConsumerWidget {
  final Object homeState; // Placeholder for the actual HomeState type
  final Object homeController; // Placeholder for the actual HomeController type

  const _ThemeWrapper({required this.homeState, required this.homeController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    // Cast placeholders to their actual types (Assuming types are correct from imports)
    final HomeState state = homeState as HomeState;
    final HomeController controller = homeController as HomeController;

    return Scaffold(
      backgroundColor: colors['background'], // Dynamic background color
      body: RefreshIndicator(
        onRefresh: controller.refreshPortfolio,
        color: colors['primaryAccent']!,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),            child: Column(
              children: [
               if(isDesktop) CustomNavigationBar(isDesktop: isDesktop),
                if( MediaQuery.of(context).size.width <= 900)
                Row(
                  children: [
                    Image.asset(
                      'assets/images/boolMont_logo.png',
                      height: 60,
                      fit: BoxFit.contain,
                      colorBlendMode: BlendMode
                          .srcATop, // Or another BlendMode like BlendMode.srcIn
                      color:
                      colors['primaryAccent'], // The color you want to apply
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                MainContentGrid(
                  user: state.user!,
                  projects: state.projects,
                  services: state.services,

                ),

                    ],
            ),
          ),
        ),
      ),
    );
  }
}

class PortfolioButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;

  const PortfolioButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.elevation = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MockDataScreen extends StatelessWidget {
  const MockDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Firebase init error: ${snapshot.error}")),
          );
        }

        // Firebase is ready
        final uploader = MockDataUploader();

        return Scaffold(
          appBar: AppBar(title: const Text("Generate Mock Data")),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                mockButton("Create Mock User", uploader.uploadUserMock, context),
                mockButton("Create Mock About", uploader.uploadAboutMock, context),
                mockButton("Create Mock Projects", uploader.uploadProjectsMock, context),
                mockButton("Create Mock Services", uploader.uploadServicesMock, context),
                mockButton("Create Mock Experience", uploader.uploadExperienceMock, context),
                mockButton("Create Mock Education", uploader.uploadEducationMock, context),
                mockButton("Create Mock Contact", uploader.uploadContactMock, context),
                mockButton("Create Mock Company", uploader.uploadCompanyMock, context),
                mockButton("Create Mock Resume", uploader.uploadResumeMock, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget mockButton(String text, Future<void> Function() uploadFunction, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: PortfolioButton(
        text: text,
        onPressed: () async {
          try {
            await uploadFunction();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$text uploaded successfully!")));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error uploading $text: $e")));
          }
        },
      ),
    );
  }
}
