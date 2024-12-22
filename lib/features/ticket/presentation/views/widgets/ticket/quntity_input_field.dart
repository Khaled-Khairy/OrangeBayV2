import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orange_bay/core/widgets/text_form_field.dart';

class QuantityInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const QuantityInputField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hint: hint,
      type: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      enabledColor: const Color(0xFF427FB8),
      focusColor: const Color(0xFF427FB8),
      validate: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the $hint';
        }
        return null;
      },
    );
  }
}
