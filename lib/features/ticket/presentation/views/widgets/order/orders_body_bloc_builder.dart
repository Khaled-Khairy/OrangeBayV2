import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/order/orders_body.dart';
import 'package:orange_bay/models/order_model.dart';

class OrdersBodyBlocBuilder extends StatelessWidget {
  const OrdersBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      buildWhen: (previousState, currentState) =>
          currentState is OrdersLoading ||
          currentState is OrdersFailure ||
          currentState is OrdersSuccess,
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (state is OrdersFailure) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is OrdersSuccess) {
          final List<SerialNumber> serialNumbers = state.ordersModel.expand((order) => order.serialNumbers).toList();
          return OrdersBody(
            serialNumbers: serialNumbers,
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
