import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/widgets/custom_button.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/order/orders_list_view.dart';
import 'package:orange_bay/models/order_model.dart';

class OrdersBody extends StatelessWidget {
  final List<SerialNumber> serialNumbers;

  const OrdersBody({super.key, required this.serialNumbers});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OrdersListView(
            serialNumbers: serialNumbers,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: CustomButton(
              backgroundColor: const Color(0xFF427FB8),
              text: 'Print',
              textColor: Colors.white,
              onPressed: () async => await printReceipt(context),
            ),
          )
        ],
      ),
    );
  }

  Future<void> printReceipt(BuildContext context) async {
    final cubit = context.read<TicketCubit>();

    await cubit.getDevices();
    if (cubit.devices.isEmpty) {
      log('No devices found!');
      return;
    }
    await cubit.printerService.connect(cubit.devices[0]);

    for (final serial in serialNumbers) {
      String formattedDate = DateFormat('d/M/yyyy h:m a').format(serial.createdAt);
      final qrCodeData = generateQRCodeContent(serial);
      await cubit.printerService.printReceipt(
            "Serial Number: ${serial.serialNumber}\n"
            "Ticket Title: ${serial.ticketTitle}\n"
            "Boat Name: ${serial.cruiseName}\n"
            "Tour Guide Name: ${serial.tourGuide}\n"
            "Harbour Name: ${serial.harbourName}\n"
            "Nationality: ${serial.nationality}\n"
            "Created At: $formattedDate\n",
            "------------------------------",
        qrCodeData,
      );
    }
    await cubit.printerService.disconnect();
  }

  String generateQRCodeContent(SerialNumber serialNumber) {
    return '''
Serial Number: ${serialNumber.serialNumber}
Ticket Title: ${serialNumber.ticketTitle}
Boat Name: ${serialNumber.cruiseName}
Tour Guide Name: ${serialNumber.tourGuide}
Harbour Name: ${serialNumber.harbourName}
Nationality: ${serialNumber.nationality}
Created At: ${serialNumber.createdAt.toString()}
  ''';
  }
}
