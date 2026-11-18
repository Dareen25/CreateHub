import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.isPassword = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool isPassword;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    obscureText: isPassword,
    keyboardType: isPassword
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    autofillHints: [isPassword ? AutofillHints.password : AutofillHints.email],
    decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
  );
}
