class CategoryModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final String imageUrl;
  final int barbersCount; // Barberlar soni

  CategoryModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.barbersCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      barbersCount: json['barbers_count'] ?? 0,
    );
  }
}
