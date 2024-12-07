import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/core/utils/app_router.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_model.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_button.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_text_details.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({
    super.key,
    required this.reservation,
  });

  final Reservations reservation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reservation.role,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      reservation.nameOfUser,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  reservation.id.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReservationTextDetails(
                  title: 'Program Name: ',
                  value: reservation.ticketName,
                ),
                8.verticalSpace,
                Row(
                  children: [
                    ReservationTextDetails(
                      title: 'Adult Count: ',
                      value: reservation.numberOfAdults.toString(),
                    ),
                    20.horizontalSpace,
                    ReservationTextDetails(
                      title: 'Child Count: ',
                      value: reservation.numberOfChilds.toString(),
                    ),
                  ],
                ),
                8.verticalSpace,
                ReservationTextDetails(
                  title: 'Additional Services: ',
                  value: reservation.addtionalServices
                      .map((service) => service.name)
                      .join(', '),
                ),
                8.verticalSpace,
                ReservationTextDetails(
                  title: 'Total Amount: ',
                  value: '${reservation.totalPrice} \$',
                ),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ReservationButton(
                      title: 'Print',
                      onTap: () {
                        context.push(
                          AppRouter.reservationTickets,
                          extra: reservation.id.toString(),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
