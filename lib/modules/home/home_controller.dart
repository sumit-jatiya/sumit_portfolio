import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/data/sample_data.dart';
import '../../core/models/company_model.dart';
import '../../core/models/project_model.dart';
import '../../core/models/service_model.dart';
import '../../core/models/user_model.dart';

/// ---------------------------
/// Home State Class
/// ---------------------------
class HomeState {
  final UserModel user;
  final CompanyModel company;
  final List<ServiceModel> services;
  final List<ProjectModel> projects;
  final int selectedTab;
  final bool isLoading;
  final String? errorMessage;

  HomeState({
    required this.user,
    required this.company,
    required this.services,
    required this.projects,
    this.selectedTab = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    UserModel? user,
    CompanyModel? company,
    List<ServiceModel>? services,
    List<ProjectModel>? projects,
    int? selectedTab,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      user: user ?? this.user,
      company: company ?? this.company,
      services: services ?? this.services,
      projects: projects ?? this.projects,
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// ---------------------------
/// Home Controller (StateNotifier)
/// ---------------------------
class HomeController extends StateNotifier<HomeState> {
  HomeController()
      : super(HomeState(
    user: UserModel.empty(),
    company: CompanyModel.empty(),
    services: [],
    projects: [],
  ));


  /// ---------------------------
  /// LOAD INITIAL DATA
  /// ---------------------------
  // Future<void> _loadInitialData() async {
  //   try {
  //     state = state.copyWith(isLoading: true);
  //
  //     await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
  //
  //     state = state.copyWith(
  //       user: SampleData.sampleUser,
  //       company: SampleData.company,
  //       services: SampleData.services,
  //       projects: SampleData.projects,
  //       isLoading: false,
  //       errorMessage: null,
  //     );
  //   } catch (e, stackTrace) {
  //     debugPrint("Error loading data: $e");
  //     debugPrintStack(stackTrace: stackTrace);
  //     state = state.copyWith(isLoading: false, errorMessage: e.toString());
  //   }
  // }

  /// ---------------------------
  /// CHANGE TAB
  /// ---------------------------
  void changeTab(int index) {
    state = state.copyWith(selectedTab: index);
  }

  /// ---------------------------
  /// ADD SERVICE
  /// ---------------------------
  void addService(ServiceModel service) {
    try {
      final updated = [...state.services, service];
      state = state.copyWith(services: updated);
    } catch (e) {
      debugPrint("Error adding service: $e");
    }
  }

  /// ---------------------------
  /// ADD PROJECT
  /// ---------------------------
  void addProject(ProjectModel project) {
    try {
      final updated = [...state.projects, project];
      state = state.copyWith(projects: updated);
    } catch (e) {
      debugPrint("Error adding project: $e");
    }
  }

  /// ---------------------------
  /// FEATURED PROJECTS
  /// ---------------------------
  // List<ProjectModel> get featuredProjects =>
  //     state.projects.where((p) => p.isFeatured).toList();

  /// ---------------------------
  /// FILTER PROJECTS BY CATEGORY
  /// ---------------------------
  List<ProjectModel> filterProjects(String category) {
    try {
      return state.projects.where((p) => p.category == category).toList();
    } catch (e) {
      debugPrint("Error filtering projects: $e");
      return [];
    }
  }

  /// ---------------------------
  /// SEARCH PROJECTS / SERVICES
  /// ---------------------------
  List<ProjectModel> searchProjects(String query) {
    return state.projects
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<ServiceModel> searchServices(String query) {
    return state.services
        .where((s) => s.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// ---------------------------
  /// SORT PROJECTS BY DATE
  /// ---------------------------
  // List<ProjectModel> sortProjectsByDate({bool descending = true}) {
  //   final sorted = [...state.projects];
  //   sorted.sort((a, b) =>
  //   descending ? b.createdAt.compareTo(a.createdAt) : a.createdAt.compareTo(b.createdAt));
  //   return sorted;
  // }

  /// ---------------------------
  /// GET SERVICE BY ID
  /// ---------------------------
  ServiceModel? getServiceById(String id) {
    try {
      return state.services.firstWhere((s) => s.id == id);
    } catch (e) {
      debugPrint("Service not found: $e");
      return null;
    }
  }

  /// ---------------------------
  /// GET PROJECT BY ID
  /// ---------------------------
  ProjectModel? getProjectById(String id) {
    try {
      return state.projects.firstWhere((p) => p.id == id);
    } catch (e) {
      debugPrint("Project not found: $e");
      return null;
    }
  }

  /// ---------------------------
  /// REFRESH PORTFOLIO
  /// ---------------------------
  Future<void> refreshPortfolio() async {
    // await _loadInitialData();
  }
}

/// ---------------------------
/// Provider
/// ---------------------------
final homeControllerProvider =
StateNotifierProvider<HomeController, HomeState>((ref) => HomeController());










/// ---------------------------
/// Provider
/// ---------------------------
// final homeControllerProvider =
// StateNotifierProvider<HomeController, HomeState>((ref) => HomeController(_\\\\));

// State provider for error handling
final userErrorProvider = StateProvider<String?>((ref) => null);

// User list provider


// ------------------ ERROR PROVIDER ------------------
// Remove this if already defined elsewhere
// final userErrorProvider = StateProvider<String?>((ref) => null);

// ------------------ USER LIST PROVIDER ------------------
final userListProvider = StateNotifierProvider<UserController, List<UserModel>>(
      (ref) => UserController(ref),
);

class UserController extends StateNotifier<List<UserModel>> {
  final Ref ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserController(this.ref) : super([]);

  /// ------------------ CRUD METHODS ------------------

  /// Add new user locally
  void addUser(UserModel user) {
    try {
      state = [...state, user];
      ref.read(userErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(userErrorProvider.notifier).state = e.toString();
    }
  }

  /// Update user locally by id
  void updateUser(String id, UserModel updatedUser) {
    try {
      state = [
        for (final user in state)
          if (user.id == id) updatedUser else user
      ];
      ref.read(userErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(userErrorProvider.notifier).state = e.toString();
    }
  }

  /// Delete user locally by id
  void deleteUser(String id) {
    try {
      state = state.where((user) => user.id != id).toList();
      ref.read(userErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(userErrorProvider.notifier).state = e.toString();
    }
  }

  /// Fetch user by id locally
  UserModel? getUserById(String id) {
    try {
      return state.firstWhere((user) => user.id == id);
    } catch (e) {
      ref.read(userErrorProvider.notifier).state = "User not found";
      return null;
    }
  }

  /// Search users by name
  List<UserModel> searchUsers(String keyword) {
    return state
        .where((user) =>
        user.fullName.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  /// Filter users by skill
  List<UserModel> filterBySkill(String skill) {
    return state
        .where((user) => user.skills
        .any((s) => s.toLowerCase().contains(skill.toLowerCase())))
        .toList();
  }

  /// ------------------ FIRESTORE FETCH ------------------

  /// Fetch all users from Firestore
  Future<void> fetchUsers() async {
    try {
      final querySnapshot =
      await _firestore.collection('users').get(); // collection name
      final users = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromJson(data, doc.id); // pass both arguments
      }).toList();
      state = users;
      ref.read(userErrorProvider.notifier).state = null;
    } catch (e) {
      ref.read(userErrorProvider.notifier).state =
      "Failed to fetch users: ${e.toString()}";
    }
  }

  /// Fetch single user by id from Firestore
  Future<UserModel?> fetchUserById(String id) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(id).get();
      if (!docSnapshot.exists) {
        ref.read(userErrorProvider.notifier).state = "User not found";
        return null;
      }
      final user = UserModel.fromJson(docSnapshot.data()!, docSnapshot.id);
      return user;
    } catch (e) {
      ref.read(userErrorProvider.notifier).state =
      "Failed to fetch user: ${e.toString()}";
      return null;
    }
  }
}
