import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hint,
    required this.labeltextt,
    required this.obscure,
    this.icon,
    required this.onchange,
  });
  String labeltextt;
  bool obscure;
  String hint;
  Widget? icon;
  TextEditingController controller = TextEditingController();
  Function(String) onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
        controller.clear();
      },
      onChanged: onchange,
      obscureText: obscure,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labeltextt,
        suffixIcon: icon,
        hintText: hint,
      ),
    );
  }
}
//Icon(Icons.password)