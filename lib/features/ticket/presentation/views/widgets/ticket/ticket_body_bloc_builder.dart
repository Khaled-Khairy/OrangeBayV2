import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orange_bay/core/utils/app_router.dart';
import 'package:orange_bay/core/utils/app_toast.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/ticket_body.dart';

class TicketBodyBlocBuilder extends StatelessWidget {
  const TicketBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketCubit, TicketState>(
      buildWhen: (previousState, currentState) {
        return currentState is TicketLoading || currentState is TicketSuccess || currentState is TicketFailure;
      },
      listener: (context, state) {
        if (state is ConfirmOrderFailure) {
          AppToast.displayToast(message: state.message, isError: true);
        } else if (state is ConfirmOrderSuccess) {
          AppToast.displayToast(message: 'Success', isError: false);

          String message = state.ordersResponse.message;
          int orderId = 0;
          RegExp regExp = RegExp(r'\d+');

          Match? match = regExp.firstMatch(message);
          if (match != null) {
            String orderIdString = match.group(0)!;
            orderId = int.parse(orderIdString);
            log("Extracted Order ID: $orderId");
          }

          context.push(
            AppRouter.orders,
            extra: orderId,
          );
        }
      },
      builder: (context, state) {
        if (state is TicketLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (state is TicketSuccess) {
          return const SingleChildScrollView(
            child: TicketBody(),
          );
        } else if (state is TicketFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
