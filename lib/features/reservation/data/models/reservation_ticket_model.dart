class ReservationTicket {
  final num bookingId;
  final num totalPrice;
  final num totalAdditionalPrice;
  final num numberOfAdults;
  final num numberOfChilds;
  final String ticketName;
  final String role;
  final bool isPrinted;
  final List<ReservationTicketItem> bookingItems;

  ReservationTicket({
    required this.bookingId,
    required this.totalPrice,
    required this.totalAdditionalPrice,
    required this.numberOfAdults,
    required this.numberOfChilds,
    required this.ticketName,
    required this.role,
    required this.isPrinted,
    required this.bookingItems,
  });

  factory ReservationTicket.fromJson(Map<String, dynamic> json) {
    return ReservationTicket(
      bookingId: json['bookingId'],
      totalPrice: json['totalPrice'],
      totalAdditionalPrice: json['totalAddtionalPrice'],
      numberOfAdults: json['numberOfAdults'],
      numberOfChilds: json['numberOfChilds'],
      ticketName: json['ticketName'],
      role: json['role'],
      isPrinted: json['isPrinted'],
      bookingItems: (json['bookingItems'] as List)
          .map((item) => ReservationTicketItem.fromJson(item))
          .toList(),
    );
  }
}

class ReservationTicketItem {
  final num price;
  final String name;
  final String serialNumber;
  final String? email;
  final String? phoneNumber;
  final String bookDate;
  final String createdOn;
  final num statues;
  final List<Service> services;

  ReservationTicketItem({
    required this.price,
    required this.name,
    required this.serialNumber,
    this.email,
    this.phoneNumber,
    required this.bookDate,
    required this.createdOn,
    required this.statues,
    required this.services,
  });

  factory ReservationTicketItem.fromJson(Map<String, dynamic> json) {
    return ReservationTicketItem(
      price: json['price'],
      name: json['name'],
      serialNumber: json['seriamNumber'],
      email: json['email'] ?? 'None',
      phoneNumber: json['phoneNumber'] ?? 'None',
      bookDate: json['bookDate'],
      createdOn: json['createdOn'],
      statues: json['statues'],
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }
}

class Service {
  final num id;
  final String name;
  final num price;

  Service({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}
