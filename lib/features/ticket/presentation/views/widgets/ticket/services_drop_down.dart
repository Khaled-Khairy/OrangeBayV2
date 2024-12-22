import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:orange_bay/features/ticket/data/models/additional_services_model.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesDropdown extends StatefulWidget {
  final List<AdditionalServicesModel> additionalServices;
  final String type;
  final ValueChanged<List<AdditionalServicesModel>>
      onServiceSelected; // Callback
  const ServicesDropdown({
    super.key,
    required this.type,
    required this.onServiceSelected,
    required this.additionalServices,
  });

  @override
  State<ServicesDropdown> createState() => _ServicesDropdownState();
}

class _ServicesDropdownState extends State<ServicesDropdown> {
  late MultiSelectController<AdditionalServicesModel> controller;

  @override
  void initState() {
    super.initState();
    controller = MultiSelectController<AdditionalServicesModel>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiDropdown(
      items:
          widget.additionalServices.where((service) => service.status == 1).map(
        (service) {
          return DropdownItem<AdditionalServicesModel>(
            value: service,
            label:
                '${service.name} - Price: ${widget.type == 'adult' ? service.adultPrice : service.childPrice}',
          );
        },
      ).toList(),
      controller: controller,
      onSelectionChange: (selectedItems) {
        widget.onServiceSelected(selectedItems);
      },
      dropdownDecoration: DropdownDecoration(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        elevation: 2,
      ),
      fieldDecoration: FieldDecoration(
        borderRadius: 5.r,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
            color: AppColors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: const BorderSide(
            color: AppColors.blue,
          ),
        ),
        hintText: 'Additional Services',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.grey,
        ),
      ),
    );
  }
}
