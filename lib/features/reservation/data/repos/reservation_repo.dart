import 'package:dartz/dartz.dart';
import 'package:orange_bay/core/utils/api_failure.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_model.dart';
import 'package:orange_bay/models/order_model.dart';

abstract class ReservationRepo {
  Future<Either<ServerFailure, List<Reservations>>> getReservations({required String dateTo, required String dateFrom,required int type});
  Future<Either<ServerFailure, List<OrderModel>>> getReservationTickets({required String orderId});
  Future<Either<ServerFailure, String>> printOrder({required String orderId});
}
