import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/widgets/info_text.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_ticket_model.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_tickets/reservation_qr_code.dart';

class ReservationTicketListItem extends StatelessWidget {
  const ReservationTicketListItem({
    super.key,
    required this.index,
    required this.reservationTicket,
  });

  final int index;
  final ReservationTicket reservationTicket;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          ReservationQrCode(
            reservationTicket: reservationTicket,
          ),
          InfoText(
            label: 'Booking ID',
            value: reservationTicket.bookingId.toString(),
          ),
          InfoText(
            label: 'Name',
            value: reservationTicket.bookingItems[index].name,
          ),
          InfoText(
            label: 'Trip Name',
            value: reservationTicket.ticketName,
          ),
          InfoText(
            label: 'Serial Number',
            value: reservationTicket.bookingItems[index].serialNumber,
          ),
          InfoText(
            label: 'Booking Date',
            value: reservationTicket.bookingItems[index].bookDate,
          ),
          Text(
            'Services : ',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              height: 1.6.h,
            ),
          ),
          InfoText(
            label: 'Service Name',
            value: reservationTicket.bookingItems[index].services
                .map((service) => service.name)
                .join(', '),
          ),
          InfoText(
            label: 'Price',
            value: reservationTicket.bookingItems[index].services
                .map((service) => service.price.toString())
                .join(', '),
          ),
        ],
      ),
    );
  }
}
