import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';

class ReservationFloatingButton extends StatelessWidget {
  const ReservationFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null && context.mounted) {
          context.read<ReservationCubit>().changeDateTime(pickedDate);
          context.read<ReservationCubit>().getReservations();
        }
      },
      backgroundColor: AppColors.blue,
      child: Icon(
        Icons.calendar_month,
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }
}
