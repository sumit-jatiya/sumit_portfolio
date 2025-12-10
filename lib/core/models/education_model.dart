class EducationModel {
  final String id;
  final String degree;
  final String institution;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final double? gpa;
  final String description;
  final List<String> courses;
  final List<String> achievements;

  EducationModel({
    required this.id,
    required this.degree,
    required this.institution,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.gpa,
    this.description = '',
    this.courses = const [],
    this.achievements = const [],
  });

  // -------------------------------
  // 🔥 Model → JSON
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'degree': degree,
      'institution': institution,
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'gpa': gpa,
      'description': description,
      'courses': courses,
      'achievements': achievements,
    };
  }

  // -------------------------------
  // 🔥 JSON → Model
  // -------------------------------
  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'] ?? '',
      degree: json['degree'] ?? '',
      institution: json['institution'] ?? '',
      location: json['location'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      gpa: json['gpa'] != null
          ? (json['gpa'] as num).toDouble()
          : null,
      description: json['description'] ?? '',
      courses: List<String>.from(json['courses'] ?? []),
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }
}
