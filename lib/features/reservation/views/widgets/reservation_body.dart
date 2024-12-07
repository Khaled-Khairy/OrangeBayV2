import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_item.dart';

import '../manager/reservation_state.dart';

class ReservationBody extends StatelessWidget {
  const ReservationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationCubit, ReservationState>(
      buildWhen: (previousState, currentState) =>
          currentState is ReservationSuccess ||
          currentState is ReservationLoading ||
          currentState is ReservationFailed,
      builder: (context, state) {
        if (state is ReservationLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.blue,
            ),
          );
        } else if (state is ReservationSuccess) {
          if (state.reservations.isEmpty) {
            return Center(
              child: Text(
                'No Reservations',
                style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.reservations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: ReservationItem(
                    reservation: state.reservations[index],
                  ),
                );
              },
            );
          }
        } else if (state is ReservationFailed) {
          return Center(
            child: Text(state.message),
          );
        } else {
          context.pop();
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
