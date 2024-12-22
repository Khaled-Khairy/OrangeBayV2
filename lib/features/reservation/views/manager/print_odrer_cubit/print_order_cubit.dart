
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/features/reservation/data/repos/reservation_repo_impl.dart';

part 'print_order_state.dart';

class PrintOrderCubit extends Cubit<PrintOrderState> {
  PrintOrderCubit() : super(PrintOrderInitial());
  final ReservationRepoImpl reservationRepo = ReservationRepoImpl();

  Future<void> printOrder({required String orderId}) async {
    emit(PrintOrderLoading());
    final result = await reservationRepo.printOrder(orderId: orderId);
    result.fold(
      (failure) => emit(PrintOrderFailure(failure.message)),
      (order) => emit(PrintOrderSuccess(order)),
    );
  }
}
