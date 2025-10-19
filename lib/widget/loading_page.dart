import 'package:e_commerce/Screen/opt.dart';
import 'package:e_commerce/helps/showe_snake_bare.dart';
import 'package:flutter/material.dart';

class LoadingPage {
  static Future<String> formatNumber({
    required String countryCode,
    required String phoneNumber,
  }) async {
    phoneNumber = phoneNumber.trim();
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }
    return countryCode + phoneNumber;
  }

  static Future<void> loading({
    required BuildContext context,
    required TextEditingController countryCode,
    required TextEditingController phoneNumber,
    required Function(bool) setloading,
  }) async {
    if (phoneNumber.text.isEmpty || countryCode.text.isEmpty) {
      showSnakeBare(
        context: context,
        message: const Text('الرجاء إدخال رقم الهاتف ورمز الدولة'),
      );
      return;
    } else {
      setloading(true);
      final formattedNumber = await formatNumber(
        countryCode: countryCode.text,
        phoneNumber: phoneNumber.text,
      );
      await Future.delayed(Duration(seconds: 2));
      if (context.mounted) {
        setloading(false);
        Navigator.of(context).pushNamed(Opt.id, arguments: formattedNumber);
        phoneNumber.clear();
      }
    }
  }
}
