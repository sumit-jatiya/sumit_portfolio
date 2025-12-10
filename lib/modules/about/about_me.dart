import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/models/controllers/experience_controller.dart';
import 'package:portfolio/core/models/user_model.dart';
import 'package:portfolio/modules/about/about_controller.dart';
import 'package:portfolio/modules/home/home_controller.dart';
import 'package:portfolio/modules/projects/projects_controller.dart';
import '../../app/constants/custom_app_bar.dart';
import '../../app/theme/app_theme.dart';
import '../../widgets/custom_widgets.dart';

class AboutScreen extends ConsumerStatefulWidget {
  const AboutScreen({super.key});

  @override
  ConsumerState<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends ConsumerState<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _cardsController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _cardsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardsController.forward();
    });
    // Fetch About & User data
    Future.microtask(() {
      ref.read(aboutListProvider.notifier).fetchAbout();
      ref.read(userListProvider.notifier).fetchUsers();
      ref.read(projectListProvider.notifier).fetchProjects();
      ref.read(experienceListProvider.notifier).fetchExperiences();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _cardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = getCurrentColors(ref.watch(isDarkThemeProvider));
    ref.watch(aboutListProvider);
    final userList = ref.watch(userListProvider);
    ref.watch(projectListProvider);
    ref.watch(experienceListProvider);
    final aboutError = ref.watch(aboutErrorProvider);
    ref.watch(userErrorProvider);

    final UserModel? user = userList.isNotEmpty ? userList.first : null;
    // int totalProjects = projectList.length.;
    // int clint = project.client!.length;

    final width = MediaQuery.of(context).size.width;
    final double baseFontSize = width < 600 ? 14 : 16;

    final bool isMobile = width <= 700;
    final bool isDesktop = width >= 950;

    return Scaffold(
      backgroundColor: colors['background'],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: FadeTransition(
            opacity: _fadeController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop) CustomNavigationBar(isDesktop: true),
                // PortfolioMenuWrapper(mobile: true,),
                if (isMobile)
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
                Text(
                  "About Me",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: colors['linkColor'],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),

                // ================= HERO PROFILE =================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    if (aboutError != null)
                      Center(
                        child: Text(
                          aboutError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    Expanded(
                      child: ProfessionalCard(
                        // Now uses the new wrapper for a unified look
                        customHeight: isMobile ? 480 : 250,
                        // isHero: true, // Now uses the new wrapper for a unified look
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: HeroCardContent(
                            position: false,

                            user: user!,
                            onTap: () =>
                                debugPrint('Hero Card Tapped: See Full Bio'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // ================= FUN FACTS / STATS =================
                Text(
                  "Fun Facts",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors['linkColor'],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedStatCard(
                      label: 'Projects',
                      value: 15,
                      color: colors['primaryAccent']!,
                    ),
                    AnimatedStatCard(
                      label: 'Clients',
                      value: 5,
                      color: colors['linkColor']!,
                    ),
                    if (isDesktop)
                      AnimatedStatCard(
                        label: 'Experience',
                        value: 3,
                        color: colors['secondaryText']!,
                      ),
                  ],
                ),
                if (isMobile) const SizedBox(height: 20),
                if (isMobile)
                  Center(
                    child: AnimatedStatCard(
                      label: 'Experience',
                      value: 3,
                      color: colors['secondaryText']!,
                    ),
                  ),

                const SizedBox(height: 50),
                // ================= SKILLS / WHAT I DO =================
                Text(
                  "Skills & Expertise",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors['linkColor'],
                  ),
                ),
                const SizedBox(height: 20),

                Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  alignment: WrapAlignment.start,
                  children: [
                    /// FLUTTER DEVELOPMENT
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Flutter Development',
                          subtitle: 'Cross-Platform ',
                          icon: Icons.flutter_dash,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// MOBILE UI/UX
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Mobile UI/UX',
                          subtitle: 'Modern',
                          icon: Icons.phone_android,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// WEB DEVELOPMENT
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Web Development',
                          subtitle: 'Responsive & Admin Panel',
                          icon: Icons.web,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// BACKEND APIs
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Backend & APIs',
                          subtitle: 'Firebase & Supabase',
                          icon: Icons.cloud_outlined,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// CYBER SECURITY
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Cyber Security',
                          subtitle: 'Pentesting',
                          icon: Icons.security,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// FIREBASE SERVICES
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Firebase Services',
                          subtitle: 'Auth & Notifications',
                          icon: Icons.bolt,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// API INTEGRATION
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'API Integration',
                          subtitle: 'Real-time & Payment Gateways',
                          icon: Icons.api,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// STATE MANAGEMENT
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'State Management',
                          subtitle: 'Riverpod & Provider',
                          icon: Icons.settings,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// DATABASE EXPERIENCE
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Database Expertise',
                          subtitle: 'SQL & Local Storage',
                          icon: Icons.storage,
                          onTap: () {},
                        ),
                      ),
                    ),

                    /// APP PERFORMANCE
                    ProfessionalCard(
                      customWidth: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SquareCardContent(
                          title: 'Performance Optimization',
                          subtitle: 'Smooth & Bug-free Apps',
                          icon: Icons.speed,
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // ================= GET IN TOUCH =================
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: [SocialMediaLinks(baseFontSize: baseFontSize)],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
