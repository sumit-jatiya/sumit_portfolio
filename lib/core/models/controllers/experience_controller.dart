import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../experience_model.dart';

final experienceErrorProvider = StateProvider<String?>((ref) => null);

final experienceListProvider = StateNotifierProvider<ExperienceController, List<ExperienceModel>>(
      (ref) => ExperienceController(ref),
);

class ExperienceController extends StateNotifier<List<ExperienceModel>> {
  final Ref ref;
  ExperienceController(this.ref) : super([]);

  void addExperience(ExperienceModel experience) {
    try {
      state = [...state, experience];
      ref.read(experienceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(experienceErrorProvider.notifier).state = e.toString();
    }
  }

  void updateExperience(String id, ExperienceModel updatedExperience) {
    try {
      state = [
        for (final exp in state)
          if (exp.id == id) updatedExperience else exp
      ];
      ref.read(experienceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(experienceErrorProvider.notifier).state = e.toString();
    }
  }

  void deleteExperience(String id) {
    try {
      state = state.where((exp) => exp.id != id).toList();
      ref.read(experienceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(experienceErrorProvider.notifier).state = e.toString();
    }
  }

  ExperienceModel? getExperienceById(String id) {
    try {
      return state.firstWhere((exp) => exp.id == id);
    } catch (e) {
      ref.read(experienceErrorProvider.notifier).state = "Experience not found";
      return null;
    }
  }

  List<ExperienceModel> searchByRole(String role) {
    return state.where((exp) => exp.role.toLowerCase().contains(role.toLowerCase())).toList();
  }

  List<ExperienceModel> filterByCompany(String companyId) {
    return state.where((exp) => exp.companyId == companyId).toList();
  }

  Future<void> fetchExperiences() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(experienceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(experienceErrorProvider.notifier).state = e.toString();
    }
  }
}
