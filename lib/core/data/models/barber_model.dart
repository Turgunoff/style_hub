class BarberModel {
  final int id;
  final String fullName;
  final String phone;
  final String email;
  final String bio;
  final int experience;
  final double rating;
  final int categoryId;
  final String imageUrl;
  final double distance;

  BarberModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.bio,
    required this.experience,
    required this.rating,
    required this.categoryId,
    required this.imageUrl,
    this.distance = 0.0,
  });

  factory BarberModel.fromJson(Map<String, dynamic> json) {
    return BarberModel(
      id: json['id'],
      fullName: json['full_name'] ?? 'Nomsiz barber',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      experience: json['experience'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      categoryId: json['category_id'] ?? 0,
      imageUrl: json['image_url'] ?? 'assets/image/photo.jpg',
      distance: (json['distance'] ?? 0.0).toDouble(),
    );
  }
}
