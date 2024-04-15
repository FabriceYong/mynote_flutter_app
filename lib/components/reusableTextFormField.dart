import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  const ReusableTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      // required this.onChange,
      this.passwordIconChanged,
      this.suffixIconButton,
      this.obscureText = false});

  final void Function()? passwordIconChanged;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final Widget? suffixIconButton;
  // final Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: true,
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(color: Colors.grey.shade800),
      decoration: InputDecoration(
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            prefixIcon,
            color: Colors.grey.shade600,
          ),
        ),
        suffixIcon: suffixIconButton,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF019E79)),
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        labelText: labelText,
        floatingLabelStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'All form fields are required';
        } else {
          return null;
        }
      },
    );
  }
}
