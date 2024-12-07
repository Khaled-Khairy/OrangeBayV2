import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_toast.dart';
import 'package:orange_bay/core/widgets/text_form_field.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_request.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';

import '../../../../../../core/widgets/custom_button.dart';

class TicketDialog extends StatefulWidget {
  const TicketDialog({
    super.key,
    required this.ticket, required this.index,
  });

  final Ticket ticket;
  final int index;
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
    // Filter the detailsDto to only include tickets with 'Admin' userType
    var adminDetails = widget.ticket.detailsDto.where((detail) => detail.userType == 'Admin').toList();

    // If no 'Admin' details are found, display a toast and return
    if (adminDetails.isEmpty) {
      AppToast.displayToast(
        message: 'No Admin tickets available.',
        isError: true,
      );
      Navigator.pop(context);
      return;
    }

    // Get the admin price details
    int adultPrice = adminDetails.first.adultPrice.toInt();
    int childPrice = adminDetails.first.childPrice.toInt();

    // Get quantities from controllers
    int adultQuantity = int.tryParse(adultCountController.text) ?? 0;
    int childQuantity = int.tryParse(childCountController.text) ?? 0;

    // Calculate total price
    int totalPrice = (adultPrice * adultQuantity) + (childPrice * childQuantity);

    // Check if quantities are valid
    if (adultQuantity == 0 && childQuantity == 0) {
      AppToast.displayToast(
        message: 'Please enter a valid quantity for adults or children',
        isError: true,
      );
      Navigator.pop(context);
      return;
    }

    // Add the ordered ticket to the TicketCubit
    context.read<TicketCubit>().addOrderedTicket(
      OrderItem(
        ticketName: widget.ticket.title,
        ticketId: widget.ticket.id.toInt(),
        price: totalPrice,
        adultQuantity: adultQuantity,
        childQuantity: childQuantity,
        ticketCount: adultQuantity + childQuantity,
      ),
    );

    // Close the dialog
    Navigator.pop(context);
  }
}

class QuantityInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const QuantityInputField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hint: hint,
      type: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      enabledColor: const Color(0xFF427FB8),
      focusColor: const Color(0xFF427FB8),
      validate: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the $hint';
        }
        return null;
      },
    );
  }
}
