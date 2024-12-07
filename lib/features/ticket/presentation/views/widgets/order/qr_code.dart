import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orange_bay/features/ticket/data/models/orders_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final SerialNumber serialNumber;

  const QRCodeWidget({super.key, required this.serialNumber});

  @override
  Widget build(BuildContext context) {
    final qrContent = generateQRCodeContent(serialNumber);

    return Center(
      child: QrImageView(
        data: qrContent,
        version: QrVersions.auto,
        size: 200.0,
        backgroundColor: Colors.white,
      ),
    );
  }
}

String generateQRCodeContent(SerialNumber serialNumber) {
  String formattedDate = DateFormat('d/M/yyyy h:m a').format(serialNumber.createdAt);

  return '''
Serial Number: ${serialNumber.serialNumber}
Ticket Title: ${serialNumber.ticketTitle}
Boat Name: ${serialNumber.cruiseName}
Tour Guide Name: ${serialNumber.tourGuide}
Harbour Name: ${serialNumber.harbourName}
Nationality: ${serialNumber.nationality}
Created At: $formattedDate
  ''';
}
