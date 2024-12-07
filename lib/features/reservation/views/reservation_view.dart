import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_app_bar.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_body.dart';
import 'package:orange_bay/features/reservation/views/widgets/reservation_floating_button.dart';

class ReservationView extends StatelessWidget {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReservationAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ReservationBody(),
        ),
      ),
      floatingActionButton: ReservationFloatingButton(),
    );
  }
}
