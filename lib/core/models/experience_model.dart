class ExperienceModel {
  final String id;
  final String role;
  final String companyId;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String description;
  final List<String> achievements;
  final List<String> technologies;
  final String employmentType;

  ExperienceModel({
    required this.id,
    required this.role,
    required this.companyId,
    required this.location,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
    required this.description,
    required this.achievements,
    required this.technologies,
    this.employmentType = 'Full-time',
  });

  // -------------------------------
  // 🔥 Convert Model → JSON
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'companyId': companyId,
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrent': isCurrent,
      'description': description,
      'achievements': achievements,
      'technologies': technologies,
      'employmentType': employmentType,
    };
  }

  // -------------------------------
  // 🔥 Convert JSON → Model
  // -------------------------------
  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] ?? '',
      role: json['role'] ?? '',
      companyId: json['companyId'] ?? '',
      location: json['location'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCurrent: json['isCurrent'] ?? false,
      description: json['description'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      employmentType: json['employmentType'] ?? '',
    );
  }
}
