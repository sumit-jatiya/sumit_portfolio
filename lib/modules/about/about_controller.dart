import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/about_model.dart';

final aboutErrorProvider = StateProvider<String?>((ref) => null);

final aboutListProvider = StateNotifierProvider<AboutController, List<AboutModel>>(
      (ref) => AboutController(ref),
);

class AboutController extends StateNotifier<List<AboutModel>> {
  final Ref ref;

  AboutController(this.ref) : super([]);

  /// ------------------ CRUD METHODS ------------------

  /// Add new About entry
  void addAbout(AboutModel about) {
    try {
      state = [...state, about];
      ref
          .read(aboutErrorProvider.notifier)
          .state = null;
    } catch (e) {
      ref
          .read(aboutErrorProvider.notifier)
          .state = e.toString();
    }
  }

  /// Update About entry by id
  void updateAbout(String id, AboutModel updatedAbout) {
    try {
      state = [
        for (final a in state)
          if (a.id == id) updatedAbout else
            a
      ];
      ref
          .read(aboutErrorProvider.notifier)
          .state = null;
    } catch (e) {
      ref
          .read(aboutErrorProvider.notifier)
          .state = e.toString();
    }
  }

  /// Delete About entry by id
  void deleteAbout(String id) {
    try {
      state = state.where((a) => a.id != id).toList();
      ref
          .read(aboutErrorProvider.notifier)
          .state = null;
    } catch (e) {
      ref
          .read(aboutErrorProvider.notifier)
          .state = e.toString();
    }
  }

  /// Get About by id
  AboutModel? getAboutById(String id) {
    try {
      return state.firstWhere((a) => a.id == id);
    } catch (e) {
      ref
          .read(aboutErrorProvider.notifier)
          .state = "About entry not found";
      return null;
    }
  }

  /// Get the latest About entry based on lastUpdated
  AboutModel? getLatestAbout() {
    if (state.isEmpty) return null;
    final sorted = [...state]
      ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    return sorted.first;
  }

  /// ------------------ SEARCH & FILTER ------------------

  /// Search About by tagline or summary
  List<AboutModel> searchAbout(String keyword) {
    return state.where((a) =>
    a.tagline.toLowerCase().contains(keyword.toLowerCase()) ||
        a.summary.toLowerCase().contains(keyword.toLowerCase())
    ).toList();
  }

  /// Filter About by key skill
  List<AboutModel> filterBySkill(String skill) {
    return state.where((a) =>
        a.keySkills.any((s) => s.toLowerCase().contains(skill.toLowerCase()))
    ).toList();
  }

  /// Filter About by hobby
  List<AboutModel> filterByHobby(String hobby) {
    return state.where((a) =>
        a.hobbies.any((h) => h.toLowerCase().contains(hobby.toLowerCase()))
    ).toList();
  }

  /// Filter About by achievement keyword
  List<AboutModel> filterByAchievement(String keyword) {
    return state.where((a) =>
        a.achievements.any((ach) =>
            ach.toLowerCase().contains(keyword.toLowerCase()))
    ).toList();
  }

  /// ------------------ UTILITY METHODS ------------------

  /// Get all unique key skills across all About entries
  List<String> getAllKeySkills() {
    final skills = <String>{};
    for (var a in state) {
      skills.addAll(a.keySkills);
    }
    return skills.toList();
  }

  /// Get all unique hobbies across all About entries
  List<String> getAllHobbies() {
    final hobbies = <String>{};
    for (var a in state) {
      hobbies.addAll(a.hobbies);
    }
    return hobbies.toList();
  }

  /// Get all achievements across About entries
  List<String> getAllAchievements() {
    final achievements = <String>{};
    for (var a in state) {
      achievements.addAll(a.achievements);
    }
    return achievements.toList();
  }

  /// Sort About entries by lastUpdated (desc)
  void sortByLastUpdated({bool descending = true}) {
    final sorted = [...state];
    sorted.sort((a, b) =>
    descending ? b.lastUpdated.compareTo(a.lastUpdated) : a.lastUpdated
        .compareTo(b.lastUpdated));
    state = sorted;
  }

  /// ------------------ ASYNC FETCH / SIMULATION ------------------

  /// Fetch About entries (simulate async fetch)
  Future<void> fetchAbout() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // 🔥 Mock Data for testing
      final fetchedData = [
        AboutModel(
          id: '1',
          userId: 'u1',
          tagline: 'Flutter & Cybersecurity Enthusiast',
          summary:
          'I build scalable Flutter apps and secure systems for clients globally.',
          keySkills: ['Flutter', 'Dart', 'Firebase', 'Cybersecurity'],
          achievements: ['Deployed 5+ apps', 'Certified Ethical Hacker'],
          hobbies: ['Gaming', 'Reading', 'Music'],
          mission: 'To deliver quality software and secure solutions.',
          vision: 'To become a leading full-stack mobile & security expert.',
          profileImageUrl:
          'https://i.pravatar.cc/150?img=3',
          // placeholder image
          coverImageUrl:
          'https://picsum.photos/600/200',
          // placeholder cover
          lastUpdated: DateTime.now(),
        ),
        AboutModel(
          id: '2',
          userId: 'u2',
          tagline: 'Mobile App Developer',
          summary: 'Creating beautiful mobile experiences with Flutter.',
          keySkills: ['Flutter', 'UI/UX', 'Animations'],
          achievements: [
            'Published apps on Play Store',
            'Top rated app designer'
          ],
          hobbies: ['Traveling', 'Photography'],
          mission: 'Enhance user experience through clean design.',
          vision: 'To make apps people love to use.',
          profileImageUrl: '',
          coverImageUrl: '',
          lastUpdated: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

      state = fetchedData; // populate the state

      ref
          .read(aboutErrorProvider.notifier)
          .state = null;
    } catch (e) {
      ref
          .read(aboutErrorProvider.notifier)
          .state = e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> fetchKeySkills() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc('userId') // replace with your user id
        .get();

    if (!doc.exists) return [];

    final data = doc.data();
    if (data == null || !data.containsKey('keySkills')) return [];

    List<dynamic> skills = data['keySkills'];
    // convert dynamic to List<Map<String, dynamic>>
    return skills.map((e) => Map<String, dynamic>.from(e)).toList();
  }

}