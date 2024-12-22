class OrdersModel {
  final int quantity;
  final List<SerialNumber> serialNumbers;

  OrdersModel({
    required this.quantity,
    required this.serialNumbers,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      quantity: json['quantity'],
      serialNumbers: (json['serialNumbers'] as List)
          .map((e) => SerialNumber.fromJson(e))
          .toList(),
    );
  }
}

class SerialNumber {
  final String serialNumber;
  final String tourGuide;
  final String nationality;
  final String harbourName;
  final String ticketTitle;
  final double price;
  final DateTime createdAt;
  final String cruiseName;

  SerialNumber({
    required this.serialNumber,
    required this.tourGuide,
    required this.nationality,
    required this.harbourName,
    required this.ticketTitle,
    required this.price,
    required this.createdAt,
    required this.cruiseName,
  });

  factory SerialNumber.fromJson(Map<String, dynamic> json) {
    return SerialNumber(
      serialNumber: json['serialNumber'],
      tourGuide: json['tourGuide'],
      nationality: json['nationality'],
      harbourName: json['harbourName'],
      ticketTitle: json['ticketTitle'],
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      cruiseName: json['cruiseName'],
    );
  }
}