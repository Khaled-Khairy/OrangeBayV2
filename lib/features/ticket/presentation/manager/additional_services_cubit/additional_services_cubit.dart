import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:orange_bay/features/ticket/data/models/additional_services_model.dart';
import 'package:orange_bay/features/ticket/data/repos/ticket_repo.dart';
import 'package:orange_bay/features/ticket/data/repos/ticket_repo_impl.dart';

part 'additional_services_state.dart';

class AdditionalServicesCubit extends Cubit<AdditionalServicesState> {
  AdditionalServicesCubit() : super(AdditionalServicesInitial());
  final TicketRepo ticketRepo = TicketRepoImpl();

  Future<void> getAdditionalServices() async {
    emit(AdditionalServicesLoading());
    final result = await ticketRepo.getAdditionalServices();
    result.fold(
      (failure) => emit(AdditionalServicesFailure(failure.message)),
      (additionalServices) => emit(AdditionalServicesSuccess(additionalServices)),
    );
  }
}
