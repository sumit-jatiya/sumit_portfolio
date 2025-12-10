import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Note: Changed CustomNavigationBar to be a widget in the body for flexibility
import '../../app/constants/custom_app_bar.dart';
import '../../app/theme/app_theme.dart'; // Assumed theme and color helpers
import '../../widgets/custom_widgets.dart'; // Assumed custom widgets (ProfessionalCard, GetInTouchCardContent, etc.)

class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen({super.key});

  @override
  ConsumerState<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends ConsumerState<ServiceScreen>
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
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: color.withOpacity(0.7),
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
    final isDesktop = width > 800;

    int gridCrossAxisCount = width > 1000 ? 3 : width > 600 ? 2 : 1;
    double horizontalPadding = width > 1200 ? width * 0.1 : width * 0.05;

    return Scaffold(
      backgroundColor: colors['background'],

      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomNavigationBar(isDesktop: isDesktop),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 50),
              child: FadeTransition(
                opacity: _fadeController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= SERVICE HERO SECTION =================
                    _buildServiceHero(width, colors),
                    const SizedBox(height: 120),

                    // ----------------------------------------------------

                    // ================= CORE SERVICES GRID (Animated Hover Effect) =================
                    _buildSectionHeader(
                      "Our Core Service Areas",
                      colors['linkColor']!,
                      subtitle: "We cover the full spectrum of digital needs, from concept to deployment and scaling.",
                    ),
                    const SizedBox(height: 40),
                    _buildCoreServicesGrid(gridCrossAxisCount, colors),
                    const SizedBox(height: 120),

                    // ----------------------------------------------------

                    // ================= FEATURED SERVICE (Process Steps with Hover) =================
                    _buildSectionHeader(
                      "Our Transparent Development Approach",
                      colors['linkColor']!,
                      subtitle: "A structured, agile process that ensures quality, transparency, and timely delivery.",
                    ),
                    const SizedBox(height: 40),
                    _buildFeaturedService(width, colors),
                    const SizedBox(height: 120),

                    // ----------------------------------------------------

                    // ================= CALL TO ACTION (Animated Button) =================
                    ProfessionalCard(
                      isHero: true,
                      child: GetInTouchCardContent(
                        onTap: () => debugPrint("Schedule Consultation"),
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
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildServiceHero(double width, Map<String, Color> colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Title, Description, and Button
        Expanded(
          flex: width > 900 ? 3 : 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtle badge/tag line
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colors['primaryAccent']!.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "NEXT-GEN DEVELOPMENT",
                  style: TextStyle(
                    color: colors['primaryAccent'],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Use a ScaleTransition for the main hero text for a subtle entrance (beyond the main FadeTransition)
              ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(_fadeController),
                child: Text(
                  "Tailored Digital Solutions",
                  style: TextStyle(
                    fontSize: width > 600 ? 60 : 40,
                    fontWeight: FontWeight.w900,
                    color: colors['primaryAccent'],
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "We specialize in creating powerful, scalable, and secure applications using modern technologies to achieve your business goals. Our focus is on delivering measurable ROI.",
                style: TextStyle(
                  fontSize: 22,
                  color: colors['secondaryText'],
                ),
              ),
              const SizedBox(height: 40),
              // Button with Hover Effect (using a custom widget or stateful logic is better)
              ElevatedButton.icon(
                onPressed: () => debugPrint("View Pricing"),
                icon: const Icon(Icons.flash_on_rounded),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
                  child: Text("Start Your Project Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors['primaryAccent'],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0, // No elevation
                ),
              ),
            ],
          ),
        ),
        // Right Column: Placeholder Image/Illustration
        if (width > 900)
          Expanded(
            flex: 2,
            child: Center(
              child: Image.asset(
                'assets/images/boolmont_logo2.png',
                height: 350,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCoreServicesGrid(int crossAxisCount, Map<String, Color> colors) {
    final List<Map<String, dynamic>> services = [
      {'title': 'Mobile App Development', 'desc': 'Native and cross-platform apps (Flutter/React Native) for iOS and Android.', 'icon': Icons.smartphone, 'color': Colors.blueAccent},
      {'title': 'Web Development (SaaS)', 'desc': 'Scalable web applications, APIs, and modern front-end design (React/Vue).', 'icon': Icons.laptop_mac, 'color': Colors.greenAccent},
      {'title': 'Cloud Infrastructure', 'desc': 'AWS, Azure, and Google Cloud deployment, DevOps, and managed hosting.', 'icon': Icons.cloud_queue, 'color': Colors.orangeAccent},
      {'title': 'UI/UX Design', 'desc': 'Figma prototypes, user research, and responsive interface design.', 'icon': Icons.design_services, 'color': Colors.redAccent},
      {'title': 'Quality Assurance (QA)', 'desc': 'Comprehensive testing, automation, and security auditing.', 'icon': Icons.verified_user, 'color': Colors.purpleAccent},
      {'title': 'Digital Strategy', 'desc': 'Consulting, project planning, and technical roadmap development.', 'icon': Icons.lightbulb_outline, 'color': Colors.tealAccent},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 30.0,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        final service = services[index];
        // Use the custom AnimatedServiceCard for hover/scale effect
        return AnimatedServiceCard(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: service['color'].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    size: 35,
                    color: service['color'] as Color,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  service['title'] as String,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors['linkColor'],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  service['desc'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    color: colors['secondaryText'],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedService(double width, Map<String, Color> colors) {
    final List<Map<String, dynamic>> steps = [
      {'title': '1. Discovery & Planning', 'desc': 'Define scope, gather requirements, and create a technical blueprint.', 'icon': Icons.search},
      {'title': '2. Design & Prototyping', 'desc': 'Wireframes, UI/UX design, and user flow mapping.', 'icon': Icons.palette},
      {'title': '3. Development & Coding', 'desc': 'Agile sprints, daily standups, and clean, efficient code.', 'icon': Icons.code},
      {'title': '4. Quality Assurance (QA)', 'desc': 'Rigorous testing, bug fixing, and security checks.', 'icon': Icons.bug_report},
      {'title': '5. Deployment & Launch', 'desc': 'Seamless deployment to production environments (App Stores/Cloud).', 'icon': Icons.launch},
      {'title': '6. Support & Maintenance', 'desc': 'Post-launch monitoring, updates, and scaling support.', 'icon': Icons.support_agent},
    ];

    return Wrap(
      spacing: 30,
      runSpacing: 30,
      children: steps.map((step) => SizedBox(
        width: width > 600 ? 350 : double.infinity,
        child: AnimatedServiceCard( // Using the animated card here too
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                step['icon'] as IconData,
                size: 30,
                color: colors['primaryAccent'],
              ),
              title: Text(
                step['title'] as String,
                style: TextStyle(fontWeight: FontWeight.bold, color: colors['linkColor'], fontSize: 18),
              ),
              subtitle: Text(
                step['desc'] as String,
                style: TextStyle(color: colors['secondaryText']),
              ),
            ),
          ),
        ),
      )).toList(),
    );
  }
}

// =====================================================================
// === NEW WIDGET FOR HOVER ANIMATION (You need to include this) ===
// =====================================================================

class AnimatedServiceCard extends StatefulWidget {
  final Widget child;
  final double scaleOnHover;
  final Color? borderColor;

  const AnimatedServiceCard({
    super.key,
    required this.child,
    this.scaleOnHover = 1.02,
    this.borderColor,
  });

  @override
  State<AnimatedServiceCard> createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<AnimatedServiceCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // Assuming color resolution happens outside, or use Theme context
    final colors = getCurrentColors(ProviderScope.containerOf(context).read(isDarkThemeProvider));

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: AnimatedScale(
        scale: _isHovering ? widget.scaleOnHover : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: colors['cardBackground'], // Use a defined background color for cards
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              // Highlight border on hover, or use primaryAccent color
              color: _isHovering
                  ? colors['primaryAccent']!
                  : colors['secondaryText']!.withOpacity(0.1),
              width: _isHovering ? 2.5 : 1.0,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}