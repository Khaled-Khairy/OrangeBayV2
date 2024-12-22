import 'package:dartz/dartz.dart';
import 'package:orange_bay/core/utils/api_failure.dart';
import 'package:orange_bay/features/ticket/data/models/additional_services_model.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_request.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_response.dart';
import 'package:orange_bay/features/ticket/data/models/orders_model.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';

abstract class TicketRepo {
  Future<Either<ServerFailure, TicketsModel>> getAllTickets();
  Future<Either<ServerFailure, List<AdditionalServicesModel>>> getAdditionalServices();
  Future<Either<ServerFailure, OrderResponse>> postOrder({required OrderRequest orderRequest});
  Future<Either<ServerFailure, List<OrdersModel>>> getOrders({required String orderId});

}
