import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_toast.dart';
import 'package:orange_bay/core/widgets/custom_button.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_request.dart';
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
          if (state is ConfirmOrderLoading) {
            return Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF427FB8),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            );
          } else {
            return CustomButton(
              backgroundColor: const Color(0xFF427FB8),
              text: 'Confirm',
              textColor: Colors.white,
              onPressed: () => _onConfirm(context),
            );
          }
        },
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    final cubit = context.read<TicketCubit>();

    if (formKey.currentState!.validate()) {
      if (cubit.orderedTickets.isNotEmpty) {
        cubit.postOrder(
          orderRequest: OrderRequest(
            nationalityId: cubit.selectedNationality!.id.toInt(),
            cruiseId: cubit.selectedCruise!.id.toInt(),
            tourGuideId: cubit.selectedGuide!.id.toInt(),
            harbourId: cubit.selectedHarbour!.id.toInt(),
            orderItems: cubit.orderedTickets,
          ),
        );
      } else {
        AppToast.displayToast(
          message: 'Please Select Ticket',
          isError: true,
        );
      }
    }
  }
}
