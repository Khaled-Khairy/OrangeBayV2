
class TicketsModel {
  final List<Harbour> harbour;
  final List<Cruise> cruises;
  final List<Nationality> nationalityDtos;
  final List<TourGuide> tourGuideDtos;
  final List<Ticket> tickets;

  TicketsModel({
    required this.harbour,
    required this.cruises,
    required this.nationalityDtos,
    required this.tourGuideDtos,
    required this.tickets,
  });

  factory TicketsModel.fromJson(Map<String, dynamic> json) {
    return TicketsModel(
      harbour: List<Harbour>.from(json['harbour'].map((x) => Harbour.fromJson(x))),
      cruises: List<Cruise>.from(json['crusies'].map((x) => Cruise.fromJson(x))),
      nationalityDtos: List<Nationality>.from(json['nationalityDtos'].map((x) => Nationality.fromJson(x))),
      tourGuideDtos: List<TourGuide>.from(json['tourGuideDtos'].map((x) => TourGuide.fromJson(x))),
      tickets: List<Ticket>.from(json['tickets'].map((x) => Ticket.fromJson(x))),
    );
  }
}

class Harbour {
  final num id;
  final String name;
  final String address;
  final String description;
  final String imageUrl;

  Harbour({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.imageUrl,
  });

  factory Harbour.fromJson(Map<String, dynamic> json) {
    return Harbour(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

}

class Cruise {
  final num id;
  final String name;
  final String status;

  Cruise({
    required this.id,
    required this.name,
    required this.status,
  });

  factory Cruise.fromJson(Map<String, dynamic> json) {
    return Cruise(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }

}

class Nationality {
  final num id;
  final String name;

  Nationality({
    required this.id,
    required this.name,
  });

  factory Nationality.fromJson(Map<String, dynamic> json) {
    return Nationality(
      id: json['id'],
      name: json['name'],
    );
  }
}

class TourGuide {
  final num id;
  final String name;
  final String phoneNumber;
  final String email;
  final num profitRate;
  final String status;

  TourGuide({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.profitRate,
    required this.status,
  });

  factory TourGuide.fromJson(Map<String, dynamic> json) {
    return TourGuide(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      profitRate: json['profitRate'],
      status: json['status'],
    );
  }

}

class Ticket {
  final num id;
  final String title;
  final String description;
  final List<String> images;
  final num ticketCategoryId;
  final String ticketCategory;
  final String? saleCenter;
  final dynamic saleCenterId;
  final num tax;
  final num currency;
  final List<AdditionalService> addtionalServices;
  final num status;
  final List<Day> days;
  final List<DetailsDto> detailsDto;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.ticketCategoryId,
    required this.ticketCategory,
    this.saleCenter,
    this.saleCenterId,
    required this.tax,
    required this.currency,
    required this.addtionalServices,
    required this.status,
    required this.days,
    required this.detailsDto,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      images: List<String>.from(json['images']),
      ticketCategoryId: json['ticketCategoryId'],
      ticketCategory: json['ticketCategory'],
      saleCenter: json['saleCenter'],
      saleCenterId: json['saleCenterId'],
      tax: json['tax'],
      currency: json['currency'],
      addtionalServices: List<AdditionalService>.from(json['addtionalServices'].map((x) => AdditionalService.fromJson(x))),
      status: json['status'],
      days: List<Day>.from(json['days'].map((x) => Day.fromJson(x))),
      detailsDto: List<DetailsDto>.from(json['detailsDto'].map((x) => DetailsDto.fromJson(x))),
    );
  }

}

class AdditionalService {
  final num id;
  final String name;

  AdditionalService({
    required this.id,
    required this.name,
  });

  factory AdditionalService.fromJson(Map<String, dynamic> json) {
    return AdditionalService(
      id: json['id'],
      name: json['name'],
    );
  }

}

class Day {
  final num id;
  final String name;

  Day({
    required this.id,
    required this.name,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'],
      name: json['name'],
    );
  }

}

class DetailsDto {
  final String fromDate;
  final String toDate;
  final num adultPrice;
  final num childPrice;
  final String userType;

  DetailsDto({
    required this.fromDate,
    required this.toDate,
    required this.adultPrice,
    required this.childPrice,
    required this.userType,
  });

  factory DetailsDto.fromJson(Map<String, dynamic> json) {
    return DetailsDto(
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      adultPrice: json['adultPrice'],
      childPrice: json['childPrice'],
      userType: json['userType'],
    );
  }

}
