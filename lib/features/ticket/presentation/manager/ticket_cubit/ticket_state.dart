part of 'ticket_cubit.dart';

@immutable
sealed class TicketState {}

final class TicketInitial extends TicketState {}

final class TicketLoading extends TicketState {}

final class TicketSuccess extends TicketState {
  final TicketsModel ticketsModel;

  TicketSuccess(this.ticketsModel);
}

final class TicketFailure extends TicketState {
  final String message;

  TicketFailure(this.message);
}

class TicketUpdated extends TicketState {
  final List<OrderItem> orderedTickets;

  TicketUpdated(this.orderedTickets);
}

final class ConfirmOrderLoading extends TicketState {}

final class ConfirmOrderSuccess extends TicketState {
  final OrderResponse ordersResponse;

  ConfirmOrderSuccess(this.ordersResponse);
}

final class ConfirmOrderFailure extends TicketState {
  final String message;

  ConfirmOrderFailure(this.message);
}
final class OrdersLoading extends TicketState {}

final class OrdersSuccess extends TicketState {
  final List<OrdersModel> ordersModel;

  OrdersSuccess(this.ordersModel);
}

final class OrdersFailure extends TicketState {
  final String message;

  OrdersFailure(this.message);
}
final class GetDevices extends TicketState {}