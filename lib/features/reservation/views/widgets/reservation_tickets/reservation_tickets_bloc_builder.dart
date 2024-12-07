import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_state.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_tickets/reservation_ticket_body.dart';

class ReservationTicketsBody extends StatefulWidget {
  const ReservationTicketsBody({super.key, required this.orderId});

  final String orderId;

  @override
  State<ReservationTicketsBody> createState() => _ReservationTicketsBodyState();
}

class _ReservationTicketsBodyState extends State<ReservationTicketsBody> {
  @override
  void initState() {
    context.read<ReservationCubit>().getReservationTickets(
          orderId: widget.orderId,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationCubit, ReservationState>(
      builder: (context, state) {
        if (state is ReservationTicketLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.blue),
          );
        } else if (state is ReservationTicketSuccess) {
          return state.reservationTicket.bookingItems.isEmpty
              ? Center(
                  child: Text(
                    'No Reservations',
                    style: TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                )
              : ReservationTicketBody(
                  reservationTicket: state.reservationTicket,
                );
        } else if (state is ReservationTicketFailed) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
