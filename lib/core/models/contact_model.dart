class ContactModel {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime sentAt;
  final String phone;
  final String status;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.sentAt,
    this.phone = '',
    this.status = 'new',
  });

  // -------------------------------
  // 🔥 Model → JSON
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'sentAt': sentAt.toIso8601String(),
      'phone': phone,
      'status': status,
    };
  }

  // -------------------------------
  // 🔥 JSON → Model
  // -------------------------------
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      sentAt: DateTime.parse(json['sentAt']),
      phone: json['phone'] ?? '',
      status: json['status'] ?? 'new',
    );
  }

  // -------------------------------
  // 🔥 CopyWith (optional)
  // -------------------------------
  ContactModel copyWith({
    String? id,
    String? name,
    String? email,
    String? subject,
    String? message,
    DateTime? sentAt,
    String? phone,
    String? status,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }
}
