class OrderModel {
  final int quantity;
  final List<SerialNumber> serialNumbers;

  OrderModel({
    required this.quantity,
    required this.serialNumbers,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      quantity: json['quantity'],
      serialNumbers: (json['serialNumbers'] as List)
          .map((item) => SerialNumber.fromJson(item))
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
  final String userName;
  final int personAge;
  final DateTime bookingDate;
  final String cruiseName;
  final List<AdditionalService> additionalServiceResponses;

  SerialNumber({
    required this.serialNumber,
    required this.tourGuide,
    required this.nationality,
    required this.harbourName,
    required this.ticketTitle,
    required this.price,
    required this.createdAt,
    required this.userName,
    required this.personAge,
    required this.bookingDate,
    required this.cruiseName,
    required this.additionalServiceResponses,
  });

  factory SerialNumber.fromJson(Map<String, dynamic> json) {
    return SerialNumber(
      serialNumber: json['serialNumber'],
      tourGuide: json['tourGuide'],
      nationality: json['nationality'],
      harbourName: json['harbourName'],
      ticketTitle: json['ticketTitle'],
      price: (json['price'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      userName: json['userName'],
      personAge: json['personAge'],
      bookingDate: DateTime.parse(json['bookingDate']),
      cruiseName: json['cruiseName'],
      additionalServiceResponses: (json['addtionalServiceResponses'] as List)
          .map((item) => AdditionalService.fromJson(item))
          .toList(),
    );
  }
}

class AdditionalService {
  final int id;
  final String name;
  final double price;

  AdditionalService({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AdditionalService.fromJson(Map<String, dynamic> json) {
    return AdditionalService(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
