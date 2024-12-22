import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orange_bay/core/utils/api_failure.dart';
import 'package:orange_bay/core/utils/app_dio.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_model.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_ticket_model.dart';
import 'package:orange_bay/features/reservation/data/repos/reservation_repo.dart';

class ReservationRepoImpl implements ReservationRepo {
  @override
  Future<Either<ServerFailure, List<Reservations>>> getReservations(
      {required String dateTo,
      required String dateFrom,
      required int type}) async {
    try {
      final response = await AppDio.get(endPoint: 'http://elgzeraapp.runasp.net/api/orders/GetByDate?Fromdate=$dateFrom&ToDate=$dateTo&Type=$type');
      final List<Reservations> reservations = [];

      for (var reservation in response.data['valueOrDefault']) {
        reservations.add(Reservations.fromJson(reservation));
      }
      return Right(reservations);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<ServerFailure, List<ReservationTicket>>> getReservationTickets(
      {required String orderId}) async {
    try {
      final response = await AppDio.get(endPoint: 'http://elgzeraapp.runasp.net/api/orders/$orderId');
      final List<ReservationTicket> reservationTickets = [];
      for (var reservation in response.data) {
        reservationTickets.add(ReservationTicket.fromJson(reservation));
      }
      return Right(reservationTickets);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
