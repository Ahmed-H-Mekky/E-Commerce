import 'package:e_commerce/model/map_country.dart';
import 'package:flutter/material.dart';

class CustomDropDownButtonField extends StatelessWidget {
  const CustomDropDownButtonField({
    super.key,
    required this.initialValue,
    required this.onchange,
  });
  final dynamic initialValue;
  final void Function(dynamic) onchange;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.7),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.7),
        ),
      ),
      initialValue: initialValue,
      items: countryCodes.keys.map((selectText) {
        return DropdownMenuItem(value: selectText, child: Text(selectText));
      }).toList(),
      onChanged: onchange,
    );
  }
}
