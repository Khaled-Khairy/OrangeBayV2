import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:orange_bay/core/utils/api_failure.dart';
import 'package:orange_bay/core/utils/app_dio.dart';
import 'package:orange_bay/features/ticket/data/models/additional_services_model.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_request.dart';
import 'package:orange_bay/features/ticket/data/models/order/order_response.dart';
import 'package:orange_bay/features/ticket/data/models/orders_model.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/data/repos/ticket_repo.dart';

class TicketRepoImpl implements TicketRepo {
  @override
  Future<Either<ServerFailure, TicketsModel>> getAllTickets() async {
    try {
      final response = await AppDio.get(
          endPoint: 'http://elgzeraapp.runasp.net/api/tickets/getAllData');
      final tickets = TicketsModel.fromJson(response.data);
      return Right(tickets);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<ServerFailure, OrderResponse>> postOrder(
      {required OrderRequest orderRequest}) async {
    try {
      final response = await AppDio.post(
        endPoint: 'http://elgzeraapp.runasp.net/api/orders',
        body: orderRequest.toJson(),
      );
      final message = response.data;
      final orderResponse = OrderResponse(message: message);
      return Right(orderResponse);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<ServerFailure, List<OrdersModel>>> getOrders(
      {required String orderId}) async {
    try {
      final response = await AppDio.get(
        endPoint: 'http://elgzeraapp.runasp.net/api/orders/$orderId',
      );
      final List<OrdersModel> orders = [];
      for (var order in response.data) {
        orders.add(OrdersModel.fromJson(order));
      }
      return Right(orders);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<ServerFailure, List<AdditionalServicesModel>>>
      getAdditionalServices() async {
    try {
      final response = await AppDio.get(
        endPoint: 'http://elgzeraapp.runasp.net/api/AddtionalServices',
      );
      final List<AdditionalServicesModel> additionalServices = [];
      for (var additionalService in response.data['value']) {
        additionalServices.add(AdditionalServicesModel.fromJson(additionalService));
      }
      return Right(additionalServices);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
