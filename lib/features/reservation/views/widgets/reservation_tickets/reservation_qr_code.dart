import 'package:flutter/material.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_ticket_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservationQrCode extends StatelessWidget {
  const ReservationQrCode({
    super.key,
    required this.reservationTicket,
  });

  final ReservationTicket reservationTicket;

  @override
  Widget build(BuildContext context) {
    String qrContent = generateQRCodeContent(
      reservationTicket: reservationTicket,
    );

    return Center(
      child: QrImageView(
        data: qrContent,
        version: QrVersions.auto,
        size: 200.0,
        backgroundColor: Colors.white,
      ),
    );
  }

  String generateQRCodeContent({
    required ReservationTicket reservationTicket,
  }) {
    String content = '''
Booking ID: ${reservationTicket.bookingId}
Ticket Name: ${reservationTicket.ticketName}
  ''';

    for (var item in reservationTicket.bookingItems) {
      content += '''
Name: ${item.name}
Serial Number: ${item.serialNumber}
Booking Date: ${item.bookDate}
Services: 
    ''';

      for (var service in item.services) {
        content += '''
Service Name: ${service.name}
Price: ${service.price}
      ''';
      }
    }

    return content;
  }
}
