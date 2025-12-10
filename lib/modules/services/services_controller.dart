import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/service_model.dart';

final serviceErrorProvider = StateProvider<String?>((ref) => null);

final serviceListProvider = StateNotifierProvider<ServiceController, List<ServiceModel>>(
      (ref) => ServiceController(ref),
);

class ServiceController extends StateNotifier<List<ServiceModel>> {
  final Ref ref;
  ServiceController(this.ref) : super([]);

  void addService(ServiceModel service) {
    try {
      state = [...state, service];
      ref.read(serviceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(serviceErrorProvider.notifier).state = e.toString();
    }
  }

  void updateService(String id, ServiceModel updatedService) {
    try {
      state = [
        for (final s in state)
          if (s.id == id) updatedService else s
      ];
      ref.read(serviceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(serviceErrorProvider.notifier).state = e.toString();
    }
  }

  void deleteService(String id) {
    try {
      state = state.where((s) => s.id != id).toList();
      ref.read(serviceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(serviceErrorProvider.notifier).state = e.toString();
    }
  }

  ServiceModel? getServiceById(String id) {
    try {
      return state.firstWhere((s) => s.id == id);
    } catch (e) {
      ref.read(serviceErrorProvider.notifier).state = "Service not found";
      return null;
    }
  }

  List<ServiceModel> searchByTitle(String title) {
    return state.where((s) => s.title.toLowerCase().contains(title.toLowerCase())).toList();
  }

  Future<void> fetchServices() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(serviceErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(serviceErrorProvider.notifier).state = e.toString();
    }
  }
}
