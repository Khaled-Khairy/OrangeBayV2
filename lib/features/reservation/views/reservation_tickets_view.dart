import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/features/reservation/data/repos/reservation_repo_impl.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_tickets/reservation_tickets_bloc_builder.dart';

class ReservationTickets extends StatelessWidget {
  const ReservationTickets({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ReservationCubit(ReservationRepoImpl()),
        child: SafeArea(
          child: ReservationTicketsBody(
            orderId: orderId,
          ),
        ),
      ),
    );
  }
}
