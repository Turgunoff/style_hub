class BannerModel {
  final int id;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;
  final String? imageUrl;

  BannerModel({
    required this.id,
    this.startDate,
    this.endDate,
    required this.isActive,
    this.imageUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isActive: json['is_active'],
      imageUrl: json['image_url'],
    );
  }
}
