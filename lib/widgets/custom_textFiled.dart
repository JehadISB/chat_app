import 'package:flutter/material.dart';

class CustomTextFormfiled extends StatelessWidget {
  const CustomTextFormfiled(
      {this.hintText, this.onChanged, this.obscureText = false});
  final String? hintText;
  final Function(String)? onChanged;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) return "Error: this is required field!";
      },
      obscureText: obscureText!,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
