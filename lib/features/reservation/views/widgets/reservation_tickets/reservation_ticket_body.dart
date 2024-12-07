import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/widgets/custom_button.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_ticket_model.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_tickets/reservation_ticket_item.dart';

class ReservationTicketBody extends StatelessWidget {
  const ReservationTicketBody({
    super.key,
    required this.reservationTicket,
  });

  final ReservationTicket reservationTicket;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reservationTicket.bookingItems.length,
            itemBuilder: (context, index) {
              return ReservationTicketListItem(
                index: index,
                reservationTicket: reservationTicket,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: CustomButton(
              backgroundColor: const Color(0xFF427FB8),
              text: 'Print',
              textColor: Colors.white,
              onPressed: () async => await printReceipt(
                context: context,
                reservationTicket: reservationTicket,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> printReceipt({
    required BuildContext context,
    required ReservationTicket reservationTicket,
  }) async {
    final cubit = context.read<ReservationCubit>();

    await cubit.getDevices();
    if (cubit.devices.isEmpty) {
      log('No devices found!');
      return;
    }
    await cubit.printerService.connect(cubit.devices[0]);

    // Generate the content for printing for each booking item
    for (var item in reservationTicket.bookingItems) {
      final qrCodeData = generateQRCodeContent(reservationTicket, item);
      String receiptContent = '''
Booking ID: ${reservationTicket.bookingId}
Name: ${reservationTicket.bookingItems.map((e) => e.name).join(', ')}
Trip Name: ${reservationTicket.ticketName}
Serial Number: ${item.serialNumber}
Booking Date: ${item.bookDate}
Services:
      ''';
      for (var service in item.services) {
        receiptContent += '''
Service Name: ${service.name}
Price: ${service.price}
        ''';
      }

      // Print the content along with QR Code
      await cubit.printerService.printReceipt(
        receiptContent,
        "------------------------------\n", // divider
        qrCodeData, // QR Code data
      );
    }

    await cubit.printerService.disconnect();
  }

  String generateQRCodeContent(
      ReservationTicket reservationTicket, var bookingItem) {
    return '''
Booking ID: ${reservationTicket.bookingId}
Name: ${reservationTicket.bookingItems.map((e) => e.name).join(', ')}
Trip Name: ${reservationTicket.ticketName}
Serial Number: ${bookingItem.serialNumber}
Booking Date: ${bookingItem.bookDate}\n
    ''';
  }
}
