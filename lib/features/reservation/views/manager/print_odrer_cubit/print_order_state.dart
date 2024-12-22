part of 'print_order_cubit.dart';

@immutable
sealed class PrintOrderState {}

final class PrintOrderInitial extends PrintOrderState {}
final class PrintOrderLoading extends PrintOrderState {}
final class PrintOrderSuccess extends PrintOrderState {
  final String message;
  PrintOrderSuccess(this.message);
}
final class PrintOrderFailure extends PrintOrderState {
  final String message;
  PrintOrderFailure(this.message);
}
