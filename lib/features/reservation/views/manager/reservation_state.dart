import 'package:flutter/cupertino.dart';
import 'package:orange_bay/features/reservation/data/models/reservation_ticket_model.dart';

import '../../data/models/reservation_model.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitial extends ReservationState {}

final class ReservationLoading extends ReservationState {}

final class ReservationSuccess extends ReservationState {
  final List<Reservations> reservations;

  ReservationSuccess(this.reservations);
}

final class ReservationFailed extends ReservationState {
  final String message;

  ReservationFailed(this.message);
}

final class ReservationDateUpdated extends ReservationState {}

final class ReservationTicketLoading extends ReservationState {}

final class ReservationTicketSuccess extends ReservationState {
  final ReservationTicket reservationTicket;

  ReservationTicketSuccess(this.reservationTicket);
}

final class ReservationTicketFailed extends ReservationState {
  final String message;

  ReservationTicketFailed(this.message);
}
