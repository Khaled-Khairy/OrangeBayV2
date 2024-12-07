class OrderRequest {
  final int nationalityId;
  final int cruiseId;
  final int tourGuideId;
  final int harbourId;
  final List<OrderItem> orderItems;

  OrderRequest({
    required this.nationalityId,
    required this.cruiseId,
    required this.tourGuideId,
    required this.harbourId,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'nationalityId': nationalityId,
      'cruiseId': cruiseId,
      'tourGuideId': tourGuideId,
      'harbourId': harbourId,
      'orderItems': _getDuplicatedOrderItems().map((item) => item.toJson()).toList(),
    };
  }
  List<OrderItem> _getDuplicatedOrderItems() {
    return orderItems.expand((item) {
      return List.generate(item.ticketCount, (_) => item);
    }).toList();
  }
}

class OrderItem {
  final String ticketName;
  final int ticketId;
  final num price;
  final int adultQuantity;
  final int childQuantity;
  final int ticketCount;

  OrderItem({
    required this.ticketName,
    required this.ticketId,
    required this.price,
    required this.adultQuantity,
    required this.childQuantity,
    required this.ticketCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'price': price,
      'adultQuantity': adultQuantity,
      'childQuantity': childQuantity,
    };
  }
}
