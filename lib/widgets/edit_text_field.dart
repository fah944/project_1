import 'package:flutter/material.dart';
import '../core/styles/colors/colors.dart';
import '../styles/colors/colors.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  //final String initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function? onPressed;
  final bool? enabled;
  final double? suffixSize;

  const EditTextField({
    super.key,
    this.controller,
    required this.hintText,
    //required this.initialValue,
    this.validator,
    required this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    this.onPressed,
    this.enabled,
    this.suffixSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        end: 20.0,
      ),
      child: TextFormField(
        enabled: enabled,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
              width: .5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade100,
              width: .5,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: defaultColor.withOpacity(.6),
            fontSize: 20,
          ),
          contentPadding: const EdgeInsetsDirectional.only(
            bottom: 20.0
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.grey[400],
          ),
          suffixIcon: suffixIcon != null ? IconButton(onPressed: (){ onPressed!();}, icon: Icon(suffixIcon, size: suffixSize ?? 25,
            color: defaultColor2,)) : null,
        ),
        obscureText: obscureText ?? false,
        //initialValue: initialValue,
        controller: controller,
        cursorColor: Colors.black,
        validator: validator ??
                (value) {
              if (value?.isEmpty ?? true) {
                return 'this field must not be empty';
              }
              return null;
            },
      ),
    );
  }
}
