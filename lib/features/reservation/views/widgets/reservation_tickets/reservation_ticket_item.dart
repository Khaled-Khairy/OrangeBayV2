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
    required this.orderID,
  });

  final int index;
  final SerialNumber reservationTicket;
  final String orderID;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ReservationQrCode(
              reservationTicket: reservationTicket,
            ),
          ),
          SizedBox(height: 8.h),
          InfoText(
            label: 'Order ID',
            value: orderID,
          ),
          InfoText(
            label: 'Serial Number',
            value: reservationTicket.serialNumber,
          ),
          InfoText(
            label: 'User Name',
            value: reservationTicket.userName,
          ),
          InfoText(
            label: 'Ticket Title',
            value: reservationTicket.ticketTitle,
          ),
          InfoText(
            label: 'Ticket Type',
            value: reservationTicket.personAge == 1 ? 'Adult' : 'Child',
          ),
          InfoText(
            label: 'Boat Name',
            value: reservationTicket.cruiseName,
          ),
          InfoText(
            label: 'Tourguide Name',
            value: reservationTicket.tourGuide,
          ),
          InfoText(
            label: 'Harbour Name',
            value: reservationTicket.harbourName,
          ),
          InfoText(
            label: 'Nationality',
            value: reservationTicket.nationality,
          ),
          InfoText(
            label: 'Created At',
            value: reservationTicket.createdAt.toLocal().toString(),
          ),
          SizedBox(height: 8.h),
          Text(
            'Services:',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              height: 1.6.h,
            ),
          ),
          if (reservationTicket.additionalServiceResponses.isEmpty)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                'None',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            )
          else
            Column(
              children: reservationTicket.additionalServiceResponses.map((service) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoText(
                        label: 'Service Name',
                        value: service.name,
                      ),
                      InfoText(
                        label: 'Price',
                        value: '${service.price.toStringAsFixed(2)} SAR',
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
