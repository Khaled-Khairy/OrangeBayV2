class Reservations {
  final int id;
  final String role;
  final String ticketName;
  final int numberOfAdults;
  final String nameOfUser;
  final int numberOfChilds;
  final double totalPrice;
  final bool isPrinted;
  final List<AdditionalService> addtionalServices;

  Reservations({
    required this.id,
    required this.role,
    required this.ticketName,
    required this.numberOfAdults,
    required this.nameOfUser,
    required this.numberOfChilds,
    required this.totalPrice,
    required this.isPrinted,
    required this.addtionalServices,
  });

  factory Reservations.fromJson(Map<String, dynamic> json) {
    return Reservations(
      id: json['id'],
      role: json['role'],
      ticketName: json['ticketName'],
      numberOfAdults: json['numberOfAdults'],
      nameOfUser: json['nameOFUser'],
      numberOfChilds: json['numberOfChilds'],
      totalPrice: json['totalPrice'].toDouble(),
      isPrinted: json['isPrinted'],
      addtionalServices: List<AdditionalService>.from(
        json['addtionalServices'].map((x) => AdditionalService.fromJson(x)),
      ),
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
      price: json['price'].toDouble(),
    );
  }
}
