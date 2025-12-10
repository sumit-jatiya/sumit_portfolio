import 'package:portfolio/core/models/contact_model.dart';
import 'package:portfolio/core/models/education_model.dart';
import 'package:portfolio/core/models/experience_model.dart';
import 'package:portfolio/core/models/project_model.dart';
import 'package:portfolio/core/models/service_model.dart';

class UserModel {
  final String id;
  final String fullName;
  final String title;
  final String bio;
  final String email;
  final String phone;
  final String profileImageUrl;
  final String website;
  final List<String> skills;
  final List<String> interests;
  final Map<String, String> socialLinks;
  final DateTime dob;
  final String location;

  final List<EducationModel> education;
  final List<ExperienceModel> experiences;
  final List<ProjectModel> projects;
  final List<ServiceModel> services;
  final List<ContactModel> contacts;

  UserModel({
    required this.id,
    required this.fullName,
    required this.title,
    required this.bio,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.website,
    required this.skills,
    required this.interests,
    required this.socialLinks,
    required this.dob,
    required this.location,
    required this.education,
    required this.experiences,
    required this.projects,
    required this.services,
    required this.contacts,
  });
  static UserModel empty() {
    return UserModel(
      id: '',
      fullName: '',
      title: '',
      bio: '',
      email: '',
      phone: '',
      profileImageUrl: '',
      website: '',
      skills: [],
      interests: [],
      socialLinks: {},
      dob: DateTime.now(),
      location: '',
      education: [],
      experiences: [],
      projects: [],
      services: [],
      contacts: [],
    );
  }
  // --------------------------
  // 🔥 From Firebase Document
  // --------------------------
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      fullName: json['fullName'] ?? '',
      title: json['title'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      website: json['website'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      interests: List<String>.from(json['interests'] ?? []),
      socialLinks: Map<String, String>.from(json['socialLinks'] ?? {}),
      dob: DateTime.tryParse(json['dob'] ?? '') ?? DateTime.now(),
      location: json['location'] ?? '',

      education: (json['education'] as List<dynamic>? ?? [])
          .map((e) => EducationModel.fromJson(e))
          .toList(),

      experiences: (json['experiences'] as List<dynamic>? ?? [])
          .map((e) => ExperienceModel.fromJson(e))
          .toList(),

      projects: (json['projects'] as List<dynamic>? ?? [])
          .map((e) => ProjectModel.fromJson(e))
          .toList(),

      services: (json['services'] as List<dynamic>? ?? [])
          .map((e) => ServiceModel.fromJson(e))
          .toList(),

      contacts: (json['contacts'] as List<dynamic>? ?? [])
          .map((e) => ContactModel.fromJson(e))
          .toList(),
    );
  }

  // --------------------------
  // 🔥 To Firebase Document
  // --------------------------
  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "title": title,
      "bio": bio,
      "email": email,
      "phone": phone,
      "profileImageUrl": profileImageUrl,
      "website": website,
      "skills": skills,
      "interests": interests,
      "socialLinks": socialLinks,
      "dob": dob.toIso8601String(),
      "location": location,

      "education": education.map((e) => e.toJson()).toList(),
      "experiences": experiences.map((e) => e.toJson()).toList(),
      "projects": projects.map((e) => e.toJson()).toList(),
      "services": services.map((e) => e.toJson()).toList(),
      "contacts": contacts.map((e) => e.toJson()).toList(),
    };
  }

  // --------------------------
  // ✨ copyWith() (optional but best practice)
  // --------------------------
  UserModel copyWith({
    String? fullName,
    String? title,
    String? bio,
    String? email,
    String? phone,
    String? profileImageUrl,
    String? website,
    List<String>? skills,
    List<String>? interests,
    Map<String, String>? socialLinks,
    DateTime? dob,
    String? location,
    List<EducationModel>? education,
    List<ExperienceModel>? experiences,
    List<ProjectModel>? projects,
    List<ServiceModel>? services,
    List<ContactModel>? contacts,
  }) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      title: title ?? this.title,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      website: website ?? this.website,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      socialLinks: socialLinks ?? this.socialLinks,
      dob: dob ?? this.dob,
      location: location ?? this.location,
      education: education ?? this.education,
      experiences: experiences ?? this.experiences,
      projects: projects ?? this.projects,
      services: services ?? this.services,
      contacts: contacts ?? this.contacts,
    );
  }
}
