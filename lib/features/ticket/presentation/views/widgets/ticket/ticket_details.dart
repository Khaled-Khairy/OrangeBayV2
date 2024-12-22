import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/core/widgets/custom_button.dart';
import 'package:orange_bay/features/ticket/data/models/additional_services_model.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_request.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/services_drop_down.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_details_input_field.dart';

class TicketDetails extends StatefulWidget {
  const TicketDetails({
    super.key,
    required this.additionalServices,
    required this.adultQuantity,
    required this.childQuantity,
    required this.ticket,
  });

  final int adultQuantity;
  final int childQuantity;
  final Ticket ticket;
  final List<AdditionalServicesModel> additionalServices;

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late List<TextEditingController> adultControllers;
  late List<TextEditingController> childControllers;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    adultControllers =
        List.generate(widget.adultQuantity, (_) => TextEditingController());
    childControllers =
        List.generate(widget.childQuantity, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in adultControllers) {
      controller.dispose();
    }
    for (var controller in childControllers) {
      controller.dispose();
    }
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4.h,
          children: [
            if (widget.adultQuantity > 0)
              const Text(
                'Adults',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (widget.adultQuantity > 0)
              Column(
                spacing: 2.w,
                children: [
                  TicketDetailsInputField(
                    controller: emailController,
                    hint: 'Email',
                  ),
                  TicketDetailsInputField(
                    controller: phoneNumberController,
                    hint: 'Phone Number',
                    type: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            Column(
              spacing: 6.h,
              children: List.generate(
                widget.adultQuantity,
                (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6.w,
                    children: [
                      TicketDetailsInputField(
                        controller: adultControllers[index],
                        hint: 'Adult Name ${index + 1}',
                      ),
                      ServicesDropdown(
                        additionalServices: widget.additionalServices,
                        type: 'adult',
                        onServiceSelected:
                            (List<AdditionalServicesModel> value) {
                          final cubit = context.read<TicketCubit>();
                          cubit.selectedAdultServices[index] = value;
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            if (widget.childQuantity > 0)
              const Text(
                'Children',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            Column(
              spacing: 6.h,
              children: List.generate(
                widget.childQuantity,
                (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6.w,
                    children: [
                      TicketDetailsInputField(
                        controller: childControllers[index],
                        hint: 'Child Name ${index + 1}',
                      ),
                      ServicesDropdown(
                        additionalServices: widget.additionalServices,
                        type: 'child',
                        onServiceSelected: (List<AdditionalServicesModel> value) {
                          final cubit = context.read<TicketCubit>();
                          cubit.selectedChildServices[index] = value;
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            CustomButton(
              backgroundColor: AppColors.blue,
              text: 'Add',
              textColor: Colors.white,
              onPressed: () {
                final cubit = context.read<TicketCubit>();
                cubit.addOrderedTicket(
                  OrderItem(
                    orderItemDetails: [
                      ...List.generate(
                        widget.adultQuantity,
                        (index) => OrderItemDetail(
                          name: adultControllers[index].text,
                          ticketId: widget.ticket.id.toInt(),
                          ticketPrice: widget
                              .ticket.detailsDto[index].adultPrice
                              .toInt(),
                          phoneNumber: phoneNumberController.text.trim(),
                          email: emailController.text.trim(),
                          additionalServicesPrice: 1000,
                          personAge: 1,
                          services: context
                              .read<TicketCubit>()
                              .selectedAdultServices[index]
                              .map((service) => service.id)
                              .toList(),
                          bookingDate: DateTime.now(),
                        ),
                      ),
                      ...List.generate(
                        widget.childQuantity,
                        (index) => OrderItemDetail(
                          name: adultControllers[index].text,
                          ticketId: widget.ticket.id.toInt(),
                          ticketPrice: widget
                              .ticket.detailsDto[index].adultPrice
                              .toInt(),
                          phoneNumber: phoneNumberController.text.trim(),
                          email: emailController.text.trim(),
                          additionalServicesPrice: 1000,
                          personAge: 2,
                          services: context
                              .read<TicketCubit>()
                              .selectedChildServices[index]
                              .map((service) => service.id)
                              .toList(),
                          bookingDate: DateTime.now(),
                        ),
                      ),
                    ],
                    adultQuantity: widget.adultQuantity,
                    childQuantity: widget.childQuantity,
                  ),
                );
                context.pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
