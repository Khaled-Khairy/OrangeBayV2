import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/core/utils/app_toast.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';

class ReservationFloatingButton extends StatelessWidget {
  const ReservationFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        DateTime? fromDate = await _selectDate(context, 'From date');
        if (fromDate == null) return;

        DateTime? toDate;
        if (context.mounted) {
          toDate = await _selectDate(context, 'To date');
        }
        if (toDate == null || toDate.isBefore(fromDate)) {
          AppToast.displayToast(
            message: 'The "To" date must be after the "From" date',
            isError: true,
          );
          return;
        }

        if (context.mounted) {
          context
              .read<ReservationCubit>()
              .changeDateTimeRange(fromDate, toDate);

          context.read<ReservationCubit>().getReservations(
                dateFrom: fromDate.toIso8601String(),
                dateTo: toDate.toIso8601String(),
                type: 1,
              );
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

  Future<DateTime?> _selectDate(BuildContext context, String title) async {
    return showDatePicker(
      context: context,
      helpText: title,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }
}
