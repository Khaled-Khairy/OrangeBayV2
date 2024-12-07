import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/available_tickets_title.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/divider_section.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_data.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_date_display.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_grid_view.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/tickets_ordered.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/total_price.dart';

import 'confirm_button.dart';

class TicketBody extends StatefulWidget {
  const TicketBody({super.key});

  @override
  State<TicketBody> createState() => _TicketBodyState();
}

class _TicketBodyState extends State<TicketBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TicketDateDisplay(),
        10.verticalSpace,
        Form(
          key: formKey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: const TicketData(),
          ),
        ),
        10.verticalSpace,
        const AvailableTicketsTitle(),
        const TicketGridView(),
        const TicketsOrderedList(),
        const DividerSection(),
        const TotalPrice(),
        ConfirmButton(
          formKey: formKey,
        ),
      ],
    );
  }
}
