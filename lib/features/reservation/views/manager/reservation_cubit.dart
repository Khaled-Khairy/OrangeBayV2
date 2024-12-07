import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/core/utils/app_print.dart';
import 'package:orange_bay/features/reservation/data/repos/reservation_repo_impl.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit(this.reservationRepo) : super(ReservationInitial());
  final ReservationRepoImpl reservationRepo;
  DateTime dateTime = DateTime.now();
  List<BluetoothDevice> devices = [];
  final AppPrint printerService = AppPrint();

  void changeDateTime(DateTime dateTime) {
    this.dateTime = dateTime;
    emit(ReservationDateUpdated());
  }

  Future<void> getReservations() async {
    emit(ReservationLoading());
    final result = await reservationRepo.getReservations(
      dateTime: dateTime.toString(),
    );
    result.fold(
      (failure) => emit(ReservationFailed(failure.message)),
      (reservations) => emit(ReservationSuccess(reservations)),
    );
  }

  Future<void> getReservationTickets({required String orderId}) async {
    emit(ReservationTicketLoading());
    final result = await reservationRepo.getReservationTickets(
      orderId: orderId,
    );
    result.fold(
      (failure) => emit(ReservationTicketFailed(failure.message)),
      (reservations) => emit(ReservationTicketSuccess(reservations)),
    );
  }
  Future<void> getDevices() async {
    devices.clear();
    devices = await printerService.getBondedDevices();
  }
}
