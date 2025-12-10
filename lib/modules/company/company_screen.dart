import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/app/routes/app_routes.dart';
import '../../app/constants/custom_app_bar.dart';
import '../../app/theme/app_theme.dart'; // Must contain getCurrentColors and isDarkThemeProvider
import '../../widgets/custom_widgets.dart'; // Must contain ProfessionalCard, TypewriterAnimatedText, etc.

class CompanyScreen extends ConsumerStatefulWidget {
  const CompanyScreen({super.key});

  @override
  ConsumerState<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends ConsumerState<CompanyScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  // Helper method for professional section titles
  Widget _buildSectionHeader(String title, Color color, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: color
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = getCurrentColors(ref.watch(isDarkThemeProvider));
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800; // Define your desktop breakpoint
// Define your desktop breakpoint

    // Responsive breakpoints for Services Grid
    int gridCrossAxisCount = width >= 980
        ? 4
        : width > 790
        ? 3
        : width > 520
        ? 2
        : 1;

    double horizontalPadding = width > 1200 ? width * 0.1 : width * 0.05;

    return Scaffold(
      backgroundColor: colors['background'],
      // 1. Custom AppBar Integration
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (MediaQuery.of(context).size.width >= 930)
                CustomNavigationBar(isDesktop: isDesktop),
              if (MediaQuery.of(context).size.width <= 930)
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

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 50,
                ),
                child: FadeTransition(
                  opacity: _fadeController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= HERO SECTION =================
                      isDesktop
                          ? ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1000),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Logo/Visual Element
                                  Material(
                                    color: Colors.white,
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/boolmont_logo2.png',
                                        height: 300,
                                        width: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 40),

                                  // Title and Animated Text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "We Build. We Secure. We innovate",
                                          style: TextStyle(
                                            fontSize: width > 600 ? 52 : 36,
                                            fontWeight: FontWeight.w900,
                                            color: colors['primaryAccent'],
                                            height: 1.1,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TypewriterAnimatedText(
                                          titles: const [
                                            "Mobile App Development",
                                            "Web & Cloud Solutions",
                                            "Cybersecurity & Infrastructure",
                                            "Creative UI/UX Design",
                                          ],
                                          style: TextStyle(
                                            fontSize: width > 600 ? 24 : 18,
                                            fontWeight: FontWeight.w500,
                                            color: colors['secondaryText'],
                                          ),
                                          charDuration: const Duration(
                                            milliseconds: 70,
                                          ),
                                          pauseDuration: const Duration(
                                            seconds: 2,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "We craft high-performance, secure, and user-centric digital experiences tailored for growth.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: colors['secondaryText'],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Logo/Visual Element
                                Material(
                                  color: Colors.white,
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/boolmont_logo2.png',
                                      height: 300,
                                      width: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // Title and Animated Text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "We Build. We Secure. We innovate",
                                      style: TextStyle(
                                        fontSize: width > 600 ? 52 : 36,
                                        fontWeight: FontWeight.w900,
                                        color: colors['primaryAccent'],
                                        height: 1.1,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TypewriterAnimatedText(
                                      titles: const [
                                        "Mobile App Development",
                                        "Web & Cloud Solutions",
                                        "Cybersecurity & Infrastructure",
                                        "Creative UI/UX Design",
                                      ],
                                      style: TextStyle(
                                        fontSize: width > 600 ? 24 : 18,
                                        fontWeight: FontWeight.w500,
                                        color: colors['secondaryText'],
                                      ),
                                      charDuration: const Duration(
                                        milliseconds: 70,
                                      ),
                                      pauseDuration: const Duration(seconds: 2),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "We craft high-performance, secure, and user-centric digital experiences tailored for growth.",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: colors['secondaryText'],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                      const SizedBox(height: 40),

                      // ----------------------------------------------------

                      // ================= SERVICES GRID =================
                      _buildSectionHeader(
                        "Our Expertise",
                        colors['linkColor']!,
                        subtitle:
                            "Comprehensive solutions designed to power your success.",
                      ),
                      const SizedBox(height: 30),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCrossAxisCount,
                          crossAxisSpacing: 30.0,
                          mainAxisSpacing: 30.0,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          final serviceData = [
                            {
                              'title': 'Mobile Apps',
                              'subtitle': 'iOS & Android',
                              'icon': Icons.phone_android,
                            },
                            {
                              'title': 'Web Apps',
                              'subtitle': 'Responsive UI/UX',
                              'icon': Icons.web,
                            },
                            {
                              'title': 'Cloud & Backend',
                              'subtitle': 'Scalable APIs',
                              'icon': Icons.cloud,
                            },
                            {
                              'title': 'Cybersecurity',
                              'subtitle': 'Secure & Reliable',
                              'icon': Icons.security,
                            },
                          ];
                          return ProfessionalCard(
                            // customWidth: 300,
                            // customHeight: 800,
                            // elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SquareCardContent(
                                title: serviceData[index]['title'] as String,
                                subtitle:
                                    serviceData[index]['subtitle'] as String,
                                icon: serviceData[index]['icon'] as IconData,
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 100),

                      // ----------------------------------------------------

                      // ================= STATISTICS =================
                      _buildSectionHeader(
                        "Our Achievements",
                        colors['linkColor']!,
                        subtitle:
                            "Measurable results that speak for our dedication and quality.",
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:
                            [
                                  Expanded(
                                    child: AnimatedStatCard(
                                      label: 'Projects',
                                      value: 50,
                                      // icon: Icons.check_circle_outline,
                                      color: colors['primaryAccent']!,
                                    ),
                                  ),
                                  Expanded(
                                    child: AnimatedStatCard(
                                      label: 'Clients',
                                      value: 15,
                                      // icon: Icons.people_outline,
                                      color: colors['linkColor']!,
                                    ),
                                  ),
                                  if (width > 510)
                                    Expanded(
                                      child: AnimatedStatCard(
                                        label: 'Awards',
                                        value: 5,
                                        // icon: Icons.emoji_events_outlined,
                                        color: colors['secondaryText']!,
                                      ),
                                    ),
                                ]
                                .map(
                                  (w) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: w,
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(height: 100),

                      /*  // ----------------------------------------------------

                      // ================= TESTIMONIALS =================*/
                      /* _buildSectionHeader(
                        "Client Testimonials",
                        colors['linkColor']!,
                        subtitle:
                            "What our partners are saying about the results we deliver.",
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: SizedBox(
                                width: width * 0.8 > 500 ? 500 : width * 0.8,
                                child: ProfessionalCard(
                                  // elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.format_quote,
                                          size: 36,
                                          color: colors['primaryAccent'],
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "“The technical expertise and dedication of this team exceeded all expectations. They are a reliable partner for any serious digital transformation project.”",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            color: colors['secondaryText'],
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "- Client ${index + 1}, CTO",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors['linkColor'],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),*/

                      // ----------------------------------------------------

                      // ================= CALL TO ACTION =================
                      GestureDetector(
                        onTap: () {
                          print('click');
                          AppRoutes.navigateTo(AppRoutes.contact);
                        },
                        child: ProfessionalCard(
                          // elevation: 12,
                          isHero: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GetInTouchCardContent(
                              onTap: () {},
                              // onTap: () {
                              //   print('click');
                              //   AppRoutes.navigateTo(AppRoutes.contact);
                              // }
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
