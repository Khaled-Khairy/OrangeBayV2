import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_toast.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/quntity_input_field.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_details_bloc_builder.dart';

import '../../../../../../core/widgets/custom_button.dart';

class TicketDialog extends StatefulWidget {
  const TicketDialog({
    super.key,
    required this.ticket,
    required this.index,
    required this.blocContext,
  });

  final Ticket ticket;
  final int index;
  final BuildContext blocContext;

  @override
  State<TicketDialog> createState() => _TicketDialogState();
}

class _TicketDialogState extends State<TicketDialog> {
  final TextEditingController adultCountController = TextEditingController();
  final TextEditingController childCountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    adultCountController.dispose();
    childCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Ticket ${widget.ticket.title}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  QuantityInputField(
                    controller: adultCountController,
                    hint: 'Adults Count',
                  ),
                  6.verticalSpace,
                  QuantityInputField(
                    controller: childCountController,
                    hint: 'Children Count',
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    text: 'Add',
                    onPressed: onAddButtonPressed,
                    backgroundColor: const Color(0xFF427FB8),
                    textColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    text: 'Close',
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: Colors.transparent,
                    textColor: const Color(0xFF427FB8),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onAddButtonPressed() {
    var adminDetails = widget.ticket.detailsDto
        .where((detail) => detail.userType == 'Admin')
        .toList();
    if (adminDetails.isEmpty) {
      AppToast.displayToast(
        message: 'No Admin tickets available.',
        isError: true,
      );
      Navigator.pop(context);
      return;
    }
    int adultPrice = adminDetails.first.adultPrice.toInt();
    int childPrice = adminDetails.first.childPrice.toInt();

    int adultQuantity = int.tryParse(adultCountController.text) ?? 0;
    int childQuantity = int.tryParse(childCountController.text) ?? 0;

    if (adultQuantity == 0 && childQuantity == 0) {
      AppToast.displayToast(
        message: 'Please enter a valid quantity for adults or children',
        isError: true,
      );
      Navigator.pop(context);
      return;
    }
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      elevation: 0,
      builder: (BuildContext context) {
        final cubit = widget.blocContext.read<TicketCubit>();
        return BlocProvider.value(
          value: cubit,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TicketDetailsBlocBuilder(
              adultQuantity: adultQuantity,
              childQuantity: childQuantity,
              ticket: widget.ticket,
            ),
          ),
        );
      },
    );
  }
}
