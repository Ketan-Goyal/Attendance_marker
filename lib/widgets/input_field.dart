import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const InputText(
      {super.key, required this.hintText, required this.controller});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          // fillColor: Colors.grey.shade100,
          filled: true,
          hintText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
