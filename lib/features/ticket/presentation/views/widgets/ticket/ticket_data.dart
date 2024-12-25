import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/custom_drop_down.dart';

class TicketData extends StatelessWidget {
  const TicketData({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TicketCubit>();
    return Column(
      children: [
        CustomDropdown<Nationality>(
          label: 'Nationality',
          items: cubit.ticketsModel!.nationalityDtos,
          itemName: (item) => item.name,
          selectedItem: cubit.selectedNationality,
          onChanged: (value) {
            cubit.selectedNationality = value;
          },
        ),
        CustomDropdown<Harbour>(
          label: 'Harbour',
          items: cubit.ticketsModel!.harbour,
          itemName: (item) => item.name,
          selectedItem: cubit.selectedHarbour,
          onChanged: (value) {
            cubit.selectedHarbour = value;
          },
        ),
        CustomDropdown<TourGuide>(
          label: 'Guide Name',
          items: cubit.ticketsModel!.tourGuideDtos,
          itemName: (item) => item.name,
          selectedItem: cubit.selectedGuide,
          onChanged: (value) {
            cubit.selectedGuide = value;
          },
        ),
        CustomDropdown<Cruise>(
          label: 'Boat Name',
          items: cubit.ticketsModel!.cruises,
          itemName: (item) => item.name,
          selectedItem: cubit.selectedCruise,
          onChanged: (value) {
            cubit.selectedCruise = value;
          },
        ),
      ],
    );
  }
}
