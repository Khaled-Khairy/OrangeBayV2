import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';

class AppBarDropDown extends StatefulWidget {
  const AppBarDropDown({super.key});

  @override
  State<AppBarDropDown> createState() => _AppBarDropDownState();
}

class _AppBarDropDownState extends State<AppBarDropDown> {
  int selectedValue = 1;
  final List<DropdownMenuItem<int>> items = [
    DropdownMenuItem(
      value: 1,
      child: Text(
        'Tickets',
        style: TextStyle(
          color: AppColors.blue,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text(
        'Reservation',
        style: TextStyle(
          color: AppColors.blue,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedValue,
      items: items,
      elevation: 2,
      style: TextStyle(
        color: AppColors.blue,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      borderRadius: BorderRadius.circular(8.r),
      dropdownColor: Colors.white,
      onChanged: (value) async {
        if (value != null) {
          setState(() {
            selectedValue = value;
          });

          final cubit = context.read<ReservationCubit>();
          await cubit.getReservations(
            dateTo: cubit.toDate.toString(),
            dateFrom: cubit.fromDate.toString(),
            type: value,
          );
        }
      },
    );
  }
}
