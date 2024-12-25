class OrderRequest {
  final int nationalityId;
  final int cruiseId;
  final int tourGuideId;
  final int harbourId;
  final int paymentDone;
  final int totalPrice;
  final int orderType;
  final List<OrderItem> orderItems;

  OrderRequest({
    required this.nationalityId,
    required this.cruiseId,
    required this.tourGuideId,
    required this.harbourId,
    required this.paymentDone,
    required this.totalPrice,
    required this.orderType,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'nationalityId': nationalityId,
      'cruiseId': cruiseId,
      'tourGuideId': tourGuideId,
      'harbourId': harbourId,
      'paymentDone': paymentDone,
      'totalPrice': totalPrice,
      'orderType': orderType,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  final List<OrderItemDetail> orderItemDetails;
  final int adultQuantity;
  final int childQuantity;

  OrderItem({
    required this.orderItemDetails,
    required this.adultQuantity,
    required this.childQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderItemDetails': orderItemDetails.map((item) => item.toJson()).toList(),
      'adultQuantity': adultQuantity,
      'childQuantity': childQuantity,
    };
  }
}

class OrderItemDetail {
  final int ticketId;
  final int ticketPrice;
  final String phoneNumber;
  final String name;
  final String email;
  final int additionalServicesPrice;
  final int personAge;
  final List<int> services;
  final DateTime bookingDate;

  OrderItemDetail({
    required this.ticketId,
    required this.ticketPrice,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.additionalServicesPrice,
    required this.personAge,
    required this.services,
    required this.bookingDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'ticketPrice': ticketPrice,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'adttionalServicesPrice': additionalServicesPrice,
      'personAge': personAge,
      'services': services,
      'bookingDate': bookingDate.toString(),
    };
  }
}
