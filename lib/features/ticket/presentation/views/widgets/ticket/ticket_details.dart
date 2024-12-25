import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/core/utils/app_toast.dart';
import 'package:orange_bay/core/utils/shared_preferences.dart';
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
    required this.childQuantity, required this.filteredDetails,
  });

  final int adultQuantity;
  final int childQuantity;
  final List<DetailsDto> filteredDetails;
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
    adultControllers = List.generate(widget.adultQuantity, (_) => TextEditingController());
    childControllers = List.generate(widget.childQuantity, (_) => TextEditingController());
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneNumberController.dispose();
    for (var controller in adultControllers) {
      controller.dispose();
    }
    for (var controller in childControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint, {TextInputType? type, List<TextInputFormatter>? inputFormatters}) {
    return TicketDetailsInputField(
      controller: controller,
      hint: hint,
      type: type,
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildServicesDropdown(List<AdditionalServicesModel> additionalServices, String type, int index) {
    final cubit = context.read<TicketCubit>();

    // Ensure that the selected services lists are initialized up to the current index
    if (type == 'adult') {
      while (cubit.selectedAdultServices.length <= index) {
        cubit.selectedAdultServices.add([]); // Add an empty list for uninitialized indices
      }
    } else if (type == 'child') {
      while (cubit.selectedChildServices.length <= index) {
        cubit.selectedChildServices.add([]); // Add an empty list for uninitialized indices
      }
    }

    return ServicesDropdown(
      additionalServices: additionalServices,
      type: type,
      onServiceSelected: (List<AdditionalServicesModel> value) {
        if (type == 'adult') {
          cubit.selectedAdultServices[index] = value;
        } else {
          cubit.selectedChildServices[index] = value;
        }
      },
    );
  }

  List<Widget> _buildPersonDetails(int quantity, List<TextEditingController> controllers, String type) {
    return List.generate(
      quantity,
      (index) => Column(
        spacing: 6.h,
        children: [
          _buildInputField(controllers[index], '$type Name ${index + 1}'),
          _buildServicesDropdown(
            widget.additionalServices,
            type.toLowerCase(),
            index,
          ),
        ],
      ),
    );
  }

  bool _validateInputs() {
    if (emailController.text.trim().isEmpty || phoneNumberController.text.trim().isEmpty) {
      AppToast.displayToast(
        message: 'Email and phone number cannot be empty.',
        isError: true,
      );
      return false;
    }

    for (var i = 0; i < widget.adultQuantity; i++) {
      if (adultControllers[i].text.trim().isEmpty) {
        AppToast.displayToast(
          message: 'All adult names must be filled.',
          isError: true,
        );
        return false;
      }
    }

    for (var i = 0; i < widget.childQuantity; i++) {
      if (childControllers[i].text.trim().isEmpty) {
        AppToast.displayToast(
          message: 'All child names must be filled.',
          isError: true,
        );
        return false;
      }
    }

    return true;
  }

  void _handleAddButtonPressed() {
    if (!_validateInputs()) return;

    final cubit = context.read<TicketCubit>();
    final tickets = cubit.ticketsModel?.tickets ?? [];
    final filteredTickets = tickets.where((ticket) {
      final userRole = PreferenceUtils.getString(PrefKeys.userType);
      return ticket.detailsDto.any((detail) => detail.userType == userRole);
    }).toList();

    if (filteredTickets.length < widget.adultQuantity + widget.childQuantity) {
      AppToast.displayToast(
        message: 'Not enough tickets available for the required quantity.',
        isError: true,
      );
      return;
    }

    try {
      final orderDetails = <OrderItemDetail>[];
      final userRole = PreferenceUtils.getString(PrefKeys.userType);

      for (int i = 0; i < widget.adultQuantity; i++) {
        if (i >= filteredTickets.length) {
          throw RangeError('Index $i is out of range for adult tickets.');
        }

        final ticket = filteredTickets[i];
        orderDetails.add(
          OrderItemDetail(
            name: ticket.title,
            ticketId: ticket.id.toInt(),
            ticketPrice: ticket.detailsDto
                .firstWhere((detail) => detail.userType == userRole)
                .adultPrice
                .toInt(),
            phoneNumber: phoneNumberController.text.trim(),
            email: emailController.text.trim(),
            additionalServicesPrice: cubit.selectedAdultServices[i].fold(0, (sum, service) => sum + service.childPrice),
            personAge: 1,
            services: cubit.selectedAdultServices[i].map((service) => service.id).toList(),
            bookingDate: DateTime.now(),
          ),
        );
      }

      for (int i = 0; i < widget.childQuantity; i++) {
        final childIndex = widget.adultQuantity + i;
        if (childIndex >= filteredTickets.length) {
          throw RangeError('Index $childIndex is out of range for child tickets.');
        }

        final ticket = filteredTickets[childIndex];
        orderDetails.add(
          OrderItemDetail(
            name: ticket.title,
            ticketId: ticket.id.toInt(),
            ticketPrice: ticket.detailsDto
                .firstWhere((detail) => detail.userType == userRole)
                .childPrice
                .toInt(),
            phoneNumber: phoneNumberController.text.trim(),
            email: emailController.text.trim(),
            additionalServicesPrice: cubit.selectedChildServices[i].fold(0, (sum, service) => sum + service.childPrice),
            personAge: 2,
            services: cubit.selectedChildServices[i].map((service) => service.id).toList(),
            bookingDate: DateTime.now(),
          ),
        );
      }

      cubit.addOrderedTicket(
        OrderItem(
          orderItemDetails: orderDetails,
          adultQuantity: widget.adultQuantity,
          childQuantity: widget.childQuantity,
        ),
      );

      context.pop();
    } catch (e) {
      AppToast.displayToast(
        message: 'Error: ${e.toString()}',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          spacing: 6.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.adultQuantity > 0) _buildSectionTitle('Adults'),
            if (widget.adultQuantity > 0)
              Column(
                spacing: 6.h,
                children: [
                  _buildInputField(emailController, 'Email'),
                  _buildInputField(
                    phoneNumberController,
                    'Phone Number',
                    type: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  ..._buildPersonDetails(
                    widget.adultQuantity,
                    adultControllers,
                    'Adult',
                  ),
                ],
              ),
            if (widget.childQuantity > 0) _buildSectionTitle('Children'),
            if (widget.childQuantity > 0)
              Column(
                spacing: 6.h,
                children: _buildPersonDetails(
                  widget.childQuantity,
                  childControllers,
                  'Child',
                ),
              ),
            CustomButton(
              backgroundColor: AppColors.blue,
              text: 'Add',
              textColor: Colors.white,
              onPressed: _handleAddButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}