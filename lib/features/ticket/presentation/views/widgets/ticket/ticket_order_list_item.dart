import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_request.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';

class TicketOrderedListItem extends StatelessWidget {
  const TicketOrderedListItem({
    super.key,
    required this.orderedTicket,
    required this.index,
  });

  final OrderItem orderedTicket;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        title: Text(
          orderedTicket.orderItemDetails.first.name,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket Count : ${orderedTicket.orderItemDetails.length}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.verticalSpace,
            Text(
              'Adults : ${orderedTicket.adultQuantity} | Children : ${orderedTicket.childQuantity}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.verticalSpace,
            Text(
              'Price: \$${orderedTicket.orderItemDetails.last.ticketPrice}',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.green[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            context.read<TicketCubit>().removeOrderedTicketByIndex(index);
          },
        ),
        iconColor: Colors.red,
      ),
    );
  }
}
