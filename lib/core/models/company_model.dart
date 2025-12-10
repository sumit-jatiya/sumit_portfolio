class CompanyModel {
  final String id;
  final String name;
  final String website;
  final String logoUrl;
  final String description;
  final String location;
  final DateTime foundedDate;
  final List<String> services;
  final List<String> clients;
  final List<String> technologies;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.website,
    required this.logoUrl,
    required this.description,
    required this.location,
    required this.foundedDate,
    this.services = const [],
    this.clients = const [],
    this.technologies = const [],
  });
  static CompanyModel empty() {
    return CompanyModel(
      id: '',
      name: '',
      website: '',
      logoUrl: '',
      description: '',
      location: '',
      foundedDate: DateTime.now(),
      services: [],
      clients: [],
      technologies: [],
    );
  }
  // -------------------------------
  // 🔥 Model → JSON
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'website': website,
      'logoUrl': logoUrl,
      'description': description,
      'location': location,
      'foundedDate': foundedDate.toIso8601String(),
      'services': services,
      'clients': clients,
      'technologies': technologies,
    };
  }

  // -------------------------------
  // 🔥 JSON → Model
  // -------------------------------
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      website: json['website'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      foundedDate: DateTime.parse(json['foundedDate']),
      services: List<String>.from(json['services'] ?? []),
      clients: List<String>.from(json['clients'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
    );
  }

  // -------------------------------
  // 🔥 CopyWith (optional)
  // -------------------------------
  CompanyModel copyWith({
    String? id,
    String? name,
    String? website,
    String? logoUrl,
    String? description,
    String? location,
    DateTime? foundedDate,
    List<String>? services,
    List<String>? clients,
    List<String>? technologies,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      website: website ?? this.website,
      logoUrl: logoUrl ?? this.logoUrl,
      description: description ?? this.description,
      location: location ?? this.location,
      foundedDate: foundedDate ?? this.foundedDate,
      services: services ?? this.services,
      clients: clients ?? this.clients,
      technologies: technologies ?? this.technologies,
    );
  }
}
