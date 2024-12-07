import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_dialog.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_grid_view_item.dart';

class TicketGridView extends StatelessWidget {
  const TicketGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          const List<Color> colors = [
            Color(0xFFFBD8DE),
            Color(0xFF427FB8),
            Color(0xFF84B4DF),
            Color(0xFFD2B28F),
            Color(0xFF937FA3),
            Color(0xFFB4A0C8),
          ];
          final color = colors[index % colors.length];
          final cubit = context.read<TicketCubit>();
          final ticket = cubit.ticketsModel!.tickets[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: TicketDialog(
                      ticket: ticket,
                      index: index,
                    ),
                  );
                },
              );
            },
            child: TicketGridViewItem(
              color: color,
              title: ticket.title,
              adultPrice: ticket.detailsDto.first.adultPrice,
              childPrice: ticket.detailsDto.first.childPrice,
            ),
          );
        },
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: context.read<TicketCubit>().ticketsModel!.tickets.length,
      ),
    );
  }
}