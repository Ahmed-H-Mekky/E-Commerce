import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.textSpanString,
    required this.textSpanBotton,
    this.onTap,
    required this.textAlign,
  });
  final String textSpanString;
  final String textSpanBotton;
  final void Function()? onTap;
  final TextAlign? textAlign; // سطر مضاف

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: textSpanString,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          TextSpan(
            text: textSpanBotton,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
