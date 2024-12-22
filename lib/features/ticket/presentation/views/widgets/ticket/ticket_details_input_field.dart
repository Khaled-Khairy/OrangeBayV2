import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orange_bay/core/utils/app_colors.dart';
import 'package:orange_bay/core/widgets/text_form_field.dart';

class TicketDetailsInputField extends StatelessWidget {
  const TicketDetailsInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.type,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hint: hint,
      enabledColor: AppColors.grey,
      type: type,
      inputFormatters: inputFormatters,
      focusColor: const Color(0xFF427FB8),
      autoValidateMode: AutovalidateMode.disabled,
      validate: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the $hint';
        }
        return null;
      },
    );
  }
}
