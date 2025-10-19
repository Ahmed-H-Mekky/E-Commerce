import 'package:flutter/material.dart';

class CustomtextFieldSignin extends StatelessWidget {
  const CustomtextFieldSignin({
    super.key,
    required this.texthint,
    required this.textEditingController,
    required this.textInputType,
  });
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final Text texthint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: .07),
        ),
        hint: texthint,
      ),
      keyboardType: textInputType,
      controller: textEditingController,
    );
  }
}
