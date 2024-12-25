import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_details.dart';

class TicketDetailsBlocBuilder extends StatefulWidget {
  const TicketDetailsBlocBuilder({
    super.key,
    required this.adultQuantity,
    required this.childQuantity, required this.filteredDetails,
  });

  final int adultQuantity;
  final int childQuantity;
  final List<DetailsDto> filteredDetails;

  @override
  State<TicketDetailsBlocBuilder> createState() => _TicketDetailsBlocBuilderState();
}

class _TicketDetailsBlocBuilderState extends State<TicketDetailsBlocBuilder> {
  @override
  void initState() {
    context.read<TicketCubit>().getAdditionalServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      buildWhen: (current, previous) =>
          previous is AdditionalServicesLoading ||
          previous is AdditionalServicesFailure ||
          previous is AdditionalServicesSuccess,
      builder: (context, state) {
        if (state is AdditionalServicesLoading) {
          return SizedBox(
            height: 250.h,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.blue,
              ),
            ),
          );
        } else if (state is AdditionalServicesFailure) {
          return SizedBox(
            height: 250.h,
            child: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is AdditionalServicesSuccess) {
          return TicketDetails(
            additionalServices: state.additionalServicesModelList,
            adultQuantity: widget.adultQuantity,
            childQuantity: widget.childQuantity,
            filteredDetails: widget.filteredDetails,
          );
        } else {
          return SizedBox(
            height: 250.h,
            child: const Center(
              child: Text('Unexpected Error'),
            ),
          );
        }
      },
    );
  }
}
