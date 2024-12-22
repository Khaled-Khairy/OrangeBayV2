import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:orange_bay/core/widgets/info_text.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/order/qr_code.dart';
import 'package:orange_bay/models/order_model.dart';

class OrderItem extends StatelessWidget {
  final SerialNumber serialNumbers;

  const OrderItem({
    super.key,
    required this.serialNumbers,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d/M/yyyy h:m a').format(serialNumbers.createdAt);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          QRCodeWidget(serialNumber: serialNumbers),
          InfoText(label: 'Serial Number', value: serialNumbers.serialNumber),
          InfoText(label: 'Ticket Title', value: serialNumbers.ticketTitle),
          InfoText(label: 'Boat Name', value: serialNumbers.cruiseName),
          InfoText(label: 'Tour Guide Name', value: serialNumbers.tourGuide),
          InfoText(label: 'Harbour Name', value: serialNumbers.harbourName),
          InfoText(label: 'Nationality', value: serialNumbers.nationality),
          InfoText(label: 'Created At', value: formattedDate),
        ],
      ),
    );
  }
}
