import 'package:flutter/material.dart';

import 'component.dart';
import 'edit_text_field.dart';

class RegisterTextField extends StatelessWidget {

  final IconData icon;
  final TextEditingController? controller;
  final String lableText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const RegisterTextField({
    super.key,
    required this.icon,
    this.controller,
    required this.lableText,
    required this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        defContainerWithIcon(
          icon: icon,
        ),
        Expanded(
          child: EditTextField(
            lableText: lableText,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
