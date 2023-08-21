import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final String label;
  final IconData icon;
  const MyTextField({super.key, required this.hint, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    bool isPassword = true;
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)
        ),

      ),
    );
  }
}
