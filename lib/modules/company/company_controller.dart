import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/company_model.dart';

final companyErrorProvider = StateProvider<String?>((ref) => null);

final companyListProvider = StateNotifierProvider<CompanyController, List<CompanyModel>>(
      (ref) => CompanyController(ref),
);

class CompanyController extends StateNotifier<List<CompanyModel>> {
  final Ref ref;
  CompanyController(this.ref) : super([]);

  void addCompany(CompanyModel company) {
    try {
      state = [...state, company];
      ref.read(companyErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(companyErrorProvider.notifier).state = e.toString();
    }
  }

  void updateCompany(String id, CompanyModel updatedCompany) {
    try {
      state = [
        for (final c in state)
          if (c.id == id) updatedCompany else c
      ];
      ref.read(companyErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(companyErrorProvider.notifier).state = e.toString();
    }
  }

  void deleteCompany(String id) {
    try {
      state = state.where((c) => c.id != id).toList();
      ref.read(companyErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(companyErrorProvider.notifier).state = e.toString();
    }
  }

  CompanyModel? getCompanyById(String id) {
    try {
      return state.firstWhere((c) => c.id == id);
    } catch (e) {
      ref.read(companyErrorProvider.notifier).state = "Company not found";
      return null;
    }
  }

  List<CompanyModel> searchByName(String name) {
    return state.where((c) => c.name.toLowerCase().contains(name.toLowerCase())).toList();
  }

  List<CompanyModel> filterByService(String service) {
    return state.where((c) => c.services.any((s) => s.toLowerCase().contains(service.toLowerCase()))).toList();
  }

  Future<void> fetchCompanies() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(companyErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(companyErrorProvider.notifier).state = e.toString();
    }
  }
}
