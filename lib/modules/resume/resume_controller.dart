import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/resume_model.dart';

final resumeErrorProvider = StateProvider<String?>((ref) => null);

final resumeListProvider = StateNotifierProvider<ResumeController, List<ResumeModel>>(
      (ref) => ResumeController(ref),
);

class ResumeController extends StateNotifier<List<ResumeModel>> {
  final Ref ref;
  ResumeController(this.ref) : super([]);

  /// Add new resume
  void addResume(ResumeModel resume) {
    try {
      state = [...state, resume];
      ref.read(resumeErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(resumeErrorProvider.notifier).state = e.toString();
    }
  }

  /// Update resume by id
  void updateResume(String id, ResumeModel updatedResume) {
    try {
      state = [
        for (final r in state)
          if (r.id == id) updatedResume else r
      ];
      ref.read(resumeErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(resumeErrorProvider.notifier).state = e.toString();
    }
  }

  /// Delete resume by id
  void deleteResume(String id) {
    try {
      state = state.where((r) => r.id != id).toList();
      ref.read(resumeErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(resumeErrorProvider.notifier).state = e.toString();
    }
  }

  /// Get resume by id
  ResumeModel? getResumeById(String id) {
    try {
      return state.firstWhere((r) => r.id == id);
    } catch (e) {
      ref.read(resumeErrorProvider.notifier).state = "Resume not found";
      return null;
    }
  }

  /// Search resumes by title
  List<ResumeModel> searchResumes(String keyword) {
    return state.where((r) => r.title.toLowerCase().contains(keyword.toLowerCase())).toList();
  }

  /// Filter resumes by skill
  List<ResumeModel> filterBySkill(String skill) {
    return state.where((r) =>
        r.skills.any((s) => s.toLowerCase().contains(skill.toLowerCase()))
    ).toList();
  }

  /// Fetch resumes (simulate async fetch)
  Future<void> fetchResumes() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      // state = fetchedData; // integrate API/Firebase here
      ref.read(resumeErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(resumeErrorProvider.notifier).state = e.toString();
    }
  }
}
