import 'package:flutter/material.dart';
import 'package:orange_bay/models/order_model.dart';

import 'order_item.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.serialNumbers});
  final List<SerialNumber> serialNumbers;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: serialNumbers.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return OrderItem(
          serialNumbers: serialNumbers[index],
        );
      },
    );
  }
}
