import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/app/constants/custom_app_bar.dart';
import 'package:portfolio/modules/projects/projects_controller.dart';
import '../../app/theme/app_theme.dart';
import '../../core/models/project_model.dart';

class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  String _searchKeyword = '';
  String _filterTech = '';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    Future.delayed(const Duration(milliseconds: 150), () {
      _controller.forward();
    });

    // Fetch projects from controller
    Future.microtask(() => ref.read(projectListProvider.notifier).fetchProjects());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkThemeProvider);
    final colors = getCurrentColors(isDarkMode);

    final projects = ref.watch(projectListProvider);
    final error = ref.watch(projectErrorProvider);

    final filteredProjects = projects.where((project) {
      final matchesSearch = _searchKeyword.trim().isEmpty ||
          project.title.toLowerCase().contains(_searchKeyword.trim().toLowerCase());

      final matchesTech = _filterTech.trim().isEmpty ||
          project.technologies
              .any((t) => t.toLowerCase() == _filterTech.trim().toLowerCase());

      return matchesSearch && matchesTech;
    }).toList();

    return Scaffold(
      backgroundColor: colors['background'],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNavigationBar(isDesktop: true),
              Center(
                child: Text(
                  "My Projects",
                  style: getBodyStyle(colors['secondaryText']!, 24),
                ),
              ),
              const SizedBox(height: 16),

              // Search Field
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search projects...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (val) {
                  setState(() => _searchKeyword = val);
                },
              ),

              const SizedBox(height: 12),

              // Technology Filter Chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: _filterTech.isEmpty,
                      onSelected: (_) => setState(() => _filterTech = ''),
                    ),
                    const SizedBox(width: 6),
                    ...ref
                        .read(projectListProvider.notifier)
                        .getAllTechnologies()
                        .map((tech) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(tech),
                        selected:
                        _filterTech.toLowerCase() == tech.toLowerCase(),
                        onSelected: (_) => setState(() => _filterTech = tech),
                      ),
                    ))
                        .toList(),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              if (error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                )
              else if (filteredProjects.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No projects found.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              else
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = constraints.maxWidth > 1400
                          ? 4
                          : constraints.maxWidth > 1100
                          ? 3
                          : constraints.maxWidth > 700
                          ? 2
                          : 1;

                      return GridView.builder(
                        itemCount: filteredProjects.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 1.25,
                        ),
                        itemBuilder: (context, index) {
                          final project = filteredProjects[index];
                          return _AnimatedProjectCard(
                            index: index,
                            title: project.title,
                            subtitle: project.role.isNotEmpty
                                ? project.role
                                : project.category,
                            status: project.isOngoing
                                ? 'In Progress'
                                : 'Completed',
                            tags: project.technologies,
                            imageUrl: project.imageUrl,
                            isDarkMode: isDarkMode,
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------- Animated Project Card -------------------------
class _AnimatedProjectCard extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final String status;
  final List<String> tags;
  final String imageUrl;
  final bool isDarkMode;

  const _AnimatedProjectCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.tags,
    required this.imageUrl,
    required this.isDarkMode,
  });

  @override
  State<_AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<_AnimatedProjectCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final colors = getCurrentColors(widget.isDarkMode);

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + widget.index * 120),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 25),
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: colors['cardColor'],
            border: Border.all(
              width: 1.4,
              color: hover
                  ? colors['linkColor']!.withOpacity(0.5)
                  : colors['secondaryText']!.withOpacity(0.1),
            ),
            boxShadow: hover
                ? [
              BoxShadow(
                blurRadius: 30,
                color: colors['linkColor']!.withOpacity(0.25),
                offset: const Offset(0, 6),
              ),
            ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: widget.imageUrl.isNotEmpty
                    ? Image.network(
                  widget.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: colors['secondaryText']!.withOpacity(0.1),
                      child: const Center(child: Icon(Icons.broken_image)),
                    );
                  },
                )
                    : Container(
                  height: 120,
                  color: colors['secondaryText']!.withOpacity(0.1),
                  child: const Center(child: Icon(Icons.image)),
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.title,
                  style: getSubtitleStyle(colors['linkColor']!, 19)),
              Text(widget.subtitle,
                  style: getBodyStyle(colors['secondaryText']!, 13)),
              const Spacer(),
              Wrap(
                spacing: 8,
                children: widget.tags
                    .map(
                      (tag) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: colors['background']!.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 11,
                        color: colors['textColor'],
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusColor(widget.status).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    widget.status,
                    style: TextStyle(
                      color: _statusColor(widget.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
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

  Color _statusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.greenAccent;
      case "In Progress":
        return Colors.orangeAccent;
      case "In Review":
        return Colors.blueAccent;
      default:
        return Colors.white;
    }
  }
}
