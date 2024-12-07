import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import '../manager/reservation_cubit.dart';
import '../manager/reservation_state.dart';
class ReservationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReservationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationCubit, ReservationState>(
      buildWhen: (previousState, currentState) => currentState is ReservationDateUpdated,
      builder: (context, state) {
        DateTime dateTime = context.read<ReservationCubit>().dateTime;
        String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

        return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Reservation List : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: formattedDate,
                  style: TextStyle(
                    color: AppColors.blue,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}