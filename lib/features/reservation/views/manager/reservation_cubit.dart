import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/core/utils/app_print.dart';
import 'package:orange_bay/features/reservation/data/repos/reservation_repo_impl.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit(this.reservationRepo) : super(ReservationInitial());
  final ReservationRepoImpl reservationRepo;
  List<BluetoothDevice> devices = [];
  final AppPrint printerService = AppPrint();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 1));

  void changeDateTimeRange(DateTime newFromDate, DateTime newToDate) {
    fromDate = newFromDate;
    toDate = newToDate;
    emit(ReservationDateUpdated());
  }
  Future<void> getReservations({required String dateTo, required String dateFrom,required int type}) async {
    emit(ReservationLoading());
    final result = await reservationRepo.getReservations(
      dateTo: dateTo,
      dateFrom: dateFrom,
      type: type,
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
