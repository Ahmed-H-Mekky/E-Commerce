import 'package:flutter/material.dart';

void showSnakeBare({required BuildContext context, required Text message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: message));
}
