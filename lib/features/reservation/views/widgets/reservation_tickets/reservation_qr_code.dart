import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orange_bay/models/order_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservationQrCode extends StatelessWidget {
  const ReservationQrCode({
    super.key,
    required this.reservationTicket,
  });

  final SerialNumber reservationTicket;

  @override
  Widget build(BuildContext context) {
    String qrContent = generateQRCodeContent(reservationTicket);

    return Center(
      child: QrImageView(
        data: qrContent,
        version: QrVersions.auto,
        size: 200.0,
        backgroundColor: Colors.white,
      ),
    );
  }

  String generateQRCodeContent(SerialNumber reservation) {
    String content = '''
Reservation Ticket:
Serial Number: ${reservation.serialNumber}
Cruise Name: ${reservation.cruiseName}
Booking Date: ${DateFormat('dd/MM/yyyy').format(reservation.bookingDate)}
Ticket Title: ${reservation.ticketTitle}
Tour Guide: ${reservation.tourGuide}
Nationality: ${reservation.nationality}
Price: ${reservation.price.toStringAsFixed(2)} SAR
''';

    if (reservation.additionalServiceResponses.isNotEmpty) {
      content += 'Additional Services:\n';
      for (var service in reservation.additionalServiceResponses) {
        content += '''
Service Name: ${service.name}
Price: ${service.price.toStringAsFixed(2)} SAR
''';
      }
    } else {
      content += 'Additional Services: None\n';
    }

    return content.trim();
  }
}
