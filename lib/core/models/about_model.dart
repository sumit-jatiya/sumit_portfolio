class AboutModel {
  final String id;
  final String userId;
  final String tagline;
  final String summary;
  final List<String> keySkills;
  final List<String> achievements;
  final List<String> hobbies;
  final String mission;
  final String vision;
  final String profileImageUrl;
  final String coverImageUrl;
  final DateTime lastUpdated;

  AboutModel({
    required this.id,
    required this.userId,
    required this.tagline,
    required this.summary,
    required this.keySkills,
    required this.achievements,
    this.hobbies = const [],
    this.mission = '',
    this.vision = '',
    this.profileImageUrl = '',
    this.coverImageUrl = '',
    required this.lastUpdated,
  });

  // 🔥 Factory From JSON
  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      tagline: json['tagline'] ?? '',
      summary: json['summary'] ?? '',
      keySkills: List<String>.from(json['keySkills'] ?? []),
      achievements: List<String>.from(json['achievements'] ?? []),
      hobbies: List<String>.from(json['hobbies'] ?? []),
      mission: json['mission'] ?? '',
      vision: json['vision'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.tryParse(json['lastUpdated']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  // 🔥 Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tagline': tagline,
      'summary': summary,
      'keySkills': keySkills,
      'achievements': achievements,
      'hobbies': hobbies,
      'mission': mission,
      'vision': vision,
      'profileImageUrl': profileImageUrl,
      'coverImageUrl': coverImageUrl,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // 🔥 CopyWith (useful for updates)
  AboutModel copyWith({
    String? id,
    String? userId,
    String? tagline,
    String? summary,
    List<String>? keySkills,
    List<String>? achievements,
    List<String>? hobbies,
    String? mission,
    String? vision,
    String? profileImageUrl,
    String? coverImageUrl,
    DateTime? lastUpdated,
  }) {
    return AboutModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tagline: tagline ?? this.tagline,
      summary: summary ?? this.summary,
      keySkills: keySkills ?? this.keySkills,
      achievements: achievements ?? this.achievements,
      hobbies: hobbies ?? this.hobbies,
      mission: mission ?? this.mission,
      vision: vision ?? this.vision,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
