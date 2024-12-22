import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_toast.dart';
import 'package:orange_bay/core/widgets/custom_button.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
            return CustomButton(
              backgroundColor: const Color(0xFF427FB8),
              text: 'Confirm',
              isLoading: state is TicketLoading,
              textColor: Colors.white,
              onPressed: () => _onConfirm(context),
            );
        },
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    final cubit = context.read<TicketCubit>();

    if (formKey.currentState!.validate()) {
      if (cubit.orderedTickets.isNotEmpty) {
        // cubit.postOrder(
        //   orderRequest: OrderRequest(
        //     nationalityId: cubit.selectedNationality!.id.toInt(),
        //     cruiseId: cubit.selectedCruise!.id.toInt(),
        //     tourGuideId: cubit.selectedGuide!.id.toInt(),
        //     harbourId: cubit.selectedHarbour!.id.toInt(),
        //     orderItems: cubit.orderedTickets,
        //   ),
        // );
      } else {
        AppToast.displayToast(
          message: 'Please Select Ticket',
          isError: true,
        );
      }
    }
  }
}
