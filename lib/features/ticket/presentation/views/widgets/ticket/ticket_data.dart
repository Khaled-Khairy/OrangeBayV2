import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/features/ticket/data/models/tickets_model.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/widgets/ticket/custom_drop_down.dart';

class TicketData extends StatefulWidget {
  const TicketData({super.key});

  @override
  State<TicketData> createState() => _TicketDataState();
}

class _TicketDataState extends State<TicketData> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      builder: (context, state) {
        final cubit = context.read<TicketCubit>();
        if(state is TicketLoading){
          return CircularProgressIndicator(color: AppColors.blue,);
        }else if(state is TicketFailure){
          return Center(child: Text(state.message),);
        }else if(state is TicketSuccess){
          return Column(
            children: [
              CustomDropdown<Nationality>(
                label: 'Nationality',
                items: state.ticketsModel.nationalityDtos,
                itemName: (item) => item.name,
                selectedItem: cubit.selectedNationality,
                onChanged: (value) {
                  setState(() {
                    cubit.selectedNationality = value;
                  });
                },
              ),
              CustomDropdown<Harbour>(
                label: 'Harbour',
                items: state.ticketsModel.harbour,
                itemName: (item) => item.name,
                selectedItem: cubit.selectedHarbour,
                onChanged: (value) {
                  setState(() {
                    cubit.selectedHarbour = value;
                  });
                },
              ),
              CustomDropdown<TourGuide>(
                label: 'Guide Name',
                items: state.ticketsModel.tourGuideDtos,
                itemName: (item) => item.name,
                selectedItem: cubit.selectedGuide,
                onChanged: (value) {
                  setState(() {
                    cubit.selectedGuide = value;
                  });
                },
              ),
              CustomDropdown<Cruise>(
                label: 'Boat Name',
                items: state.ticketsModel.cruises,
                itemName: (item) => item.name,
                selectedItem: cubit.selectedCruise,
                onChanged: (value) {
                  setState(() {
                    cubit.selectedCruise = value;
                  });
                },
              ),
            ],
          );

        }else{
          return Text("Unexpected Error");
        }
      },
    );
  }
}
