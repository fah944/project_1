import 'package:flutter/material.dart';
import '../styles/colors/colors.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String lableText;
  //final String initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const EditTextField({
    super.key,
    this.controller,
    required this.lableText,
    //required this.initialValue,
    this.validator,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        end: 20.0,
      ),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
              width: .5,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: color4,
              width: .5,
            ),
          ),
          label: Text(
            lableText,
          ),
          labelStyle: TextStyle(
            fontSize: 17.0,
            color: Colors.grey[500],
          ),
          contentPadding: const EdgeInsetsDirectional.only(
            start: 15.0,
            bottom: 20.0
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        //initialValue: initialValue,
        style: const TextStyle(
          color: color5,
        ),
        controller: controller,
        cursorColor: color4,
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
