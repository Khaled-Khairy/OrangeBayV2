import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/core/utils/shared_preferences.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'ticket_order_list_item.dart';

class TicketsOrderedList extends StatelessWidget {
  const TicketsOrderedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      buildWhen: (previousState, currentState) => currentState is TicketUpdated,
      builder: (context, state) {
        if (state is TicketUpdated) {
          final cubit = context.read<TicketCubit>();
          final orderedTickets = cubit.orderedTickets;
          final userRole = PreferenceUtils.getString(PrefKeys.userType);

          if (orderedTickets.isEmpty) {
            return const Center(child: Text('No Tickets'));
          }

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderedTickets.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final ticket = cubit.ticketsModel!.tickets[index];
              final userDetails = ticket.detailsDto.firstWhere((detail) => detail.userType == userRole);
              final ticketPrice = (orderedTickets[index].adultQuantity * userDetails.adultPrice) + (orderedTickets[index].childQuantity * userDetails.adultPrice);
              return TicketOrderedListItem(
                orderedTicket: orderedTickets[index],
                index: index,
                ticketPrice: ticketPrice,
              );
            },
          );
        }
        return const Center(child: Text('No Tickets'));
      },
    );
  }
}
