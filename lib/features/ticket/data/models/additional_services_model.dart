class AdditionalServicesModel {
  final int id;
  final String name;
  final String description;
  final int adultPrice;
  final int childPrice;
  final int status;
  final String imageUrl;

  AdditionalServicesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.adultPrice,
    required this.childPrice,
    required this.status,
    required this.imageUrl,
  });

  factory AdditionalServicesModel.fromJson(Map<String, dynamic> json) {
    return AdditionalServicesModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      adultPrice: json['adultPrice'],
      childPrice: json['childPrice'],
      status: json['status'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
