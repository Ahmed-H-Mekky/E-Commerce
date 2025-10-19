import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatelessWidget {
  CustomPinput({super.key, required this.pinController});
  final TextEditingController pinController;

  // 🎨 تعريف الثيم مع خط سفلي فقط بدل المربع
  final themepinut = PinTheme(
    width: 50,
    height: 60,
    margin: const EdgeInsets.all(8),
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.blue, // لون الخط السفلي
          width: 2, // سمك الخط
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focustheme = themepinut.copyWith(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.orange, // لون الخط عند التركيز
            width: 2,
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Pinput(
        controller: pinController,
        length: 6,
        defaultPinTheme: themepinut,
        focusedPinTheme: focustheme,
        onCompleted: (value) {
          pinController.text = value;
        },
      ),
    );
  }
}
