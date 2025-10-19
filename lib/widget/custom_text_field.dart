import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  const Customtextfield({
    super.key,
    required this.icon,
    required this.textHint,
    required this.textEditingController,
  });

  final Icon icon;
  final Text textHint;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, right: 8, left: 8),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 2),
          ),
          suffixIcon: icon,
          hint: textHint,
        ),
        controller: textEditingController,
      ),
    );
  }
}
