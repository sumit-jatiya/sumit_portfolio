// 3. Top Navigation Bar (Manages Theme Toggle)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/modules/about/about_me.dart';
import 'package:portfolio/modules/company/company_screen.dart';
import 'package:portfolio/modules/contacts/contacts_screen.dart';
import 'package:portfolio/modules/resume/resume_screen.dart';
import 'package:portfolio/widgets/custom_widgets.dart';

// import '../../modules/about/about_me.dart';
import '../../modules/home/home_screen.dart';
import '../theme/app_theme.dart';

class CustomNavigationBar extends ConsumerStatefulWidget {
  final bool isDesktop;
  const CustomNavigationBar({super.key, required this.isDesktop});

  @override
  ConsumerState<CustomNavigationBar> createState() =>
      _CustomNavigationBarState();
}
// final isDarkThemeProvider = StateProvider<bool>((ref) => true);

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
  String currentPage = 'Home'; // Track current page locally

  void _handleNavigation(BuildContext context, String route) {
    setState(() {
      // Update currentPage based on route
      switch (route) {
        case '/home':
          currentPage = 'Home';
          break;
        case '/works':
          currentPage = 'Works';
          break;
        case '/about':
          currentPage = 'About';
          break;
        case '/resume':
          currentPage = 'Resume';
          break;
        case '/contact':
          currentPage = 'Contact';
          break;
        default:
          currentPage = '';
      }
    });

    // Navigate to the route
    Navigator.pushNamed(context, route);
    debugPrint('Navigating to: $route');
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colors['background'],
      elevation: 0,
      toolbarHeight: 100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- LOGO ---
          Row(
            children: [
              Image.asset(
                'assets/images/boolMont_logo.png',
                height: 60,
                fit: BoxFit.contain,
                colorBlendMode: BlendMode
                    .srcATop, // Or another BlendMode like BlendMode.srcIn
                color: colors['primaryAccent'], // The color you want to apply
              ),
            ],
          ),

          // --- NAVIGATION LINKS ---
          if (widget.isDesktop)
            Center(
              child: Row(
                children: [
                  _NavLink(
                    title: 'Home',
                    isCurrent: currentPage == "Home",
                    onTap: () => _handleNavigation(context, '/home'),
                  ),
                  _NavLink(
                    title: 'Works',
                    isCurrent: currentPage == "Works",
                    onTap: () => _handleNavigation(context, '/works'),
                  ),
                  _NavLink(
                    title: 'About',
                    isCurrent: currentPage == "About",
                    onTap: () => _handleNavigation(context, '/about'),
                  ),
                  _NavLink(
                    title: 'Resume',
                    isCurrent: currentPage == "Resume",
                    onTap: () => _handleNavigation(context, '/resume'),
                  ),
                  _NavLink(
                    title: 'Contact',
                    isCurrent: currentPage == "Contact",
                    onTap: () => _handleNavigation(context, '/contact'),
                  ),
                ],
              ),
            ),

          // --- THEME TOGGLE ---
          buildThemeToggle(isDarkMode, ref, colors),
        ],
      ),
    );
  }

  Widget buildThemeToggle(bool isDarkMode, WidgetRef ref, Map colors) {
    return GestureDetector(
      onTap: () {
        ref.read(isDarkThemeProvider.notifier).state = !isDarkMode;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 55,
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              FontAwesomeIcons.solidSun,
              size: 14,
              color: isDarkMode ? Colors.grey : Colors.orange,
            ),
            Icon(
              FontAwesomeIcons.solidMoon,
              size: 14,
              color: isDarkMode ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// 3a. Navigation Link Widget (Hover Effect)
class _NavLink extends ConsumerStatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isCurrent; // ✅ add this

  const _NavLink({
    required this.title,
    required this.onTap,
    this.isCurrent = false,
  });

  @override
  ConsumerState<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends ConsumerState<_NavLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextButton(
          onPressed: widget.onTap,
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.isCurrent
                  ? colors['primaryAccent'] // current page color
                  : (_isHovering
                        ? colors['primaryAccent']
                        : colors['linkColor']),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------
// Portfolio Layout (with Menu)
// ---------------------------
class PortfolioLayout extends ConsumerStatefulWidget {
  final String initialPage; // default screen
  const PortfolioLayout({super.key, this.initialPage = "home"});

  @override
  ConsumerState<PortfolioLayout> createState() => _PortfolioLayoutState();
}

class _PortfolioLayoutState extends ConsumerState<PortfolioLayout> {
  late String currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
  }

  void changePage(String page) {
    setState(() => currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final color = getCurrentColors(isDarkMode);
    final screenWidth = MediaQuery.of(context).size.width;

    // Agar width > 800 => menu hide (sirf child dikhe)
    if (screenWidth > 930) {
      return Scaffold(
        backgroundColor: color["background"],
        body: _getScreen(currentPage),
      );
    }

    // Agar width <= 800 => hidden menu dikhe
    return Scaffold(
      backgroundColor: color["background"],
      body: BeautifulHiddenMenu(
        colors: color,
        onPageSelect: changePage,
        child: _getScreen(currentPage),
      ),
    );
  }

  Widget _getScreen(String page) {
    switch (page) {
      case "home":
        return const HomeScreen();
      case "company":
        return const CompanyScreen();

      case "resume":
        return const ResumeScreen();
      case "contact":
        return const ContactsScreen();
      case "about":
        return const  AboutScreen();
      default:
        return const Center(child: Text("404 Page Not Found"));
    }
  }
}

// ---------------------------
// Beautiful Hidden Menu
// ---------------------------
class BeautifulHiddenMenu extends ConsumerStatefulWidget {
  final Widget child;
  final double menuWidth;
  final Function(String) onPageSelect;
  final Map<String, Color> colors;

  const BeautifulHiddenMenu({
    super.key,
    required this.child,
    required this.onPageSelect,
    required this.colors,
    this.menuWidth = 260,
  });

  @override
  ConsumerState<BeautifulHiddenMenu> createState() =>
      _BeautifulHiddenMenuState();
}

class _BeautifulHiddenMenuState extends ConsumerState<BeautifulHiddenMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(
      begin: -1,
      end: 0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  void toggleMenu() {
    isOpen ? controller.reverse() : controller.forward();
    setState(() => isOpen = !isOpen);
  }

  void selectPage(String page) {
    widget.onPageSelect(page);
    toggleMenu();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = widget.colors;

    return Stack(
      children: [
        widget.child,

        // Dim Background
        IgnorePointer(
          ignoring: !isOpen,
          child: AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: GestureDetector(
              onTap: toggleMenu,
              child: Container(color: Colors.black45),
            ),
          ),
        ),

        // Sliding Menu
        AnimatedBuilder(
          animation: animation,
          builder: (_, child) {
            return Transform.translate(
              offset: Offset(animation.value * widget.menuWidth, 0),
              child: child,
            );
          },
          child: Container(
            width: widget.menuWidth,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            decoration: BoxDecoration(
              color: colors["background"],
              boxShadow: const [
                BoxShadow(blurRadius: 20, color: Colors.black26),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/images/boolMont_logo.png',
                  height: 50,
                  color: colors['primaryAccent'],
                ),
                const SizedBox(height: 40),

                // Menu Items
                menuItem(Icons.home, "Home", "home", colors),
                menuItem(Icons.person, "About", "about", colors),
                menuItem(
                  FontAwesomeIcons.computer,
                  "Company",
                  "company",
                  colors,
                ),

                menuItem(Icons.description, "Resume", "resume", colors),
                menuItem(Icons.contact_mail, "Contact", "contact", colors),
                const SizedBox(height: 20),

                // Theme Toggle
                Center(
                  child: ProfessionalCard(
                    customHeight: 70,
                    customWidth: 130,
                    child: GlamToggle(
                      isDarkMode: isDarkMode,
                      onToggle: () {
                        ref.read(isDarkThemeProvider.notifier).state =
                            !isDarkMode;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Menu Button
        Positioned(
          top: 40,
          right: 20,
          child: GestureDetector(
            onTap: toggleMenu,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors['primaryAccent'],
                shape: BoxShape.circle,
              ),
              child: Icon(
                isOpen ? Icons.close : Icons.menu,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget menuItem(
    IconData icon,
    String title,
    String page,
    Map<String, Color> colors,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => selectPage(page),
          child: ProfessionalCard(
            customHeight: 60,
            child: Container(
              height: 60,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(icon, color: colors["secondaryText"]),
                  // const SizedBox(width: 12),
                  Text(title, style: TextStyle(color: colors["secondaryText"])),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// ---------------------------
// Glam Toggle Widget
// ---------------------------
class GlamToggle extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;
  final Duration animationDuration;

  const GlamToggle({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
    this.animationDuration = const Duration(milliseconds: 350),
  });

  @override
  Widget build(BuildContext context) {
    const double width = 120, height = 50, padding = 6;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onToggle();
      },
      child: AnimatedContainer(
        duration: animationDuration,
        width: width,
        height: height,
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.blueGrey.shade800, Colors.blueGrey.shade900]
                : [Colors.lightBlue.shade300, Colors.lightBlue.shade600],
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: animationDuration,
              left: isDarkMode ? width - height : 0,
              right: isDarkMode ? 0 : width - height,
              child: Container(
                width: height - 2 * padding,
                height: height - 2 * padding,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? Colors.blueGrey.shade700
                      : Colors.lightBlue.shade200,
                ),
                child: AnimatedSwitcher(
                  duration: animationDuration,
                  child: Icon(
                    isDarkMode
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    key: ValueKey(isDarkMode),
                    color: Colors.amber,
                    size: (height - 2 * padding) * 0.7,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
