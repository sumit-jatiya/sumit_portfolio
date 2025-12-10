class ResumeModel {
  final String id;
  final String userId; // link to user
  final String title; // e.g., "Flutter Developer Resume"
  final String description; // optional short summary
  final String fileUrl; // PDF or doc file URL
  final DateTime uploadedAt;
  final List<String> skills;
  final List<String> experiences;
  final List<String> education;

  ResumeModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.uploadedAt,
    this.skills = const [],
    this.experiences = const [],
    this.education = const [],
  });

  // -------------------------------
  // 🔥 Model → JSON
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'uploadedAt': uploadedAt.toIso8601String(),
      'skills': skills,
      'experiences': experiences,
      'education': education,
    };
  }

  // -------------------------------
  // 🔥 JSON → Model
  // -------------------------------
  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      uploadedAt: DateTime.parse(json['uploadedAt']),
      skills: List<String>.from(json['skills'] ?? []),
      experiences: List<String>.from(json['experiences'] ?? []),
      education: List<String>.from(json['education'] ?? []),
    );
  }

  // -------------------------------
  // 🔥 CopyWith (optional)
  // -------------------------------
  ResumeModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? fileUrl,
    DateTime? uploadedAt,
    List<String>? skills,
    List<String>? experiences,
    List<String>? education,
  }) {
    return ResumeModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      skills: skills ?? this.skills,
      experiences: experiences ?? this.experiences,
      education: education ?? this.education,
    );
  }
}
