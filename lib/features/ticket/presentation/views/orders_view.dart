import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/features/ticket/data/repos/ticket_repo_impl.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/order/orders_body_bloc_builder.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key, required this.orderID});
  final int orderID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TicketCubit(TicketRepoImpl())..getOrders(orderId: orderID.toString()),
        child: const SafeArea(
          child: OrdersBodyBlocBuilder(),
        ),
      ),
    );
  }
}
