import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool digitsOnly;
  final int? maxLength;
  final String? Function(String? value)? validator;

  const CustomTextFormField({
    required this.label,
    required this.controller,
    required this.isPassword,
    this.digitsOnly = false,
    this.validator,
    this.maxLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          digitsOnly ? TextInputType.number : TextInputType.emailAddress,
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      inputFormatters: [
        if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(
        label: Text(label),
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
