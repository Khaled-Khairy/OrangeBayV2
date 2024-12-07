import 'package:dartz/dartz.dart';
import 'package:orange_bay/core/utils/api_failure.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_model.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_ticket_model.dart';

abstract class ReservationRepo {
  Future<Either<ServerFailure, List<Reservations>>> getReservations({required String dateTime});
  Future<Either<ServerFailure, ReservationTicket>> getReservationTickets({required String orderId});
}
