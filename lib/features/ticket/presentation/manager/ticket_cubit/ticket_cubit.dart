import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/core/utils/app_print.dart';
import 'package:orange_bay/features/ticket/data/models/additional_services_model.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_response.dart';
import 'package:orange_bay/features/ticket/data/models/orders_model.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/data/repos/ticket_repo.dart';

import '../../../data/models/order/order_request.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit(this.ticketRepo) : super(TicketInitial());
  final TicketRepo ticketRepo;
  TicketsModel? ticketsModel;
  Nationality? selectedNationality;
  Harbour? selectedHarbour;
  TourGuide? selectedGuide;
  Cruise? selectedCruise;
  List<OrderItem> orderedTickets = [];
  List<BluetoothDevice> devices = [];
  final AppPrint printerService = AppPrint();
  List<AdditionalServicesModel> selectedServices = [];

  num get totalPrice {
    return orderedTickets.fold(0.0, (sum, ticket) {
      final ticketTotalPrice =
          ticket.orderItemDetails.fold(0.0, (subSum, detail) {
        return subSum + detail.ticketPrice.toDouble();
      });

      return sum + ticketTotalPrice;
    });
  }

  Future<void> getAllTickets() async {
    emit(TicketLoading());
    final result = await ticketRepo.getAllTickets();
    result.fold(
      (failure) => emit(TicketFailure(failure.message)),
      (tickets) {
        emit(TicketSuccess(tickets));
        ticketsModel = tickets;
      },
    );
  }

  void addOrderedTicket(OrderItem orderedTicket) {
    orderedTickets.add(orderedTicket);
    emit(TicketUpdated(orderedTickets));
  }

  void removeOrderedTicketByIndex(int index) {
    orderedTickets.removeAt(index);
    emit(TicketUpdated(orderedTickets));
  }

  Future<void> postOrder({required OrderRequest orderRequest}) async {
    emit(ConfirmOrderLoading());
    final result = await ticketRepo.postOrder(orderRequest: orderRequest);
    result.fold(
      (failure) => emit(ConfirmOrderFailure(failure.message)),
      (orderResponse) => emit(ConfirmOrderSuccess(orderResponse)),
    );
  }

  Future<void> getOrders({required String orderId}) async {
    emit(OrdersLoading());
    final result = await ticketRepo.getOrders(orderId: orderId);
    result.fold(
      (failure) => emit(OrdersFailure(failure.message)),
      (orders) => emit(OrdersSuccess(orders)),
    );
  }

  Future<void> getDevices() async {
    devices.clear();
    devices = await printerService.getBondedDevices();
    emit(GetDevices());
  }

  Future<void> getAdditionalServices() async {
    emit(AdditionalServicesLoading());
    final result = await ticketRepo.getAdditionalServices();
    result.fold(
      (failure) => emit(AdditionalServicesFailure(failure.message)),
      (additionalServices) =>
          emit(AdditionalServicesSuccess(additionalServices)),
    );
  }
}
