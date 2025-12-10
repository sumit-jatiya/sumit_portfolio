class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final List<String> skillsUsed;
  final String category;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.skillsUsed,
    this.category = '',
  });

  // 🔥 FROM JSON
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      skillsUsed: List<String>.from(json['skillsUsed'] ?? []),
      category: json['category'] ?? '',
    );
  }

  // 🔥 TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconUrl': iconUrl,
      'skillsUsed': skillsUsed,
      'category': category,
    };
  }

  // 🔥 COPY WITH (useful for updates)
  ServiceModel copyWith({
    String? id,
    String? title,
    String? description,
    String? iconUrl,
    List<String>? skillsUsed,
    String? category,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      skillsUsed: skillsUsed ?? this.skillsUsed,
      category: category ?? this.category,
    );
  }
}
