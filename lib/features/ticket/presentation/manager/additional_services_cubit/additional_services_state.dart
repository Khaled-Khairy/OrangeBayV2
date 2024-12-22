part of 'additional_services_cubit.dart';

@immutable
sealed class AdditionalServicesState {}

final class AdditionalServicesInitial extends AdditionalServicesState {}
final class AdditionalServicesLoading extends AdditionalServicesState {}
final class AdditionalServicesSuccess extends AdditionalServicesState {
  final List<AdditionalServicesModel> additionalServicesModelList;
  AdditionalServicesSuccess(this.additionalServicesModelList);
}
final class AdditionalServicesFailure extends AdditionalServicesState {
  final String message;
  AdditionalServicesFailure(this.message);
}
