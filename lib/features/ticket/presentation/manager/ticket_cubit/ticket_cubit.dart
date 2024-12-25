import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/core/utils/app_print.dart';
import 'package:orange_bay/core/utils/shared_preferences.dart';
import 'package:orange_bay/features/ticket/data/models/additional_services_model.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_response.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/data/repos/ticket_repo.dart';
import 'package:orange_bay/models/order_model.dart';

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
  List<List<AdditionalServicesModel>> selectedAdultServices = [];
  List<List<AdditionalServicesModel>> selectedChildServices = [];
  Ticket? selectedTicket;
  int totalPrice = 0;
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
  int calculateTicketPrice(OrderItem orderedTicket) {
    final userRole = PreferenceUtils.getString(PrefKeys.userType);
    final ticket = ticketsModel!.tickets.firstWhere((ticket) => ticket.detailsDto.any((detail) => detail.userType == userRole));
    final userDetails = ticket.detailsDto.firstWhere((detail) => detail.userType == userRole);
    return (orderedTicket.adultQuantity * userDetails.adultPrice).toInt() + (orderedTicket.childQuantity * userDetails.adultPrice).toInt();
  }
  void addOrderedTicket(OrderItem orderedTicket) {
    totalPrice += calculateTicketPrice(orderedTicket);

    orderedTickets.add(orderedTicket);
    emit(TicketUpdated(orderedTickets));
  }

  void removeOrderedTicketByIndex(int index) {
    final removedTicket = orderedTickets[index];

    totalPrice -= calculateTicketPrice(removedTicket);
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