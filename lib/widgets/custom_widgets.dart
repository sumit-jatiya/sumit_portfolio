
// 2. Theme Wrapper Widget: Reads the theme state and sets base colors
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/app/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/theme/app_theme.dart';
import '../core/models/project_model.dart';
import '../core/models/service_model.dart';
import '../core/models/user_model.dart';
Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);

  if (await canLaunchUrl(url)) {
    // Open in an external application (browser)
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch $url');
    // Consider adding user feedback here (e.g., a Snackbar)
  }
}



// 4. Main Content Grid
class MainContentGrid extends StatelessWidget {
  final UserModel user;
  final List<ProjectModel> projects;
  final List<ServiceModel> services;

  const MainContentGrid({
    required this.user,
    required this.projects,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
   final isDesktop = MediaQuery.of(context).size.width  > 900;
    // List of cards matching the requested layout
    final List<Widget> cards = [

      // Add the new "Get In Touch Now" card
      isDesktop ?GestureDetector(
        onTap: () => AppRoutes.navigateTo(AppRoutes.about),
        child: ProfessionalCard( // Now uses the new wrapper for a unified look
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HeroCardContent(

              user: user,

              onTap: () => debugPrint('Hero Card Tapped: See Full Bio'),
            ),
          ),
          isHero: true,
        ),
      ):
      GestureDetector(
        onTap: () => AppRoutes.navigateTo(AppRoutes.about),
        child: ProfessionalCard(
          customHeight: 350,
          // customWidth: 300,// Now uses the new wrapper for a unified look
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HeroCardContent(

              user: user,

              onTap: () => debugPrint('Hero Card Tapped: See Full Bio'),
            ),
          ),
          isHero: true,
        ),
      ),


      // Add the new "Get In Touch Now" card
      isDesktop ? GestureDetector(
        onTap: () => AppRoutes.navigateTo(AppRoutes.resume),
        child: ProfessionalCard(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SquareCardContent(
              title: 'LEARN MORE ABOUT ME',
              subtitle: 'See Resume',
              icon: Icons.document_scanner_outlined,
              onTap: () => debugPrint('See Resume Tapped'),
            ),
          ),
        ),
      ):GestureDetector(
        onTap: () => AppRoutes.navigateTo(AppRoutes.resume),
        child: ProfessionalCard(
          isHero: true,
// customWidth: 200,
//           customHeight: 200,
          child: Padding(

            padding: const EdgeInsets.all(8.0),
            child: SquareCardContent(
              title: 'LEARN MORE ABOUT ME',
              subtitle: 'See Resume',
              icon: Icons.document_scanner_outlined,
              onTap: () => debugPrint('See Resume Tapped'),
            ),
          ),
        ),
      ),


      // Add the new "Get In Touch Now" card
      isDesktop?GestureDetector(
        onTap: () => _launchUrl('https://pub.dev/packages/flutter_helper_utils'),
        child: ProfessionalCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SquareCardContent(
              title: 'PACKAGE',
              subtitle: 'HelperUtils',
              icon: FontAwesomeIcons.wrench,
              imageUrl: 'https://imgs.search.brave.com/ZcAFwwEUVYHgBKEfvcOP8tHoB0QAi5uQQ6N24oFF1ME/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9yYXcu/Z2l0aHVidXNlcmNv/bnRlbnQuY29tL29t/YXItaGFuYWZ5L2Zs/dXR0ZXJfaGVscGVy/X3V0aWxzL21haW4v/ZGFzaC10b29scy5w/bmc',
              onTap: () => debugPrint('HelperUtils Tapped'),
            ),
          ),
        ),
      ):GestureDetector(
        onTap: () => _launchUrl('https://pub.dev/packages/flutter_helper_utils'),
        child: ProfessionalCard(
          isHero: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SquareCardContent(
              title: 'PACKAGE',
              subtitle: 'HelperUtils',
              icon: FontAwesomeIcons.wrench,
              imageUrl: 'https://imgs.search.brave.com/ZcAFwwEUVYHgBKEfvcOP8tHoB0QAi5uQQ6N24oFF1ME/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9yYXcu/Z2l0aHVidXNlcmNv/bnRlbnQuY29tL29t/YXItaGFuYWZ5L2Zs/dXR0ZXJfaGVscGVy/X3V0aWxzL21haW4v/ZGFzaC10b29scy5w/bmc',
              onTap: () => debugPrint('HelperUtils Tapped'),
            ),
          ),
        ),
      ),

     isDesktop? ProfessionalCard(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SquareCardContent(
            title: 'Connect with ',
            subtitle: 'LinkedIn',
            icon: FontAwesomeIcons.cube,
            imageUrl: 'https://imgs.search.brave.com/OsvbXVDkDUBXZmVS5YdC_RpPiL0VcG9IFHYAWjxO7AI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xODcvMTg3MTg1/LnBuZz9zZW10PWFp/c193aGl0ZV9sYWJl/bA',
            onTap: () => _launchUrl('https://www.linkedin.com/in/sumit-jatiya-5841752a3/'),
          ),
        ),
      ):ProfessionalCard(
       isHero: true,

       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: SquareCardContent(
           title: 'Connect with ',
           subtitle: 'LinkedIn',
           icon: FontAwesomeIcons.cube,
           imageUrl: 'https://imgs.search.brave.com/OsvbXVDkDUBXZmVS5YdC_RpPiL0VcG9IFHYAWjxO7AI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xODcvMTg3MTg1/LnBuZz9zZW10PWFp/c193aGl0ZV9sYWJl/bA',
           onTap: () => _launchUrl('https://www.linkedin.com/in/sumit-jatiya-5841752a3/'),
         ),
       ),
     ),

      isDesktop ?ProfessionalCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SquareCardContent(
            title: 'Connect with ',
            subtitle: 'GitHub ',
            icon: FontAwesomeIcons.github,
            imageUrl: 'https://imgs.search.brave.com/Wf7QawGo9nTjwfE4TatQMamB2rpWbMHFn4OS_ZS8d6g/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pY29u/ZXMucHJvL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzA2L2lj/b25lLWdpdGh1Yi1q/YXVuZS5wbmc',
            onTap: () => _launchUrl('https://github.com/sumit-jatiya'),
          ),
        ),
      ):ProfessionalCard(
        isHero: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SquareCardContent(
            title: 'Connect with ',
            subtitle: 'GitHub ',
            icon: FontAwesomeIcons.github,
            imageUrl: 'https://imgs.search.brave.com/Wf7QawGo9nTjwfE4TatQMamB2rpWbMHFn4OS_ZS8d6g/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pY29u/ZXMucHJvL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzA2L2lj/b25lLWdpdGh1Yi1q/YXVuZS5wbmc',
            onTap: () => _launchUrl('https://github.com/sumit-jatiya'),
          ),
        ),
      ),

      ProfessionalCard(
        customHeight: 235,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _project_card(
            title: 'MOBILE APP',
            subtitle: "Martify (E-commerce) ",
            description: 'A modern e-commerce mobile application built for seamless shopping.', // New professional description
            accentColor: const Color(0xFFD3625C), // The reddish/orange accent
            imagePath: 'assets/images/martify_logo.png', // <-- Update this path
            onTap: () => _launchUrl('https://sellora-f7ad0.web.app/'),
          ),
        ),
        isHero: true, // Use hero size for this accent card as well
      ),

      // Add the new "Get In Touch Now" card
     isDesktop? GestureDetector(
        onTap: () => AppRoutes.navigateTo(AppRoutes.about),
        child: ProfessionalCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WhatIDoCardContent(
              onTap: () => debugPrint('What I Do Card Tapped'),
            ),
          ),
        customWidth: 525,
        ),
      ): GestureDetector(
       onTap: () => AppRoutes.navigateTo(AppRoutes.about),
       child: ProfessionalCard(
isHero: true,
         customHeight: 210,
         // ,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: WhatIDoCardContent(
             onTap: () => debugPrint('What I Do Card Tapped'),
           ),
         ),
         // customWidth: 525,
       ),
     ),

      // Add the new "Get In Touch Now" card
      GestureDetector(
    onTap: () => AppRoutes.navigateTo(AppRoutes.contact),
        child: ProfessionalCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetInTouchCardContent(
              onTap: () {
              },
            ),
          ),
          isHero: true,
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(40.0),
      // For a modern portfolio look, we use Wrap, but the card animations
      // provide the main professional touch.
      child: Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        alignment: WrapAlignment.start,
        children: cards,
      ),
    );
  }

}

// -----------------------------------------------------------
// --- CORE ANIMATION & UI WIDGET (NEW) ---
// -----------------------------------------------------------

// 5. Professional Card Wrapper - Applies a unified, polished hover effect
class ProfessionalCard extends ConsumerStatefulWidget {
  final Widget child;
  final bool isHero;
  final double? customHeight;   // custom height override
  final double? customWidth;    // custom width override (optional)

  const ProfessionalCard({
    required this.child,
    this.isHero = false,
    this.customHeight,
    this.customWidth,
  });

  @override
  ConsumerState<ProfessionalCard> createState() => _ProfessionalCardState();
}

class _ProfessionalCardState extends ConsumerState<ProfessionalCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);
    final width = MediaQuery.of(context).size.width;

    // -------------------------
    // WIDTH LOGIC
    // -------------------------
    double cardWidth;

    if (widget.customWidth != null) {
      cardWidth = widget.customWidth!;
    } else if (widget.isHero) {
      cardWidth = width > 900 ? (width / 2) - 50 : width - 50;
    } else {
      cardWidth = width < 500 ? (width / 2) - 30 : 250;
    }

    // -------------------------
    // HEIGHT LOGIC
    // -------------------------
    double cardHeight;

    if (widget.customHeight != null) {
      cardHeight = widget.customHeight!;
    } else if (widget.isHero) {
      cardHeight = width < 600 ? 200 : 260; // responsive hero size
    } else {
      cardHeight = 250; // default size
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,

        // Hover lift + zoom
        transform: Matrix4.identity()
          ..translate(0.0, _isHovering ? -10.0 : 0.0)
          ..scale(_isHovering ? 1.02 : 1.0),

        width: cardWidth,
        height: cardHeight,

        decoration: BoxDecoration(
          color: colors['cardColor'],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: _isHovering ? colors['primaryAccent']! : colors['cardColor']!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: colors['linkColor']!.withOpacity(_isHovering ? 0.3 : 0.05),
              blurRadius: 20,
              offset: Offset(0, _isHovering ? 15 : 4),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(8),
          child: widget.child,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------
// --- REFACTORED CONTENT WIDGETS ---
// (Now just the content, separated from the common animation logic)
// -----------------------------------------------------------

// 6. Hero Card Content (used by _ProfessionalCard)
class HeroCardContent extends ConsumerWidget {
  final UserModel user;
  final VoidCallback onTap;
  final String? discription;
  final bool? position;

  const HeroCardContent(
      {this.discription, this.position = true, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);

    // To access the hover state of the parent _ProfessionalCard,
    // you would typically need to pass the state down or use an InheritedWidget.
    // For simplicity, we'll keep the arrow animation here, as the parent
    // provides the primary lift/shadow animation.
    final _ProfessionalCardState? parentState = context.findAncestorStateOfType<
        _ProfessionalCardState>();
    final bool isHovering = parentState?._isHovering ?? false;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    final bool isDesktop = width >= 700;
    final String aboutMeText =
        "Hello! I’m Sumit Jatiya, a dedicated Flutter Developer and Cybersecurity Enthusiast focused on building secure, high-performance, and user-centric mobile applications. "
        "I specialize in Flutter, Dart, Firebase, REST APIs, and UI/UX development — combining clean architecture with smooth performance. "
        "Alongside development, I apply cybersecurity best practices to ensure every application I build is safe, optimized, and production-ready. "
        "I’m passionate about solving real-world problems and creating digital experiences that are modern, secure, and impactful. "
        "Let’s collaborate and turn innovative ideas into reliable and scalable digital products.";


    // --- Pop-up Logic: Call the new Standard Dialog ---
    void _showGlassPopup(BuildContext context) {
      // Using showDialog is the standard way to show a Material dialog
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          // We call the new standard dialog here
          return _StandardDialog(text: aboutMeText, style: TextStyle(color: Colors.red),);
        },
      );
    }
    return isDesktop ? GestureDetector(
      onTap: onTap,
      child: isDesktop ? Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                  clipBehavior: Clip.antiAlias,
                  // Crucial: This tells the Container to clip its child according to the decoration's shape
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // You can also add a border here if needed
                    // border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Image.asset(
                      'assets/images/sumit_image.jpg', height: 200)),
              const SizedBox(width: 20),


              // Text Content
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Hey, I'm Sumit",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: colors['linkColor'],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    TypewriterAnimatedText(
                      titles: [
                        "Flutter & Cybersecurity Enthusiast.",
                        "Building Secure & Scalable Mobile Apps.",
                        "UI/UX Lover & Flutter Developer.",
                        "Open-Source Contributor & Problem Solver.",
                      ],
                      style: TextStyle(
                        fontSize: 16,
                        color: colors['secondaryText']!.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    if(position == false)
                        Text(
                           aboutMeText,
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: colors['linkColor'],
                            // Using the placeholder color
                          ),
                          maxLines: 3,
                          // trimLines: 3, // Will show 'Read More' if text is longer than 3 lines
                        ),
                      TextButton(
                        onPressed: () => _showGlassPopup(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            // decoration: TextDecoration.underline,
                            color:  colors['primaryAccent'],
                          ),
                        ),
                      ),


                  ],
                ),
              ),
            ],
          ),

          // Bottom-right arrow button
          if(position == true)
            Positioned(
              bottom: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isHovering
                      ? colors['primaryAccent']
                      : colors['background'],
                  shape: BoxShape.circle,
                  border: Border.all(color: colors['primaryAccent']!, width: 2),
                ),
                child: Icon(
                  FontAwesomeIcons.arrowRight,
                  color: isHovering
                      ? colors['cardColor']
                      : colors['primaryAccent'],
                  size: 20,
                ),
              ),
            ),
        ],
      ) : Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                  clipBehavior: Clip.antiAlias,
                  // Crucial: This tells the Container to clip its child according to the decoration's shape
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // You can also add a border here if needed
                    // border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Image.asset(
                      'assets/images/sumit_image.jpg', height: 200)),
              const SizedBox(width: 20),
              // Text Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Hey, I'm Jay ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: colors['linkColor'],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  TypewriterAnimatedText(
                    titles: [
                      "Flutter & Cybersecurity Enthusiast.",
                      "Building Secure & Scalable Mobile Apps.",
                      "UI/UX Lover & Flutter Developer.",
                      "Open-Source Contributor & Problem Solver.",
                    ],
                    style: TextStyle(
                      fontSize: 16,
                      color: colors['secondaryText']!.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  if(position == false)
    AboutMePopupText(
      text: aboutMeText,
      style: TextStyle(
        fontSize: 17,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: colors['linkColor'], // Using the placeholder color
      ),
      trimLines: 3, // Will show 'Read More' if text is longer than 3 lines
    ),




                ],
              ),
            ],
          ),

          // Bottom-right arrow button
          if(position == true)
            Positioned(
              bottom: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isHovering
                      ? colors['primaryAccent']
                      : colors['background'],
                  shape: BoxShape.circle,
                  border: Border.all(color: colors['primaryAccent']!, width: 2),
                ),
                child: Icon(
                  FontAwesomeIcons.arrowRight,
                  color: isHovering
                      ? colors['cardColor']
                      : colors['primaryAccent'],
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    ):GestureDetector(
      onTap: onTap,
      child: isDesktop ? Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                  clipBehavior: Clip.antiAlias,
                  // Crucial: This tells the Container to clip its child according to the decoration's shape
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // You can also add a border here if needed
                    // border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Image.asset(
                      'assets/images/sumit_image.jpg', height: 200)),
              // const SizedBox(h: 20),


              // Text Content
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Hey, I'm Sumit",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: colors['linkColor'],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    TypewriterAnimatedText(
                      titles: [
                        "Flutter & Cybersecurity Enthusiast.",
                        "Building Secure & Scalable Mobile Apps.",
                        "UI/UX Lover & Flutter Developer.",
                        "Open-Source Contributor & Problem Solver.",
                      ],
                      style: TextStyle(
                        fontSize: 16,
                        color: colors['secondaryText']!.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    if(position == false)
                      Text(
                        aboutMeText,
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          color: colors['linkColor'],
                          // Using the placeholder color
                        ),
                        maxLines: 3,
                        // trimLines: 3, // Will show 'Read More' if text is longer than 3 lines
                      ),
                    TextButton(
                      onPressed: () => _showGlassPopup(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Read More",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          // decoration: TextDecoration.underline,
                          color:  colors['primaryAccent'],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),

          // Bottom-right arrow button
          if(position == true)
            Positioned(
              bottom: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isHovering
                      ? colors['primaryAccent']
                      : colors['background'],
                  shape: BoxShape.circle,
                  border: Border.all(color: colors['primaryAccent']!, width: 2),
                ),
                child: Icon(
                  FontAwesomeIcons.arrowRight,
                  color: isHovering
                      ? colors['cardColor']
                      : colors['primaryAccent'],
                  size: 20,
                ),
              ),
            ),
        ],
      ) : Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                  clipBehavior: Clip.antiAlias,
                  // Crucial: This tells the Container to clip its child according to the decoration's shape
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // You can also add a border here if needed
                    // border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Image.asset(
                      'assets/images/sumit_image.jpg', height: 200)),
              const SizedBox(width: 20),
              // Text Content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Hey, I'm Sumit",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: colors['linkColor'],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  TypewriterAnimatedText(
                    titles: [
                      "Flutter & Cybersecurity Enthusiast.",
                      "Building Secure & Scalable Mobile Apps.",
                      "UI/UX Lover & Flutter Developer.",
                      "Open-Source Contributor & Problem Solver.",
                    ],
                    style: TextStyle(
                      fontSize: 16,
                      color: colors['secondaryText']!.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  if(position == false)
                    AboutMePopupText(
                      text: aboutMeText,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: colors['linkColor'], // Using the placeholder color
                      ),
                      trimLines: 3, // Will show 'Read More' if text is longer than 3 lines
                    ),




                ],
              ),
            ],
          ),

          // Bottom-right arrow button
          if(position == true)
            Positioned(
              bottom: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isHovering
                      ? colors['primaryAccent']
                      : colors['background'],
                  shape: BoxShape.circle,
                  border: Border.all(color: colors['primaryAccent']!, width: 2),
                ),
                child: Icon(
                  FontAwesomeIcons.arrowRight,
                  color: isHovering
                      ? colors['cardColor']
                      : colors['primaryAccent'],
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

}


class AboutMePopupText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle style;
  final int trimLines;

  const AboutMePopupText({
    super.key,
    required this.text,
    required this.style,
    this.trimLines = 3,
  });

  @override
  ConsumerState<AboutMePopupText> createState() => _AboutMePopupTextState();
}

class _AboutMePopupTextState extends ConsumerState<AboutMePopupText> {
  final GlobalKey _textKey = GlobalKey();
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    final RenderBox? renderBox = _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: renderBox.size.width);

    final bool didExceed = textPainter.didExceedMaxLines;

    if (didExceed != _isOverflowing) {
      setState(() {
        _isOverflowing = didExceed;
      });
    }
  }

  // --- Pop-up Logic: Call the new Standard Dialog ---
  void _showGlassPopup(BuildContext context) {
    // Using showDialog is the standard way to show a Material dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // We call the new standard dialog here
        return _StandardDialog(text: widget.text, style: widget.style);
      },
    );
  }
  // ----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          key: _textKey,
          style: widget.style,
          maxLines: widget.trimLines,
          overflow: TextOverflow.ellipsis,
        ),
        if (_isOverflowing)
          SizedBox(height: 15,),
        if (_isOverflowing)
          TextButton(
            onPressed: () => _showGlassPopup(context),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "Read More",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                // decoration: TextDecoration.underline,
                color:  colors['primaryAccent'],
              ),
            ),
          ),
      ],
    );
  }
}
/// The standard Material Design style dialog content
class _StandardDialog extends ConsumerStatefulWidget {
  final String text;
  final TextStyle style;

  const _StandardDialog({required this.text, required this.style});

  @override
  ConsumerState<_StandardDialog> createState() => _StandardDialogState();
}

class _StandardDialogState extends ConsumerState<_StandardDialog> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);


    // Simplified style copy for the dialog content
    final dialogTextStyle = widget.style.copyWith(
      color:  colors['secondaryText']
    );

    return Dialog(
      child: ProfessionalCard(
        isHero: true,
        customHeight:400,
        // customWidth: 400,
        child: Container(
          constraints: const BoxConstraints(
            // maxWidth: 400,
            // maxHeight: 500,
          ),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors['background'],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header (Title and Close Button)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "About Me",
                      style: dialogTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color:  colors['PrimaryText'],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:  colors['cardColor'], // Standard hover/tap color
                      ),
                      child: Icon(
                        Icons.close,
                        size: 22,
                        color:  colors['secondaryText']
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),

              // Scroll text
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.text,
                      style: dialogTextStyle.copyWith(
                        fontSize: 17,
                        height: 1.5,
                      ),
                    ),
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

class _AnimatedTitle extends StatefulWidget {
  final List<String> titles;
  final TextStyle? style;
  final Duration duration;

  const _AnimatedTitle({
    required this.titles, this.style, required this.duration,
  });

  @override
  State<_AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<_AnimatedTitle> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.titles.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Text(
        widget.titles[_currentIndex],
        key: ValueKey(_currentIndex),
        style: widget.style,
      ),
    );
  }
}


class TypewriterAnimatedText extends StatefulWidget {
  final List<String> titles;
  final TextStyle? style;
  final Duration charDuration;
  final Duration pauseDuration;

  const TypewriterAnimatedText({
    required this.titles,
    this.style,
    this.charDuration = const Duration(milliseconds: 100),
    this.pauseDuration = const Duration(seconds: 2),
    super.key,
  });

  @override
  State<TypewriterAnimatedText> createState() => _TypewriterAnimatedTextState();
}

class _TypewriterAnimatedTextState extends State<TypewriterAnimatedText> {
  int _titleIndex = 0;
  int _charIndex = 0;
  String _displayText = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.charDuration, (timer) {
      setState(() {
        _displayText = widget.titles[_titleIndex].substring(0, _charIndex + 1);
        _charIndex++;
      });

      if (_charIndex == widget.titles[_titleIndex].length) {
        _timer.cancel();
        Future.delayed(widget.pauseDuration, () {
          setState(() {
            _titleIndex = (_titleIndex + 1) % widget.titles.length;
            _charIndex = 0;
            _displayText = '';
            _startTyping();
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style,
    );
  }
}

// 7. Square Card Content (used by _ProfessionalCard)
class SquareCardContent extends ConsumerWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final String? imageUrl;
  final VoidCallback onTap;


  const SquareCardContent({
    required this.title,
    required this.subtitle,
    this.icon,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);
final isDesktop = MediaQuery.of(context).size.width<900;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Content (Image or Icon)
          if (imageUrl != null)
            SizedBox(
              width: 150,
              child: Positioned.fill(
                // Scale the image slightly on hover for a subtle zoom effect
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (c, o, s) => Container(
                    color: colors['background'],
                    child: Center(child: Icon(icon, color: colors['secondaryText']!.withOpacity(0.5), size: 60)),
                  ),
                ),
              ),
            ),

          // Placeholder Icon if no image
          if (imageUrl == null && icon != null)
            Positioned(
              top: 50,
              // left:  0,
              child: Icon(
                icon,
                color: Color(0xFF00ADB5),
                size: 50,
              ),
            ),

          // Text labels at the top-left
          Positioned(
            bottom: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors['secondaryText'],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: colors['linkColor'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Bottom-right arrow button

        ],
      ),
    );
  }
}

// 8. Accent Card Content (used by _ProfessionalCard)
// Placeholder structure for the two-tone card
class _project_card extends ConsumerWidget {
  final String title;
  final String subtitle;
  final String description;
  final Color accentColor;
  final VoidCallback onTap;
  final String imagePath; // Path for the runner/logo image

  const _project_card({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.accentColor,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(ref.watch(isDarkThemeProvider));
    final width = MediaQuery.of(context).size.width;
    // Card dimensions matching the previous Hero size
    final cardWidth = width > 900 ? (width / 2) - 50 : width - 80;
    const cardHeight = 250.0;

    // Determine the colors for the two halves
    final Color topBackgroundColor = isDarkMode
        ? const Color(0xFF404040) // Darker card background for dark mode
        : const Color(0xFFF7F7F7); // Light grey/off-white for light mode

    final Color bottomBackgroundColor = isDarkMode
        ? colors['cardColor']! // Your original dark card color
        : const Color(0xFF3A3A3A); // Dark gray for light mode bottom section

    final Color bottomTextColor = isDarkMode
        ? colors['linkColor']!
        : Colors.white;
    // final bool isHovering = parentState?._isHovering ?? false;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: colors['linkColor']!.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // --- TOP SECTION (Accent/Logo and Description) ---
            Container(
              height: cardHeight * 0.65, // 65% of the card height
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: topBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Runner Image
                      Image.asset(
                        imagePath,
                        height: 100,
                        width: width <900 ?160:200,
                        fit: BoxFit.cover
                        ,
                      ),
                      const SizedBox(height: 5),
                      // Logo Text (Subtitle)

                    ],
                  ),
                  const SizedBox(width: 20),
                  // Description Text
                  if(width >900)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colors['linkColor'],

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(alignment: Alignment.centerLeft,
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFF008C95),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      FontAwesomeIcons.arrowRight,
                      color: colors['secondaryText'],
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            // --- BOTTOM SECTION (Title and Arrow) ---
            // Bottom-right arrow button

          ],
        ),
      ),
    );
  }
}


const Color goldAccentColor = Color(0xFFFFB300); // Deep Amber/Gold

class WhatIDoCardContent extends ConsumerWidget {
  final VoidCallback onTap;

  const WhatIDoCardContent({required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the dynamic colors based on the current theme (Dark/Light)
    final colors = getCurrentColors(ref.watch(isDarkThemeProvider));

    // List of services with icons matching the image
    final List<Map<String, dynamic>> services = [
      {'label': 'MOBILE', 'icon': FontAwesomeIcons.mobileScreen}, // Using a phone icon
      {'label': 'WEB', 'icon': Icons.web_outlined},        // Using a globe icon
      {'label': 'DESKTOP', 'icon': Icons.desktop_windows_rounded},   // Using a desktop icon
    ];
    final width = MediaQuery.of(context).size.width;


    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end, // Align content to the bottom
            children: [
              // 1. Top Label
              Text(
                'WHAT I DO',
                style: TextStyle(
                  fontSize: 12,
                  color: colors['secondaryText'],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              // 2. Main Title
              Text(
                'I CAN DEVELOP APPS FOR',
                style: TextStyle(
                  fontSize: 18,
                  color: colors['linkColor'],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // 3. Service Icons and Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: services.map((service) {
                  return Column(
                    children: [
                      // Icon
                      Icon(
                        service['icon'] as IconData,
                        color: goldAccentColor, // Use the specific gold color
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      // Label
                      Text(
                        service['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors['secondaryText'],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),

          // 4. Bottom-right arrow button
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              FontAwesomeIcons.arrowRight, // Using FontAwesome arrow icon for consistency
              color: colors['secondaryText'],
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class GetInTouchCardContent extends ConsumerWidget {
  final VoidCallback onTap;

  const GetInTouchCardContent({required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = getCurrentColors(ref.watch(isDarkThemeProvider));

    // Determine the color for the "Get in touch now" text
    final Color highlightColor = colors['primaryAccent']!; // Or a specific golden color: const Color(0xFFFBC02D);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end, // Align content to the bottom
            children: [
              Row(
                children: [
                  Text(
                    "Let's work together ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colors['linkColor'],
                    ),
                  ),
                  Icon(FontAwesomeIcons.solidStar, color: highlightColor, size: 18), // Star icon
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Get in touch now",
                style: TextStyle(
                  fontSize: 28, // Larger font size
                  fontWeight: FontWeight.w900, // Extra bold
                  color: highlightColor,
                ),
              ),
            ],
          ),
          // Bottom-right arrow button
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.arrow_forward, // Using Material arrow icon
              color: colors['secondaryText'],
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}


/// ================== Animated Professional Card ==================
class AnimatedProfessionalCard extends ConsumerStatefulWidget {
  final Widget child;
  final bool isHero;
  final double? width;

  const AnimatedProfessionalCard({
    required this.child,
    this.isHero = false,
    this.width,
    super.key,
  });

  @override
  ConsumerState<AnimatedProfessionalCard> createState() =>
      _AnimatedProfessionalCardState();
}

class _AnimatedProfessionalCardState
    extends ConsumerState<AnimatedProfessionalCard> with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    // Entrance animation
    _hoverController.forward();
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);
    final cardWidth = widget.width ?? (widget.isHero ? 500 : 250);
    const cardHeight = 250.0;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovering = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _hovering = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.translate(
            offset: _slideAnimation.value * 50,
            child: Transform.scale(
              scale: _hovering ? _scaleAnimation.value : 1.0,
              child: Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  color: colors['cardColor'],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: _hovering ? colors['primaryAccent']! : colors['cardColor']!,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors['linkColor']!.withOpacity(_hovering ? 0.3 : 0.05),
                      blurRadius: 20,
                      offset: Offset(0, _hovering ? 15 : 4),
                    ),

                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ================== Animated Stats Card ==================
class AnimatedStatCard extends StatefulWidget {
  final String label;
  final int value;
  final Color color;
  final Duration duration;

  const AnimatedStatCard({
    required this.label,
    required this.value,
    required this.color,
    this.duration = const Duration(seconds: 2),
    super.key,
  });

  @override
  State<AnimatedStatCard> createState() => _AnimatedStatCardState();
}

class _AnimatedStatCardState extends State<AnimatedStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _counter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _counter = IntTween(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    )..addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;
    return MouseRegion(
      onEnter: (_) => _controller.forward(from: 0),
      child: Container(
        width: isMobile? 100:140,
        height:isMobile? 100:140,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_counter.value}+",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: widget.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// New Feature: Social Media Links Section
class SocialMediaLinks extends ConsumerWidget {
  final double baseFontSize;
  const SocialMediaLinks({required this.baseFontSize});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback for debug / error
      debugPrint('Could not launch URL: $url');
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);
    final primaryTextColor = colors['linkColor'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Connect With Me",
          style: TextStyle(
            fontSize: baseFontSize + 8,
            fontWeight: FontWeight.w800,
            color: primaryTextColor,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _SocialIcon(
              icon: FontAwesomeIcons.linkedinIn,
              label: "LinkedIn",
              url: "https://www.linkedin.com/in/sumit-jatiya/",
              accentColor: const Color(0xFF0A66C2),
              onTap: () => _launchURL("https://www.linkedin.com/in/sumit-jatiya/"),
            ),

            _SocialIcon(
              icon: FontAwesomeIcons.github,
              label: "GitHub",
              url: "https://github.com/sumit-jatiya",
              accentColor: Colors.black,
              onTap: () => _launchURL("https://github.com/sumit-jatiya"),
            ),

            // _SocialIcon(
            //   icon: FontAwesomeIcons.stackOverflow,
            //   label: "StackOverflow",
            //   url: "https://stackoverflow.com/users/omarkhaled",
            //   accentColor: Colors.orange,
            //   onTap: () => _launchURL("https://stackoverflow.com/users/omarkhaled"),
            // ),
            _SocialIcon(
              icon: FontAwesomeIcons.youtube,
              label: "Youtube",
              url: "https://youtube.com/@boolmont?si=FNKRfQR_fuAMHlqO",
              accentColor: Colors.red,
              onTap: () => _launchURL("https://youtube.com/@boolmont?si=FNKRfQR_fuAMHlqO"),
            ),

            _SocialIcon(
              icon: FontAwesomeIcons.twitter,
              label: "Twitter/X",
              url: "https://twitter.com/omarkhaled",
              accentColor: const Color(0xFF1DA1F2),
              onTap: () => _launchURL("https://twitter.com/omarkhaled"),
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.instagram,
              label: "Instagram",
              url: "",
              accentColor: Colors.pinkAccent,
              onTap: () => _launchURL("d"),
            ), _SocialIcon(
              icon: FontAwesomeIcons.facebook,
              label: "Facebook",
              url: "",
              accentColor: Colors.blue,
              onTap: () => _launchURL(""),
            ),
          ],
        ),
      ],
    );
  }
}

// New Feature: Animated Social Icon
class _SocialIcon extends ConsumerStatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color accentColor;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.url,
    required this.accentColor,
    required this.onTap,
  });

  @override
  ConsumerState<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends ConsumerState<_SocialIcon> with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_scaleController);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onHover(bool hover) {
    setState(() {
      _isHovering = hover;
    });
    if (hover) {
      _scaleController.forward();
    } else {
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            width: 150,
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(

              color: _isHovering ? widget.accentColor.withOpacity(0.9) : colors['cardColor'],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.accentColor.withOpacity(_isHovering ? 1.0 : 0.5), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  size: 20,
                  color: _isHovering ? Colors.white : widget.accentColor,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _isHovering ? Colors.white : colors['linkColor'],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}