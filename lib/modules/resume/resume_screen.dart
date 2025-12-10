// lib/screens/resume_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/modules/resume/resume_controller.dart';
import '../../app/theme/app_theme.dart';
import '../../app/constants/custom_app_bar.dart';
import '../../core/models/resume_model.dart';
import '../../widgets/custom_widgets.dart';

class ResumeScreen extends ConsumerStatefulWidget {
  const ResumeScreen({super.key});

  @override
  ConsumerState<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends ConsumerState<ResumeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeSlideController;

  @override
  void initState() {
    super.initState();
    _fadeSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeSlideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDark);

    // final resumeAsync = ref.watch(resumeProvider);

    return Scaffold(
      backgroundColor: colors['background'],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNavigationBar(isDesktop: true),
              const SizedBox(height: 20),
              Text(
                "Resume",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: colors['linkColor'],
                ),
              ),
              const SizedBox(height: 10),
              // Expanded(
              //   child: resumeAsync.when(
              //     data: (resume) => _buildResumeContent(resume, colors),
              //     loading: () => const Center(child: CircularProgressIndicator()),
              //     error: (err, _) => Center(
              //       child: Text(
              //         'Error loading resume: $err',
              //         style: TextStyle(color: Colors.red),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildResumeContent(ResumeData resume, Map colors) {
  //   return ListView(
  //     children: [
  //       _staggeredFadeSlide(_sectionTitle("Experience", colors), 0),
  //       const SizedBox(height: 12),
  //       ...resume.experiences.asMap().entries.map((entry) {
  //         return Padding(
  //           padding: const EdgeInsets.only(bottom: 12),
  //           child: _staggeredFadeSlide(
  //             _infoCard(
  //               title: entry.value.title,
  //               subtitle: "${entry.value.company} • ${entry.value.year}",
  //               desc: entry.value.description,
  //               colors: colors,
  //             ),
  //             entry.key + 1,
  //           ),
  //         );
  //       }).toList(),
  //       const SizedBox(height: 20),
  //       _staggeredFadeSlide(_sectionTitle("Education", colors), 0),
  //       const SizedBox(height: 12),
  //       ...resume.education.asMap().entries.map((entry) {
  //         return Padding(
  //           padding: const EdgeInsets.only(bottom: 12),
  //           child: _staggeredFadeSlide(
  //             _infoCard(
  //               title: entry.value.degree,
  //               subtitle: "${entry.value.school} • ${entry.value.year}",
  //               desc: entry.value.description,
  //               colors: colors,
  //             ),
  //             entry.key + 1,
  //           ),
  //         );
  //       }).toList(),
  //       const SizedBox(height: 20),
  //       _staggeredFadeSlide(_sectionTitle("Skills", colors), 0),
  //       const SizedBox(height: 12),
  //       _skillsGrid(colors, resume.skills),
  //     ],
  //   );
  // }

  Widget _staggeredFadeSlide(Widget child, int index) {
    final intervalStart = 0.05 * index;
    final intervalEnd = intervalStart + 0.5;

    return AnimatedBuilder(
      animation: _fadeSlideController,
      builder: (context, _) {
        double t = ((_fadeSlideController.value - intervalStart) /
            (intervalEnd - intervalStart))
            .clamp(0.0, 1.0);

        final animValue = Curves.easeOut.transform(t);

        return Opacity(
          opacity: animValue,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - animValue)),
            child: child,
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title, Map colors) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: colors['linkColor'],
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String subtitle,
    required String desc,
    required Map colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors['cardColor'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: getSoftShadows(
          colors['cardColor']!,
          colors['background']!,
          false,
          false,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: getSubtitleStyle(colors['linkColor']!, 18)),
          const SizedBox(height: 4),
          Text(subtitle, style: getBodyStyle(colors['secondaryText']!, 12)),
          if (desc.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(desc, style: getBodyStyle(colors['secondaryText']!, 13)),
          ],
        ],
      ),
    );
  }

  // Widget _skillsGrid(Map colors, List<Skill> skills) {
  //   return Wrap(
  //     spacing: 12,
  //     runSpacing: 12,
  //     children: skills
  //         .map(
  //           (skill) => Container(
  //         padding:
  //         const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //         decoration: BoxDecoration(
  //           color: colors['cardColor'],
  //           borderRadius: BorderRadius.circular(22),
  //           border: Border.all(
  //             color: colors['linkColor']!.withOpacity(0.3),
  //             width: 1,
  //           ),
  //         ),
  //         child: Text(
  //           skill.name,
  //           style: TextStyle(
  //             fontSize: 13,
  //             color: colors['linkColor'],
  //           ),
  //         ),
  //       ),
  //     )
  //         .toList(),
  //   );
  // }
}
