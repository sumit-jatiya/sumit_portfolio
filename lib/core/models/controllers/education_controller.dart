import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../education_model.dart';

final educationErrorProvider = StateProvider<String?>((ref) => null);

final educationListProvider = StateNotifierProvider<EducationController, List<EducationModel>>(
      (ref) => EducationController(ref),
);

class EducationController extends StateNotifier<List<EducationModel>> {
  final Ref ref;
  EducationController(this.ref) : super([]);

  void addEducation(EducationModel education) {
    try {
      state = [...state, education];
      ref.read(educationErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(educationErrorProvider.notifier).state = e.toString();
    }
  }

  void updateEducation(String id, EducationModel updatedEducation) {
    try {
      state = [
        for (final edu in state)
          if (edu.id == id) updatedEducation else edu
      ];
      ref.read(educationErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(educationErrorProvider.notifier).state = e.toString();
    }
  }

  void deleteEducation(String id) {
    try {
      state = state.where((edu) => edu.id != id).toList();
      ref.read(educationErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(educationErrorProvider.notifier).state = e.toString();
    }
  }

  EducationModel? getEducationById(String id) {
    try {
      return state.firstWhere((edu) => edu.id == id);
    } catch (e) {
      ref.read(educationErrorProvider.notifier).state = "Education not found";
      return null;
    }
  }

  List<EducationModel> searchByDegree(String degree) {
    return state.where((edu) => edu.degree.toLowerCase().contains(degree.toLowerCase())).toList();
  }

  Future<void> fetchEducation() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(educationErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(educationErrorProvider.notifier).state = e.toString();
    }
  }
}
