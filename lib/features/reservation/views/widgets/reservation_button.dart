import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/core/utils/app_colors.dart';

class ReservationButton extends StatelessWidget {
  const ReservationButton({
    super.key,
    required this.title,
    required this.onTap, required this.isPrinted,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isPrinted;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: isPrinted ? null : onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: isPrinted ? Colors.grey : AppColors.blue,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              isPrinted ? 'Printed' : title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}