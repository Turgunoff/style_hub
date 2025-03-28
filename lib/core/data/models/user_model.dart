/// Foydalanuvchi ma'lumotlari modeli
///
/// Bu model foydalanuvchi ma'lumotlarini saqlash va
/// API dan kelgan ma'lumotlarni parse qilish uchun ishlatiladi.
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? avatar;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Konstruktor
  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.avatar,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  /// JSON dan model yaratish
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      phone: json['phone'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  /// Modelni JSON ga o'tkazish
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'avatar': avatar,
      'phone': phone,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Modelni nusxalash
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? avatar,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
