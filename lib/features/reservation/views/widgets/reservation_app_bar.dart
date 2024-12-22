import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/features/reservation/views/widgets/app_bar_drop_down.dart';
import '../manager/reservation_cubit.dart';
import '../manager/reservation_state.dart';

class ReservationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReservationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationCubit, ReservationState>(
      buildWhen: (previousState, currentState) =>
          currentState is ReservationDateUpdated,
      builder: (context, state) {
        DateTime fromDate = context.read<ReservationCubit>().fromDate;
        DateTime toDate = context.read<ReservationCubit>().toDate;
        String formattedFromDate = DateFormat('dd/MM/yyyy').format(fromDate);
        String formattedToDate = DateFormat('dd/MM/yyyy').format(toDate);

        return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          clipBehavior: Clip.none,
          centerTitle: true,
          toolbarHeight: 120.h,
          title: Column(
            children: [
              Text(
                '$formattedFromDate - $formattedToDate',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const AppBarDropDown(),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
