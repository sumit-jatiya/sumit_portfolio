import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/project_model.dart';

/// Error state provider for project operations
final projectErrorProvider = StateProvider<String?>((ref) => null);

/// Loading state provider
final projectLoadingProvider = StateProvider<bool>((ref) => false);

/// Project list state provider
final projectListProvider =
StateNotifierProvider<ProjectController, List<ProjectModel>>(
      (ref) => ProjectController(ref),
);

class ProjectController extends StateNotifier<List<ProjectModel>> {
  final Ref ref;

  ProjectController(this.ref) : super([]);

  /// Add a new project
  Future<void> addProject(ProjectModel project) async {
    try {
      ref.read(projectLoadingProvider.notifier).state = true;
      await Future.delayed(const Duration(milliseconds: 500)); // simulate delay
      state = [...state, project];
      ref.read(projectErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(projectErrorProvider.notifier).state = "Failed to add project: $e";
    } finally {
      ref.read(projectLoadingProvider.notifier).state = false;
    }
  }

  /// Update a project by ID
  Future<void> updateProject(String id, ProjectModel updatedProject) async {
    try {
      ref.read(projectLoadingProvider.notifier).state = true;
      await Future.delayed(const Duration(milliseconds: 500));
      if (!state.any((p) => p.id == id)) {
        throw "Project not found";
      }
      state = [
        for (final project in state)
          if (project.id == id) updatedProject else project
      ];
      ref.read(projectErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(projectErrorProvider.notifier).state = "Update failed: $e";
    } finally {
      ref.read(projectLoadingProvider.notifier).state = false;
    }
  }

  /// Delete a project by ID
  Future<void> deleteProject(String id) async {
    try {
      ref.read(projectLoadingProvider.notifier).state = true;
      await Future.delayed(const Duration(milliseconds: 500));
      if (!state.any((p) => p.id == id)) {
        throw "Project not found";
      }
      state = state.where((project) => project.id != id).toList();
      ref.read(projectErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(projectErrorProvider.notifier).state = "Delete failed: $e";
    } finally {
      ref.read(projectLoadingProvider.notifier).state = false;
    }
  }

  /// Get a project by ID
  ProjectModel? getProjectById(String id) {
    try {
      return state.firstWhere((project) => project.id == id);
    } catch (e) {
      ref.read(projectErrorProvider.notifier).state = "Project not found";
      return null;
    }
  }

  /// Check if project exists by ID
  bool existsById(String id) {
    return state.any((project) => project.id == id);
  }

  /// Search projects by title
  List<ProjectModel> searchProjects(String keyword) {
    return state
        .where((project) =>
        project.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  /// Filter projects by a specific technology
  List<ProjectModel> filterByTechnology(String tech) {
    return state
        .where((project) => project.technologies
        .any((t) => t.toLowerCase().contains(tech.toLowerCase())))
        .toList();
  }

  /// Get all unique technologies used in projects
  List<String> getAllTechnologies() {
    final techSet = <String>{};
    for (final project in state) {
      techSet.addAll(project.technologies.map((t) => t.toLowerCase()));
    }
    return techSet.toList();
  }

  /// Sort projects by date
  void sortByDate({bool ascending = true}) {
    state = [...state]
      ..sort((a, b) => ascending
          ? a.startDate.compareTo(b.startDate)
          : b.startDate.compareTo(a.startDate));
  }

  /// Fetch projects (simulate async fetch)
  Future<void> fetchProjects() async {
    try {
      ref.read(projectLoadingProvider.notifier).state = true;
      final snapshot = await FirebaseFirestore.instance.collection('projects').get();

      state = snapshot.docs
          .map((doc) => ProjectModel.fromJson(doc.data()))
          .toList();

      ref.read(projectErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(projectErrorProvider.notifier).state = "Fetch failed: $e";
    } finally {
      ref.read(projectLoadingProvider.notifier).state = false;
    }
  }

  /// Clear all projects
  void clearAllProjects() {
    state = [];
  }
}
