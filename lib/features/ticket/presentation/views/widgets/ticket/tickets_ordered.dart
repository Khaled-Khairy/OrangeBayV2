import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';

import 'ticket_order_list_item.dart';

class TicketsOrderedList extends StatelessWidget {
  const TicketsOrderedList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      buildWhen: (previousState, currentState) => currentState is TicketUpdated,
      builder: (context, state) {
        if (state is TicketUpdated) {
          final orderedTickets = context.read<TicketCubit>().orderedTickets;
          return orderedTickets.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orderedTickets.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final orderedTicket = orderedTickets[index];
                    return TicketOrderedListItem(
                      orderedTicket: orderedTicket,
                      index: index,
                    );
                  },
                )
              : const Center(
                  child: Text('No Tickets'),
                );
        }
        return const Center(
          child: Text('No Tickets'),
        );
      },
    );
  }
}
