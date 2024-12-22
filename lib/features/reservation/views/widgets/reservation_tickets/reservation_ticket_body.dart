import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:orange_bay/core/widgets/custom_button.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_ticket_model.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_tickets/reservation_ticket_item.dart';

class ReservationTicketBody extends StatelessWidget {
  const ReservationTicketBody({
    super.key,
    required this.reservationTickets,
    required this.orderID,
  });

  final List<SerialNumber> reservationTickets;
  final String orderID;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reservationTickets.length,
            itemBuilder: (context, index) {
              return ReservationTicketListItem(
                index: index,
                reservationTicket: reservationTickets[index],
                orderID: orderID,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: CustomButton(
              backgroundColor: const Color(0xFF427FB8),
              text: 'Print',
              textColor: Colors.white,
              onPressed: () async {
                try {
                  await printReceipt(
                    context: context,
                    reservationTickets: reservationTickets,
                  );
                } catch (error) {
                  log('Error during printing: $error');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> printReceipt({
    required BuildContext context,
    required List<SerialNumber> reservationTickets,
  }) async {
    final cubit = context.read<ReservationCubit>();

    await cubit.getDevices();
    if (cubit.devices.isEmpty) {
      log('No devices found!');
      return;
    }

    final device = cubit.devices.first;
    try {
      await cubit.printerService.connect(device);

      for (var reservationTicket in reservationTickets) {
        final qrCodeData = generateQRCodeContent(reservationTicket);
        final receiptContent = generateReceiptContent(reservationTicket);

        await cubit.printerService.printReceipt(
          receiptContent,
          "------------------------------\n",
          qrCodeData,
        );
      }
    } catch (e) {
      log('Printing failed: $e');
    } finally {
      await cubit.printerService.disconnect();
    }
  }

  String generateQRCodeContent(SerialNumber reservationTicket) {
    final servicesContent = reservationTicket.additionalServiceResponses.isEmpty
        ? "Service: None"
        : reservationTicket.additionalServiceResponses
            .map((service) =>
                "Service Name: ${service.name}, Price: ${service.price.toStringAsFixed(2)} SAR")
            .join(", ");

    return '''
Serial Number: ${reservationTicket.serialNumber}
Ticket Title: ${reservationTicket.ticketTitle}
Cruise Name: ${reservationTicket.cruiseName}
Booking Date: ${DateFormat('dd/MM/yyyy').format(reservationTicket.bookingDate.toLocal())}
Tour Guide: ${reservationTicket.tourGuide}
Nationality: ${reservationTicket.nationality}
Price: ${reservationTicket.price.toStringAsFixed(2)} SAR
Services: $servicesContent
''';
  }

  String generateReceiptContent(SerialNumber reservationTicket) {
    final additionalServices = reservationTicket
            .additionalServiceResponses.isEmpty
        ? "Service: None"
        : reservationTicket.additionalServiceResponses
            .map((service) =>
                "Service Name: ${service.name}, Price: ${service.price.toStringAsFixed(2)} SAR")
            .join("\n");

    return '''
Serial Number: ${reservationTicket.serialNumber}
Ticket Title: ${reservationTicket.ticketTitle}
Cruise Name: ${reservationTicket.cruiseName}
Booking Date: ${DateFormat('dd/MM/yyyy').format(reservationTicket.bookingDate.toLocal())}
Tour Guide: ${reservationTicket.tourGuide}
Nationality: ${reservationTicket.nationality}
Price: ${reservationTicket.price.toStringAsFixed(2)} SAR
Additional Services:
$additionalServices
''';
  }
}
