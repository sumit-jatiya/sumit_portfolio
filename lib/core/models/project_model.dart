class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String projectUrl;
  final String imageUrl;
  final List<String> technologies;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isOngoing;
  final String role;
  final List<String> achievements;
  final String client;
  final String category;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.projectUrl,
    required this.imageUrl,
    required this.technologies,
    required this.startDate,
    this.endDate,
    this.isOngoing = false,
    required this.role,
    required this.achievements,
    this.client = '',
    this.category = '',
  });

  // 🔥 Parse from JSON
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      projectUrl: json['projectUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      startDate:
      DateTime.tryParse(json['startDate'] ?? "") ?? DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      isOngoing: json['isOngoing'] ?? false,
      role: json['role'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
      client: json['client'] ?? '',
      category: json['category'] ?? '',
    );
  }

  // 🔥 Convert to JSON (Firebase Safe)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'projectUrl': projectUrl,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isOngoing': isOngoing,
      'role': role,
      'achievements': achievements,
      'client': client,
      'category': category,
    };
  }

  // 🔥 copyWith() (useful for updates)
  ProjectModel copyWith({
    String? id,
    String? title,
    String? description,
    String? projectUrl,
    String? imageUrl,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    String? role,
    List<String>? achievements,
    String? client,
    String? category,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      projectUrl: projectUrl ?? this.projectUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      technologies: technologies ?? this.technologies,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isOngoing: isOngoing ?? this.isOngoing,
      role: role ?? this.role,
      achievements: achievements ?? this.achievements,
      client: client ?? this.client,
      category: category ?? this.category,
    );
  }
}
