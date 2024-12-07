import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final String Function(T) itemName;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.itemName,
    this.selectedItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Center(
          child: DropdownButtonFormField<T>(
            value: selectedItem,
            onChanged: onChanged,
            validator: (value) {
              if (value == null) {
                return 'Please select a $label';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              ),
            ),
            items: items.map(
              (item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemName(item),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ).toList(),
            hint: Text(
              'Select $label',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ],
    );
  }
}
